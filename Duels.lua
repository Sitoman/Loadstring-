local OwnerID = 10831199229
local key_system = true 
local CorrectKey = "SITOMAN2026"
local LinkKey = "https://pastebin.com/t4yqL7pW"

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Variables for cheats
_G.AutoKill = false; _G.ESP = false; _G.Hitbox = false; _G.Aimbot = false

local OwnerDisplayName = "Owner:REAL_SITOMAN"

local function ShowIntro()
    local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local Frame = Instance.new("Frame", ScreenGui)
    Frame.Size = UDim2.new(0, 300, 0, 150); Frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Frame.BackgroundTransparency = 1; Instance.new("UICorner", Frame)
    local Image = Instance.new("ImageLabel", Frame)
    Image.Size = UDim2.new(0, 60, 0, 60); Image.Position = UDim2.new(0.5, -30, 0.2, 0)
    Image.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    Image.BackgroundTransparency = 1; Instance.new("UICorner", Image)
    local Label = Instance.new("TextLabel", Frame); Label.Size = UDim2.new(1, 0, 0, 50); Label.Position = UDim2.new(0, 0, 0.6, 0)
    Label.BackgroundTransparency = 1; Label.Text = "Welcome, " .. LocalPlayer.Name; Label.TextColor3 = Color3.new(1, 1, 1); Label.Font = Enum.Font.GothamBold
    TweenService:Create(Frame, TweenInfo.new(1), {BackgroundTransparency = 0}):Play()
    task.wait(2)
    TweenService:Create(Frame, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
    task.wait(1)
    ScreenGui:Destroy()
end

local function CreateMainUI()
    ShowIntro()
    local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local Frame = Instance.new("Frame", ScreenGui)
    Frame.Size = UDim2.new(0, 260, 0, 420); Frame.Position = UDim2.new(0.5, -130, 0.5, -210)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Frame.Active = true; Frame.Draggable = true
    Instance.new("UICorner", Frame)
    
    local UserImg = Instance.new("ImageLabel", Frame)
    UserImg.Size = UDim2.new(0, 40, 0, 40); UserImg.Position = UDim2.new(0.05, 0, 0.03, 0)
    UserImg.Image = Players:GetUserThumbnailAsync(OwnerID, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    Instance.new("UICorner", UserImg)
    
    local UserLabel = Instance.new("TextLabel", Frame)
    UserLabel.Size = UDim2.new(0, 150, 0, 40); UserLabel.Position = UDim2.new(0.25, 0, 0.03, 0)
    UserLabel.BackgroundTransparency = 1; UserLabel.Text = OwnerDisplayName; UserLabel.TextColor3 = Color3.new(1,1,1); UserLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local StatusBox = Instance.new("TextButton", ScreenGui)
    StatusBox.Size = UDim2.new(0, 50, 0, 50); StatusBox.Position = UDim2.new(0, 20, 0.5, -25)
    StatusBox.BackgroundColor3 = Color3.fromRGB(0, 255, 0); StatusBox.Text = "OPEN"; StatusBox.Font = Enum.Font.GothamBold
    Instance.new("UICorner", StatusBox)

    local Title = Instance.new("TextLabel", Frame)
    Title.Name = "Title"; Title.Size = UDim2.new(1, 0, 0, 50); Title.Position = UDim2.new(0, 0, 0.12, 0)
    Title.Text = "  SITOMAN HUB V2"
    Title.TextColor3 = Color3.new(1, 1, 1); Title.TextSize = 14; Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left; Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40); Instance.new("UICorner", Title)
    
    local ExitBtn = Instance.new("TextButton", Title); ExitBtn.Size = UDim2.new(0, 50, 1, 0); ExitBtn.Position = UDim2.new(0.8, 0, 0, 0); ExitBtn.Text = "X"
    ExitBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50); ExitBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
    
    StatusBox.MouseButton1Click:Connect(function()
        Frame.Visible = not Frame.Visible
        StatusBox.Text = Frame.Visible and "OPEN" or "CLOSED"
        StatusBox.BackgroundColor3 = Frame.Visible and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    end)
    
    local buttonCount = 0
    local function CreateButton(name, var)
        local btn = Instance.new("TextButton", Frame); btn.Size = UDim2.new(0.9, 0, 0, 50); btn.Position = UDim2.new(0.05, 0, 0, 120 + (buttonCount * 65))
        btn.Text = name .. ": OFF"; btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50); btn.TextColor3 = Color3.new(1,1,1); btn.Font = Enum.Font.GothamBold
        Instance.new("UICorner", btn)
        btn.MouseButton1Click:Connect(function()
            _G[var] = not _G[var]
            btn.Text = name .. (_G[var] and ": ON" or ": OFF")
            btn.BackgroundColor3 = _G[var] and Color3.fromRGB(0, 100, 255) or Color3.fromRGB(50, 50, 50)
        end)
        buttonCount = buttonCount + 1
    end
    CreateButton("Auto-Kill", "AutoKill"); CreateButton("ESP", "ESP"); CreateButton("Hitbox", "Hitbox"); CreateButton("Aimbot", "Aimbot")
