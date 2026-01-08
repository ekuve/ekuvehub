local Module = {}

function Module.Execute(Hub_Script_ID)
    repeat
        task.wait()
    until game:IsLoaded()

    local Hub = "Ekuve hub"
    local copy_link = "https://ekuve-hub-key.lovable.app"

    local API = loadstring(game:HttpGet("https://sdkAPI-public.luarmor.net/library.lua"))()
    API.script_id = Hub_Script_ID

    local TweenService = game:GetService("TweenService")
    local Players = game:GetService("Players")

    makefolder(Hub)
    local key_path = Hub.."/Key.txt"
    local saved_key = isfile(key_path) and readfile(key_path) or nil

    local function checkKey(input_key)
        local status = API.check_key(input_key)
        
        if status.code == "KEY_VALID" then
            writefile(key_path, input_key)
            return true, "Key is valid"
        elseif status.code == "KEY_HWID_LOCKED" then
            return false, "Key linked to different HWID"
        elseif status.code == "KEY_INCORRECT" then
            return false, "Key is incorrect"
        elseif status.code == "KEY_INVALID" then
            return false, "Key is invalid"
        else
            return false, "Unknown error: " .. (status.message or status.code)
        end
    end

    local IsValidSavedKey = false
    if saved_key then
        local success, message = checkKey(saved_key)
        if success then
            IsValidSavedKey = true
            script_key = saved_key
            API.load_script()
            return
        end
    end

    if not IsValidSavedKey then
        local Blur = Instance.new("BlurEffect")
        Blur.Parent = game:GetService("Lighting")
        Blur.Size = 20
        
        local EkuveKeySystem = Instance.new("ScreenGui")
        EkuveKeySystem.Name = "EkuveKeySystem"
        EkuveKeySystem.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        EkuveKeySystem.IgnoreGuiInset = true
        EkuveKeySystem.Parent = game.CoreGui or Players.LocalPlayer:WaitForChild("PlayerGui")
        EkuveKeySystem.DisplayOrder = 10

        local Container = Instance.new("CanvasGroup")
        Container.Name = "Container"
        Container.Size = UDim2.new(1, 0, 1, 0)
        Container.BackgroundColor3 = Color3.new(1, 1, 1)
        Container.BackgroundTransparency = 1
        Container.BorderSizePixel = 0
        Container.GroupTransparency = 1
        Container.BorderColor3 = Color3.new(0, 0, 0)
        Container.Parent = EkuveKeySystem

        local Background = Instance.new("Frame")
        Background.Name = "Background"
        Background.Size = UDim2.new(1, 0, 1, 0)
        Background.BackgroundColor3 = Color3.new(0, 0, 0)
        Background.BackgroundTransparency = 0.3
        Background.BorderSizePixel = 0
        Background.BorderColor3 = Color3.new(0, 0, 0)
        Background.Parent = Container

        local Frame = Instance.new("Frame")
        Frame.Name = "Frame"
        Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
        repeat
            task.wait()
        until workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize and workspace.CurrentCamera.ViewportSize.X > 1 and workspace.CurrentCamera.ViewportSize.Y > 1
        local screenX = workspace.CurrentCamera.ViewportSize.X
        local screenY = workspace.CurrentCamera.ViewportSize.Y
        Frame.Size = UDim2.fromOffset(
            math.min(576*0.8, screenX*0.5), 
            math.min(324*0.8, screenY*0.5)
        )
        Frame.BackgroundColor3 = Color3.new(0, 0, 0.152941)
        Frame.BackgroundTransparency = 0.1
        Frame.BorderSizePixel = 0
        Frame.BorderColor3 = Color3.new(0, 0, 0)
        Frame.ZIndex = 3
        Frame.AnchorPoint = Vector2.new(0.5, 0.5)
        Frame.Parent = Container

        local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
        UIAspectRatioConstraint.AspectRatio = 1.600000023841858
        UIAspectRatioConstraint.Parent = Frame

        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0.05, 0)
        UICorner.Parent = Frame

        local Title = Instance.new("TextLabel")
        Title.Name = "Title"
        Title.Position = UDim2.new(0.0296763, 0, 0, 0)
        Title.Size = UDim2.new(0.970324, 0, 0.15, 0)
        Title.BackgroundColor3 = Color3.new(1, 1, 1)
        Title.BackgroundTransparency = 1
        Title.BorderSizePixel = 0
        Title.BorderColor3 = Color3.new(0, 0, 0)
        Title.Text = "Ekuve hub"
        Title.TextColor3 = Color3.new(1, 1, 1)
        Title.TextSize = 14
        Title.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
        Title.TextScaled = true
        Title.TextWrapped = true
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.Parent = Frame

        local Close = Instance.new("TextButton")
        Close.Name = "Close"
        Close.Position = UDim2.new(0.98, 0, 0.03, 0)
        Close.Size = UDim2.new(0.125, 0, 0.125, 0)
        Close.BackgroundColor3 = Color3.new(1, 0, 0.0156863)
        Close.BackgroundTransparency = 0.699999988079071
        Close.BorderSizePixel = 0
        Close.BorderColor3 = Color3.new(0, 0, 0)
        Close.AnchorPoint = Vector2.new(1, 0)
        Close.Text = "X"
        Close.TextColor3 = Color3.new(1, 1, 1)
        Close.TextSize = 14
        Close.FontFace = Font.new("rbxasset://fonts/families/Sarpanch.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
        Close.TextScaled = true
        Close.TextWrapped = true
        Close.Parent = Frame

        local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint")
        UIAspectRatioConstraint2.Parent = Close

        local UICorner2 = Instance.new("UICorner")
        UICorner2.CornerRadius = UDim.new(0.2, 0)
        UICorner2.Parent = Close
        
        local Description = Instance.new("TextLabel")
        Description.Name = "Description"
        Description.Position = UDim2.new(0.5, 0, 0.28+0.02, 0)
        Description.Size = UDim2.new(0.85, 0, 0.10, 0)
        Description.BackgroundTransparency = 1
        Description.BorderSizePixel = 0
        Description.AnchorPoint = Vector2.new(0.5, 0.5)
        Description.Text = "Join our Discord server to get your key"
        Description.TextColor3 = Color3.new(1, 1, 1)
        Description.TextSize = 14
        Description.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        Description.TextScaled = true
        Description.TextWrapped = true
        Description.TextTransparency = 0
        Description.Parent = Frame
        Description.RichText = true

        local UICorner6 = Instance.new("UICorner")
        UICorner6.CornerRadius = UDim.new(0.15, 0)
        UICorner6.Parent = Description

        local Enterkey = Instance.new("TextBox")
        Enterkey.Name = "Enterkey"
        Enterkey.Position = UDim2.new(0.5, 0, 0.459291+0.05, 0)
        Enterkey.Size = UDim2.new(0.7, 0, 0.169507, 0)
        Enterkey.BackgroundColor3 = Color3.new(0.596078, 0.596078, 0.596078)
        Enterkey.BackgroundTransparency = 0.699999988079071
        Enterkey.BorderSizePixel = 0
        Enterkey.BorderColor3 = Color3.new(0, 0, 0)
        Enterkey.AnchorPoint = Vector2.new(0.5, 0.5)
        Enterkey.Text = ""
        Enterkey.TextColor3 = Color3.new(1, 1, 1)
        Enterkey.TextSize = 14
        Enterkey.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        Enterkey.TextScaled = true
        Enterkey.TextWrapped = true
        Enterkey.ClearTextOnFocus = false
        Enterkey.PlaceholderText = "Enter key"
        Enterkey.Parent = Frame
        
        local UICorner3 = Instance.new("UICorner")
        UICorner3.CornerRadius = UDim.new(0.2, 0)
        UICorner3.Parent = Enterkey

        local Link = Instance.new("TextButton")
        Link.Name = "Link"
        Link.Position = UDim2.new(0.14881, 0, 0.739626, 0)
        Link.Size = UDim2.new(0.335139, 0, 0.153009, 0)
        Link.BackgroundColor3 = Color3.new(0.447059, 0.501961, 1)
        Link.BackgroundTransparency = 0.7
        Link.BorderSizePixel = 0
        Link.BorderColor3 = Color3.new(0, 0, 0)
        Link.Text = "Copy link"
        Link.TextColor3 = Color3.new(1, 1, 1)
        Link.TextSize = 14
        Link.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        Link.TextScaled = true
        Link.TextWrapped = true
        Link.Parent = Frame

        local UICorner4 = Instance.new("UICorner")
        UICorner4.CornerRadius = UDim.new(0.2, 0)
        UICorner4.Parent = Link

        local Redeem = Instance.new("TextButton")
        Redeem.Name = "Redeem"
        Redeem.Position = UDim2.new(0.514069, 0, 0.739626, 0)
        Redeem.Size = UDim2.new(0.335139, 0, 0.153009, 0)
        Redeem.BackgroundColor3 = Color3.new(0.34902, 0.713726, 0.321569)
        Redeem.BackgroundTransparency = 0.699999988079071
        Redeem.BorderSizePixel = 0
        Redeem.BorderColor3 = Color3.new(0, 0, 0)
        Redeem.Text = "Redeem"
        Redeem.TextColor3 = Color3.new(1, 1, 1)
        Redeem.TextSize = 14
        Redeem.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        Redeem.TextScaled = true
        Redeem.TextWrapped = true
        Redeem.Parent = Frame

        local UICorner5 = Instance.new("UICorner")
        UICorner5.CornerRadius = UDim.new(0.2, 0)
        UICorner5.Parent = Redeem

        local UIGradient = Instance.new("UIGradient")
        UIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.552941, 0.552941, 0.552941))})
        UIGradient.Parent = Frame

        local ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Name = "ImageLabel"
        ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
        ImageLabel.Size = UDim2.fromOffset(Frame.AbsoluteSize.X * 2.15, Frame.AbsoluteSize.Y * 2.15)
        Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            ImageLabel.Size = UDim2.fromOffset(Frame.AbsoluteSize.X * 2.15, Frame.AbsoluteSize.Y * 2.15)
        end)
        ImageLabel.BackgroundColor3 = Color3.new(0, 0, 0.266667)
        ImageLabel.BackgroundTransparency = 1
        ImageLabel.BorderSizePixel = 0
        ImageLabel.BorderColor3 = Color3.new(0, 0, 0)
        ImageLabel.ZIndex = 2
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        ImageLabel.Image = "rbxassetid://81996511470334"
        ImageLabel.ImageColor3 = Color3.new(0, 0, 0.152941)
        ImageLabel.ImageTransparency = 0.5
        ImageLabel.Parent = Container

        TweenService:Create(Container, TweenInfo.new(0.3), {GroupTransparency = 0}):Play()

        Close.MouseButton1Click:Connect(function()
            TweenService:Create(Container, TweenInfo.new(0.3), {GroupTransparency = 1}):Play()
            TweenService:Create(Blur, TweenInfo.new(0.3), {Size = 0}):Play()
            task.wait(0.3)
            EkuveKeySystem:Destroy()
            Blur:Destroy()
        end)

        Enterkey.Focused:Connect(function()
            TweenService:Create(Enterkey, TweenInfo.new(0.1), {BackgroundTransparency = 0.6, TextColor3 = Color3.new(0.733333, 0.733333, 1)}):Play()
        end)

        Enterkey.FocusLost:Connect(function()
            TweenService:Create(Enterkey, TweenInfo.new(0.1), {BackgroundTransparency = 0.7, TextColor3 = Color3.new(1, 1, 1)}):Play()
        end)

        local LinkAnimation = false
        Link.MouseButton1Click:Connect(function()
            if LinkAnimation then return end
            LinkAnimation = true
                    
            setclipboard(copy_link)
            Link.Text = "Copied link"

            task.wait(2)
            Link.Text = "Copy link"
            LinkAnimation = false
        end)
        
        local CorrectKey = false
        local RedeemAnimation = false
        
        Redeem.MouseButton1Click:Connect(function()
            if RedeemAnimation then return end
            RedeemAnimation = true
            
            local Checked = false
            
            Redeem.Text = "Checking..."
            TweenService:Create(Redeem, TweenInfo.new(0.1), {BackgroundColor3 = Color3.new(0.337255, 0.341176, 0.713725)}):Play()
            
            coroutine.wrap(function()
                local i = 1
                while not Checked do
                    i += 1
                    if i == 4 then i = 1 end
                    Redeem.Text = "Checking" .. string.rep(".", i)
                    task.wait(0.3)
                end
            end)()
            
            local Key = Enterkey.Text
            local success, message = checkKey(Key)
            Checked = true

            if success then
                Redeem.Text = "Success"
                CorrectKey = true
                TweenService:Create(Redeem, TweenInfo.new(0.1), {BackgroundColor3 = Color3.new(0.415686, 1, 0.384314)}):Play()
                task.wait(0.5)
                TweenService:Create(Container, TweenInfo.new(0.3), {GroupTransparency = 1}):Play()
                TweenService:Create(Blur, TweenInfo.new(0.3), {Size = 0}):Play()
                task.wait(0.3)
                EkuveKeySystem:Destroy()
                Blur:Destroy()
                task.delay(1, function()
                    script_key = Key
                    API.load_script()
                end)
                return
            else
                Redeem.Text = message or "Wrong key"
                TweenService:Create(Redeem, TweenInfo.new(0.1), {BackgroundColor3 = Color3.new(0.713725, 0.290196, 0.294118)}):Play()
            end
            
            task.wait(2)
            TweenService:Create(Redeem, TweenInfo.new(0.1), {BackgroundColor3 = Color3.new(0.34902, 0.713726, 0.321569)}):Play()
            Redeem.Text = "Redeem"

            RedeemAnimation = false
        end)
    end
end

return Module
