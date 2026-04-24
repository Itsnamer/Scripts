return {
	LoadUI = function()
		local TweenService = game:GetService("TweenService")
		local VirtualInputManager = game:GetService("VirtualInputManager")
		local CoreGui = game:GetService("CoreGui")

		if CoreGui:FindFirstChild("ImageButton") then
			CoreGui:FindFirstChild("ImageButton"):Destroy()
		end

		local ScreenGui = Instance.new("ScreenGui")
		ScreenGui.Name = "ImageButton"
		ScreenGui.Parent = CoreGui
		ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

		local ImageButton = Instance.new("ImageButton")
		ImageButton.Parent = ScreenGui
		ImageButton.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
		ImageButton.BorderSizePixel = 10
		ImageButton.BorderColor3 = Color3.fromRGB(23, 23, 23)
		ImageButton.Position = UDim2.new(0.10, 0, 0.15, 0)
		ImageButton.Size = UDim2.new(0, 50, 0, 50)
		ImageButton.Draggable = true
		ImageButton.AutoButtonColor = false
		ImageButton.Image = ""

		local Logo = Instance.new("ImageLabel")
		Logo.Parent = ImageButton
		Logo.Size = UDim2.new(0, 30, 0, 30)
		Logo.Position = UDim2.new(0.5, -15, 0.5, -15)
		Logo.BackgroundTransparency = 1
		Logo.Image = "rbxassetid://136262031660297"
		Logo.ScaleType = Enum.ScaleType.Fit

		local UICorner = Instance.new("UICorner")
		UICorner.Parent = ImageButton
		UICorner.CornerRadius = UDim.new(0, 18)

		local ClickAnimation = function()
			local OriginalSize = ImageButton.Size
			local ShrinkTween = TweenService:Create(
				ImageButton,
				TweenInfo.new(0.05),
				{ Size = UDim2.new(0, 45, 0, 45) }
			)
			local growTween = TweenService:Create(
				ImageButton,
				TweenInfo.new(0.05),
				{ Size = OriginalSize }
			)

			ShrinkTween:Play()
			ShrinkTween.Completed:Connect(function()
				growTween:Play()
			end)
		end

		ImageButton.MouseButton1Down:Connect(function()
			ClickAnimation()

			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.RightControl, false, game)
		end)
	end
}