end

-- HEARTBEAT LOOP (Di luar fungsi UI supaya sentiasa running)
RunService.Heartbeat:Connect(function()
    if _G.AutoKill then
        local myChar = LocalPlayer.Character
        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
            local closest = nil; local dist = math.huge
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                    local d = (p.Character.HumanoidRootPart.Position - myChar.HumanoidRootPart.Position).Magnitude
                    if d < dist then closest = p.Character.HumanoidRootPart; dist = d end
                end
            end
            if closest then
                for _, p in pairs(myChar:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end
                myChar.HumanoidRootPart.Velocity = (closest.Position - myChar.HumanoidRootPart.Position).Unit * 50
            end
        end
    end
    if _G.ESP then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and not p.Character:FindFirstChild("HighlightESP") then
                local hl = Instance.new("Highlight", p.Character); hl.Name = "HighlightESP"; hl.FillColor = Color3.fromRGB(255, 0, 0)
            end
        end
    else
        for _, p in pairs(Players:GetPlayers()) do if p.Character and p.Character:FindFirstChild("HighlightESP") then p.Character.HighlightESP:Destroy() end end
    end
    if _G.Hitbox then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.Size = Vector3.new(6, 6, 6)
                p.Character.HumanoidRootPart.Transparency = 0.5
            end
        end
    end
    if _G.Aimbot then
        local closest = nil; local dist = math.huge
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                local pos, vis = Camera:WorldToViewportPoint(p.Character.Head.Position)
                if vis then
                    local d = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if d < dist then closest = p.Character.Head; dist = d end
                end
            end
        end
        if closest then Camera.CFrame = CFrame.new(Camera.CFrame.Position, closest.Position) end
    end
end)

if key_system and LocalPlayer.UserId ~= OwnerID then
    local KeyGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local KeyFrame = Instance.new("Frame", KeyGui); KeyFrame.Size = UDim2.new(0, 260, 0, 200); KeyFrame.Position = UDim2.new(0.5, -130, 0.5, -100); KeyFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    Instance.new("UICorner", KeyFrame)
    local InputBox = Instance.new("TextBox", KeyFrame); InputBox.Size = UDim2.new(0.9, 0, 0, 40); InputBox.Position = UDim2.new(0.05, 0, 0.1, 0); InputBox.PlaceholderText = "Masukkan Key..."
    local LoginBtn = Instance.new("TextButton", KeyFrame); LoginBtn.Size = UDim2.new(0.9, 0, 0, 40); LoginBtn.Position = UDim2.new(0.05, 0, 0.4, 0); LoginBtn.Text = "LOGIN"; LoginBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
    local GetKeyBtn = Instance.new("TextButton", KeyFrame); GetKeyBtn.Size = UDim2.new(0.9, 0, 0, 40); GetKeyBtn.Position = UDim2.new(0.05, 0, 0.7, 0); GetKeyBtn.Text = "GET KEY"
    Instance.new("UICorner", LoginBtn); Instance.new("UICorner", GetKeyBtn)
    LoginBtn.MouseButton1Click:Connect(function() if InputBox.Text == CorrectKey then KeyGui:Destroy(); CreateMainUI() else InputBox.Text = "Salah Key!" end end)
    GetKeyBtn.MouseButton1Click:Connect(function() setclipboard(LinkKey) end)
else
    CreateMainUI()
end
