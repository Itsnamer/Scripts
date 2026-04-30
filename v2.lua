return {
	LoadUI = function()

		local LocalPlayer = game.Players.LocalPlayer
		local UserInputed = game:GetService("UserInputService")

		local ExistingUi = game.CoreGui:FindFirstChild("Pictures Kaitun")
		if ExistingUi then
			ExistingUi:Destroy()
		end

		local MainGui = Instance.new("ScreenGui", game.CoreGui)
		MainGui.Name = "Pictures Kaitun"
		MainGui.IgnoreGuiInset = true
		MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

		local BaseGui = Instance.new("Frame", MainGui)
		BaseGui.BackgroundColor3 = Color3.new(0, 0, 0)
		BaseGui.BackgroundTransparency = 0.2
		BaseGui.Size = UDim2.new(1, 0, 1, 0)

		local IsSmall = false
		local ScreenSize = workspace.CurrentCamera.ViewportSize
		if ScreenSize.X <= 1000 then
			IsSmall = true
		end

		local TitlePos, TitleSize, TitleText
		local StatusPos, StatusSize, StatusText
		local InfoPos, InfoSize, InfoText
		local ItemPos, ItemSize, ItemText

		if IsSmall then
			TitlePos = UDim2.new(0.5, -150, 0, 30)
			TitleSize = UDim2.new(0, 300, 0, 35)
			TitleText = 30

			StatusPos = UDim2.new(0.5, -150, 0, 75)
			StatusSize = UDim2.new(0, 300, 0, 25)
			StatusText = 20

			InfoPos = UDim2.new(0.5, -220, 0, 110)
			InfoSize = UDim2.new(0, 440, 0, 25)
			InfoText = 18

			ItemPos = UDim2.new(0.5, -180, 0, 145)
			ItemSize = UDim2.new(0, 360, 0, 25)
			ItemText = 18
		else
			TitlePos = UDim2.new(0.5, -280, 0, 50)
			TitleSize = UDim2.new(0, 560, 0, 45)
			TitleText = 30

			StatusPos = UDim2.new(0.5, -200, 0, 130)
			StatusSize = UDim2.new(0, 400, 0, 30)
			StatusText = 20

			InfoPos = UDim2.new(0.5, -300, 0, 190)
			InfoSize = UDim2.new(0, 600, 0, 30)
			InfoText = 20

			ItemPos = UDim2.new(0.5, -250, 0, 250)
			ItemSize = UDim2.new(0, 500, 0, 30)
			ItemText = 20
		end

		local TitleGui = Instance.new("TextLabel", BaseGui)
		TitleGui.Position = TitlePos
		TitleGui.Size = TitleSize
		TitleGui.Text = "Pictures Hub Kaitun"
		TitleGui.Font = Enum.Font.FredokaOne
		TitleGui.TextSize = TitleText
		TitleGui.TextColor3 = Color3.fromRGB(255, 255, 255)
		TitleGui.BackgroundTransparency = 1

		local StatusGui = Instance.new("TextLabel", BaseGui)
		StatusGui.Position = StatusPos
		StatusGui.Size = StatusSize
		StatusGui.Font = Enum.Font.FredokaOne
		StatusGui.TextSize = StatusText
		StatusGui.TextColor3 = Color3.fromRGB(0, 81, 255)
		StatusGui.BackgroundTransparency = 1
		StatusGui.Text = "Doing Status : Waiting..."

		local InfoGui = Instance.new("TextLabel", BaseGui)
		InfoGui.Position = InfoPos
		InfoGui.Size = InfoSize
		InfoGui.Text = "Loading Info..."
		InfoGui.Font = Enum.Font.FredokaOne
		InfoGui.TextSize = InfoText
		InfoGui.TextColor3 = Color3.fromRGB(255, 255, 0)
		InfoGui.BackgroundTransparency = 1
		InfoGui.TextWrapped = true

		local ItemGui = Instance.new("TextLabel", BaseGui)
		ItemGui.Position = ItemPos
		ItemGui.Size = ItemSize
		ItemGui.Text = "Painting Tool : ❌ | Binding Tool : ❌ | Property Tool : ❌ | Scaling Tool : ❌ | Trowel Tool : ❌"
		ItemGui.Font = Enum.Font.FredokaOne
		ItemGui.TextSize = ItemText
		ItemGui.TextColor3 = Color3.new(1, 0, 0)
		ItemGui.BackgroundTransparency = 1

		local Layouted = function()
			local ScreenSize = workspace.CurrentCamera.ViewportSize
			local IsSmall = ScreenSize.X <= 1000

			if IsSmall then
				TitleGui.Position = UDim2.new(0.5, -150, 0, 30)
				TitleGui.Size = UDim2.new(0, 300, 0, 35)
				TitleGui.TextSize = 30

				StatusGui.Position = UDim2.new(0.5, -150, 0, 75)
				StatusGui.Size = UDim2.new(0, 300, 0, 25)
				StatusGui.TextSize = 20

				InfoGui.Position = UDim2.new(0.5, -220, 0, 110)
				InfoGui.Size = UDim2.new(0, 440, 0, 25)
				InfoGui.TextSize = 18

				ItemGui.Position = UDim2.new(0.5, -180, 0, 145)
				ItemGui.Size = UDim2.new(0, 360, 0, 25)
				ItemGui.TextSize = 18
			else
				TitleGui.Position = UDim2.new(0.5, -280, 0, 50)
				TitleGui.Size = UDim2.new(0, 560, 0, 45)
				TitleGui.TextSize = 30

				StatusGui.Position = UDim2.new(0.5, -200, 0, 130)
				StatusGui.Size = UDim2.new(0, 400, 0, 30)
				StatusGui.TextSize = 20

				InfoGui.Position = UDim2.new(0.5, -300, 0, 190)
				InfoGui.Size = UDim2.new(0, 600, 0, 30)
				InfoGui.TextSize = 20

				ItemGui.Position = UDim2.new(0.5, -250, 0, 250)
				ItemGui.Size = UDim2.new(0, 500, 0, 30)
				ItemGui.TextSize = 20
			end
		end

		Layouted()

		workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
			Layouted()
		end)

		function Statusing(text)
			StatusGui.Text = "Doing Status : " .. tostring(text)
		end

    CheckInventory = function(args)
    	for _, ToolName in pairs(args) do
    		if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(ToolName)
    		or game:GetService("Players").Character:FindFirstChild(ToolName) then
    			return true
    		end
    	end
    
    	return false
    end

		task.spawn(function()
			while true do
				local HasPainting = CheckInventory("PaintingTool")
				local HasBinding = CheckInventory("BindTool")
				local HasProperty = CheckInventory("PropertiesTool")
				local HasScaling = CheckInventory("ScalingTool")
				local HasTrowel = CheckInventory("TrowelTool")

				ItemGui.Text = "Painting Tool : " .. (HasPainting and "✅" or "❌") ..
					" | Binding Tool : " .. (HasBinding and "✅" or "❌") ..
					" | Property Tool : " .. (HasProperty and "✅" or "❌") ..
					" | Scaling Tool : " .. (HasScaling and "✅" or "❌") ..
					" | Trowel Tool : " .. (HasTrowel and "✅" or "❌")

				local Money = LocalPlayer.Data.Gold.Value or "?"

				InfoGui.Text = "Name : " .. LocalPlayer.Name ..
					" | Money : " .. tostring(Money) ..
				task.wait(5)
			end
		end)
		
		UserInputed.InputBegan:Connect(function(Input,Processed)
			if Processed then return end
			if Input.KeyCode == Enum.KeyCode.RightControl then
				MainGui.Enabled = not MainGui.Enabled
			end
		end)
	end
}
