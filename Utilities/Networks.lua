getgenv().network = network or {
	cache = {
		connections = {
			insert = function(self,value)
				self[#self + 1] = value
			end,
			clear = function(self)
				for i=1,#self do local v = self[i]
					if type(v) ~= "function" then
						v:Disconnect()
						table.remove(self,table.find(self,v))
					end
				end
			end,
		},
		remotes = {
			insert = function(self,value)
				self[#self + 1] = value
			end,
		},
	},
	Retrieve = function(self,name,func)
		local Remote = self.cache.remotes[name] or (typeof(name) == "Instance" and name) or game:FindFirstChild(name,true)
		if Remote then
			if Remote:IsA("RemoteEvent") then
				self.cache.connections:insert(Remote.OnClientEvent:Connect(func))
				self.cache.remotes[name] = Remote
			elseif Remote:IsA("RemoteFunction") then
				Remote.OnClientInvoke = func
				self.cache.connections:insert(Remote.OnClientInvoke)
				self.cache.remotes[name] = Remote
			else
				warn("Unable to Connect Network")
			end
		else
			warn("Unable to Indentify Remote Network")
		end
	end,
	Send = function(self, name, ...)
		local success, result = pcall(function(...)
			local Remote = self.cache.remotes[name] or (typeof(name) == "Instance" and name) or game:FindFirstChild(name, true)
			if Remote then
				if Remote:IsA("RemoteEvent") then
					self.cache.remotes[name] = Remote
					Remote:FireServer(...)
				elseif Remote:IsA("RemoteFunction") then
					self.cache.remotes[name] = Remote
					return Remote:InvokeServer(...)
				else
					error("Unable to Connect Network")
				end
			else
				error("Unable to Identify Remote Network")
			end
		end, ...)
		if not success then
			warn("Error in Send function:", result)
		end
		return result
	end,
}
