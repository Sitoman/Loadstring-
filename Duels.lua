local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

_G.AutoKill = false
_G.ESP = false
_G.Hitbox = false
_G.Aimbot = false

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 260, 0, 360); Frame.Position = UDim2.new(0.5, -130, 0.5, -180)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Frame.Active = true; Frame.Draggable = true
Instance.new("UICorner", Frame)


local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 50); Title.Text = "  SITOMAN HUB V2" 
Title.TextColor3 = Color3.new(1, 1, 1); Title.TextSize = 14; Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left -- Aligment ke kiri
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40); Instance.new("UICorner", Title)


local ExitBtn = Instance.new("TextButton", Title); ExitBtn.Size = UDim2.new(0, 40, 1, 0); ExitBtn.Position = UDim2.new(0.85, 0, 0, 0); ExitBtn.Text = "X"
ExitBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0); ExitBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local isMinimized = false
local MinBtn = Instance.new("TextButton", Title); MinBtn.Size = UDim2.new(0, 40, 1, 0); MinBtn.Position = UDim2.new(0.7, 0, 0, 0); MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80); MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    for _, obj in pairs(Frame:GetChildren()) do
        if obj:IsA("TextButton") and obj ~= MinBtn and obj ~= ExitBtn then obj.Visible = not isMinimized end
    end
    Frame.Size = isMinimized and UDim2.new(0, 260, 0, 50) or UDim2.new(0, 260, 0, 360)
end)

local buttonCount = 0
local function CreateButton(name, var)
    local btn = Instance.new("TextButton", Frame); btn.Size = UDim2.new(0.9, 0, 0, 50); btn.Position = UDim2.new(0.05, 0, 0, 60 + (buttonCount * 65))
    btn.Text = name .. ": OFF"; btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50); btn.TextColor3 = Color3.new(1,1,1); btn.Font = Enum.Font.GothamBold; btn.TextSize = 14
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function()
        _G[var] = not _G[var]
        btn.Text = name .. (_G[var] and ": ON" or ": OFF")
        btn.BackgroundColor3 = _G[var] and Color3.fromRGB(0, 100, 255) or Color3.fromRGB(50, 50, 50)
    end)
    buttonCount = buttonCount + 1
end

CreateButton("Auto-Kill", "AutoKill")
CreateButton("ESP", "ESP")
CreateButton("Hitbox", "Hitbox")
CreateButton("Aimbot", "Aimbot")


RunService.Heartbeat:Connect(function()
    if _G.AutoKill then
        local myChar = LocalPlayer.Character
        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
            local closest = nil; local dist = math.huge
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 and (p.Team ~= LocalPlayer.Team or not p.Team) then
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
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and (p.Team ~= LocalPlayer.Team or not p.Team) then
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
