--[[
    NIKANIKANIKANIKA
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local DAMAGE_MULTIPLIER = 0.39
local PUNCH_MULTIPLIER = 0.25

local OldGui = PlayerGui:FindFirstChild("ModernStatsGui")
if OldGui then OldGui:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ModernStatsGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

local function Tween(Object, Time, Properties, Style, Direction)
    local TweenInfo = TweenInfo.new(Time, Style or Enum.EasingStyle.Quint, Direction or Enum.EasingDirection.Out)
    local TweenAnim = TweenService:Create(Object, TweenInfo, Properties)
    TweenAnim:Play()
    return TweenAnim
end

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 350)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(80, 80, 255)
UIStroke.Thickness = 1.5
UIStroke.Transparency = 0.3
UIStroke.Parent = MainFrame

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 15))
})
UIGradient.Rotation = 45
UIGradient.Parent = MainFrame

-- Floating Button
local FloatingBtn = Instance.new("TextButton")
FloatingBtn.Name = "FloatingBtn"
FloatingBtn.Size = UDim2.new(0, 0, 0, 0)
FloatingBtn.Position = UDim2.new(0, 15, 0.5, -25)
FloatingBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 255)
FloatingBtn.Text = "S"
FloatingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatingBtn.Font = Enum.Font.GothamBold
FloatingBtn.TextSize = 22
FloatingBtn.Visible = false
FloatingBtn.Parent = ScreenGui
Instance.new("UICorner", FloatingBtn).CornerRadius = UDim.new(1, 0)

local FloatStroke = Instance.new("UIStroke")
FloatStroke.Color = Color3.fromRGB(150, 150, 255)
FloatStroke.Thickness = 2
FloatStroke.Parent = FloatingBtn

-- Header
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundTransparency = 1
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "STATS VIEWER"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 24, 0, 24)
MinBtn.Position = UDim2.new(1, -60, 0.5, -12)
MinBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 18
MinBtn.Parent = Header
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -30, 0.5, -12)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 12
CloseBtn.Parent = Header
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

-- Dropdown Container
local DropdownContainer = Instance.new("Frame")
DropdownContainer.Size = UDim2.new(1, -30, 0, 35)
DropdownContainer.Position = UDim2.new(0, 15, 0, 45)
DropdownContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
DropdownContainer.ClipsDescendants = true
DropdownContainer.ZIndex = 5
DropdownContainer.Parent = MainFrame
Instance.new("UICorner", DropdownContainer).CornerRadius = UDim.new(0, 6)

local DropdownBtn = Instance.new("TextButton")
DropdownBtn.Size = UDim2.new(1, 0, 0, 35)
DropdownBtn.BackgroundTransparency = 1
DropdownBtn.Text = "  Pilih Pemain..."
DropdownBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
DropdownBtn.Font = Enum.Font.Gotham
DropdownBtn.TextSize = 13
DropdownBtn.TextXAlignment = Enum.TextXAlignment.Left
DropdownBtn.ZIndex = 6
DropdownBtn.Parent = DropdownContainer

local SearchBar = Instance.new("TextBox")
SearchBar.Size = UDim2.new(1, -10, 0, 30)
SearchBar.Position = UDim2.new(0, 5, 0, 35)
SearchBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
SearchBar.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBar.Text = ""
SearchBar.PlaceholderText = "Cari nama / display..."
SearchBar.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
SearchBar.Font = Enum.Font.Gotham
SearchBar.TextSize = 13
SearchBar.ZIndex = 6
SearchBar.ClearTextOnFocus = true
SearchBar.Parent = DropdownContainer
Instance.new("UICorner", SearchBar).CornerRadius = UDim.new(0, 4)

local Arrow = Instance.new("TextLabel")
Arrow.Size = UDim2.new(0, 30, 0, 35)
Arrow.Position = UDim2.new(1, -35, 0, 0)
Arrow.BackgroundTransparency = 1
Arrow.Text = "v"
Arrow.TextColor3 = Color3.fromRGB(200, 200, 200)
Arrow.Font = Enum.Font.GothamBold
Arrow.TextSize = 12
Arrow.ZIndex = 6
Arrow.Parent = DropdownContainer

local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Size = UDim2.new(1, 0, 0, 105)
PlayerList.Position = UDim2.new(0, 0, 0, 70)
PlayerList.BackgroundTransparency = 1
PlayerList.BorderSizePixel = 0
PlayerList.ScrollBarThickness = 3
PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerList.ZIndex = 5
PlayerList.Parent = DropdownContainer

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 2)
UIListLayout.Parent = PlayerList

UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    PlayerList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end)

-- Stats Display
local StatsFrame = Instance.new("Frame")
StatsFrame.Size = UDim2.new(1, -30, 0, 205)
StatsFrame.Position = UDim2.new(0, 15, 0, 130)
StatsFrame.BackgroundTransparency = 1
StatsFrame.Parent = MainFrame

-- HEALTH (Warna Label Hijau)
local HealthLabel = Instance.new("TextLabel")
HealthLabel.Size = UDim2.new(1, 0, 0, 30)
HealthLabel.BackgroundTransparency = 1
HealthLabel.Text = "Health:"
HealthLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
HealthLabel.Font = Enum.Font.Gotham
HealthLabel.TextSize = 14
HealthLabel.TextXAlignment = Enum.TextXAlignment.Left
HealthLabel.Parent = StatsFrame

local HealthValue = Instance.new("TextLabel")
HealthValue.Size = UDim2.new(1, 0, 0, 30)
HealthValue.BackgroundTransparency = 1
HealthValue.Text = "0"
HealthValue.TextColor3 = Color3.fromRGB(100, 255, 100)
HealthValue.Font = Enum.Font.GothamBold
HealthValue.TextSize = 18
HealthValue.TextXAlignment = Enum.TextXAlignment.Right
HealthValue.Parent = StatsFrame

-- STRENGTH (Warna Label Oranye biar beda)
local StrLabel = Instance.new("TextLabel")
StrLabel.Size = UDim2.new(1, 0, 0, 30)
StrLabel.Position = UDim2.new(0, 0, 0, 35)
StrLabel.BackgroundTransparency = 1
StrLabel.Text = "Strength:"
StrLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
StrLabel.Font = Enum.Font.Gotham
StrLabel.TextSize = 14
StrLabel.TextXAlignment = Enum.TextXAlignment.Left
StrLabel.Parent = StatsFrame

local StrValue = Instance.new("TextLabel")
StrValue.Size = UDim2.new(1, 0, 0, 30)
StrValue.Position = UDim2.new(0, 0, 0, 35)
StrValue.BackgroundTransparency = 1
StrValue.Text = "0"
StrValue.TextColor3 = Color3.fromRGB(255, 200, 100)
StrValue.Font = Enum.Font.GothamBold
StrValue.TextSize = 18
StrValue.TextXAlignment = Enum.TextXAlignment.Right
StrValue.Parent = StatsFrame

-- Damage
local DmgLabel = Instance.new("TextLabel")
DmgLabel.Size = UDim2.new(1, 0, 0, 30)
DmgLabel.Position = UDim2.new(0, 0, 0, 70)
DmgLabel.BackgroundTransparency = 1
DmgLabel.Text = "Damage Dealt:"
DmgLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
DmgLabel.Font = Enum.Font.Gotham
DmgLabel.TextSize = 14
DmgLabel.TextXAlignment = Enum.TextXAlignment.Left
DmgLabel.Parent = StatsFrame

local DmgValue = Instance.new("TextLabel")
DmgValue.Size = UDim2.new(1, 0, 0, 30)
DmgValue.Position = UDim2.new(0, 0, 0, 70)
DmgValue.BackgroundTransparency = 1
DmgValue.Text = "0"
DmgValue.TextColor3 = Color3.fromRGB(255, 100, 100)
DmgValue.Font = Enum.Font.GothamBold
DmgValue.TextSize = 18
DmgValue.TextXAlignment = Enum.TextXAlignment.Right
DmgValue.Parent = StatsFrame

-- Punch
local PunchLabel = Instance.new("TextLabel")
PunchLabel.Size = UDim2.new(1, 0, 0, 30)
PunchLabel.Position = UDim2.new(0, 0, 0, 105)
PunchLabel.BackgroundTransparency = 1
PunchLabel.Text = "Punch Damage:"
PunchLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
PunchLabel.Font = Enum.Font.Gotham
PunchLabel.TextSize = 14
PunchLabel.TextXAlignment = Enum.TextXAlignment.Left
PunchLabel.Parent = StatsFrame

local PunchValue = Instance.new("TextLabel")
PunchValue.Size = UDim2.new(1, 0, 0, 30)
PunchValue.Position = UDim2.new(0, 0, 0, 105)
PunchValue.BackgroundTransparency = 1
PunchValue.Text = "0"
PunchValue.TextColor3 = Color3.fromRGB(255, 150, 50)
PunchValue.Font = Enum.Font.GothamBold
PunchValue.TextSize = 18
PunchValue.TextXAlignment = Enum.TextXAlignment.Right
PunchValue.Parent = StatsFrame

-- Stamina
local StamLabel = Instance.new("TextLabel")
StamLabel.Size = UDim2.new(1, 0, 0, 30)
StamLabel.Position = UDim2.new(0, 0, 0, 140)
StamLabel.BackgroundTransparency = 1
StamLabel.Text = "Stamina:"
StamLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StamLabel.Font = Enum.Font.Gotham
StamLabel.TextSize = 14
StamLabel.TextXAlignment = Enum.TextXAlignment.Left
StamLabel.Parent = StatsFrame

local StamValue = Instance.new("TextLabel")
StamValue.Size = UDim2.new(1, 0, 0, 30)
StamValue.Position = UDim2.new(0, 0, 0, 140)
StamValue.BackgroundTransparency = 1
StamValue.Text = "0"
StamValue.TextColor3 = Color3.fromRGB(100, 200, 255)
StamValue.Font = Enum.Font.GothamBold
StamValue.TextSize = 18
StamValue.TextXAlignment = Enum.TextXAlignment.Right
StamValue.Parent = StatsFrame

-- Wins
local WinsLabel = Instance.new("TextLabel")
WinsLabel.Size = UDim2.new(1, 0, 0, 30)
WinsLabel.Position = UDim2.new(0, 0, 0, 175)
WinsLabel.BackgroundTransparency = 1
WinsLabel.Text = "Wins:"
WinsLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
WinsLabel.Font = Enum.Font.Gotham
WinsLabel.TextSize = 14
WinsLabel.TextXAlignment = Enum.TextXAlignment.Left
WinsLabel.Parent = StatsFrame

local WinsValue = Instance.new("TextLabel")
WinsValue.Size = UDim2.new(1, 0, 0, 30)
WinsValue.Position = UDim2.new(0, 0, 0, 175)
WinsValue.BackgroundTransparency = 1
WinsValue.Text = "0"
WinsValue.TextColor3 = Color3.fromRGB(200, 100, 255)
WinsValue.Font = Enum.Font.GothamBold
WinsValue.TextSize = 18
WinsValue.TextXAlignment = Enum.TextXAlignment.Right
WinsValue.Parent = StatsFrame

-- ==========================================
-- LOGIKA SCRIPT
-- ==========================================

local SelectedPlayer = nil
local IsOpen = false

local function FormatNumber(n)
    local i, j = tostring(math.floor(n)):find('^%-?%d+()%d%d%d')
    while i do
        j = j + 1
        i, j = tostring(n):find('^%-?%d+()%d%d%d', j)
    end
    local formatted = tostring(math.floor(n))
    while true do  
        formatted, k = formatted:gsub("^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end
    end
    return formatted
end

local function ResetUI()
    DropdownBtn.Text = "  Pilih Pemain..."
    HealthValue.Text = "0"
    StrValue.Text = "0"
    DmgValue.Text = "0"
    PunchValue.Text = "0"
    StamValue.Text = "0"
    WinsValue.Text = "0"
    if IsOpen then
        IsOpen = false
        Tween(DropdownContainer, 0.3, {Size = UDim2.new(1, -30, 0, 35)}, Enum.EasingStyle.Quart)
        Tween(Arrow, 0.3, {Rotation = 0})
    end
end

local function RefreshPlayerList()
    for _, v in pairs(PlayerList:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end

    for i, p in pairs(Players:GetPlayers()) do
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, 0, 0, 30)
        Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        Btn.BackgroundTransparency = 0.5
        Btn.Text = "  " .. p.DisplayName .. " (@" .. p.Name .. ")"
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 12
        Btn.TextXAlignment = Enum.TextXAlignment.Left
        Btn.LayoutOrder = i
        Btn.ZIndex = 5
        Btn.Parent = PlayerList
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)

        Btn.MouseEnter:Connect(function() Tween(Btn, 0.2, {BackgroundTransparency = 0.2}) end)
        Btn.MouseLeave:Connect(function() Tween(Btn, 0.2, {BackgroundTransparency = 0.5}) end)
        
        Btn.MouseButton1Click:Connect(function()
            SelectedPlayer = p
            DropdownBtn.Text = "  " .. p.DisplayName .. " (@" .. p.Name .. ")"
            IsOpen = false
            SearchBar.Text = ""
            Tween(DropdownContainer, 0.3, {Size = UDim2.new(1, -30, 0, 35)}, Enum.EasingStyle.Quart)
            Tween(Arrow, 0.3, {Rotation = 0})
        end)
    end
end

SearchBar:GetPropertyChangedSignal("Text"):Connect(function()
    local query = string.lower(SearchBar.Text)
    for _, btn in pairs(PlayerList:GetChildren()) do
        if btn:IsA("TextButton") then
            if query == "" or string.find(string.lower(btn.Text), query, 1, true) then
                btn.Visible = true
            else
                btn.Visible = false
            end
        end
    end
end)

SearchBar.FocusLost:Connect(function(enterPressed)
    if enterPressed and SearchBar.Text ~= "" then
        local input = string.lower(SearchBar.Text)
        local found = nil
        
        for _, p in pairs(Players:GetPlayers()) do
            local pName = string.lower(p.Name)
            local pDisplay = string.lower(p.DisplayName)
            
            if pName == input or pDisplay == input or string.find(pName, input, 1, true) or string.find(pDisplay, input, 1, true) then
                found = p
                break
            end
        end
        
        if found then
            SelectedPlayer = found
            DropdownBtn.Text = "  " .. found.DisplayName .. " (@" .. found.Name .. ")"
            IsOpen = false
            SearchBar.Text = ""
            Tween(DropdownContainer, 0.3, {Size = UDim2.new(1, -30, 0, 35)}, Enum.EasingStyle.Quart)
            Tween(Arrow, 0.3, {Rotation = 0})
        end
    end
end)

DropdownBtn.MouseButton1Click:Connect(function()
    IsOpen = not IsOpen
    RefreshPlayerList()
    if IsOpen then
        Tween(DropdownContainer, 0.4, {Size = UDim2.new(1, -30, 0, 175)}, Enum.EasingStyle.Quart)
        Tween(Arrow, 0.4, {Rotation = 180})
    else
        Tween(DropdownContainer, 0.4, {Size = UDim2.new(1, -30, 0, 35)}, Enum.EasingStyle.Quart)
        Tween(Arrow, 0.4, {Rotation = 0})
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    Tween(MainFrame, 0.3, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    task.wait(0.3)
    ScreenGui:Destroy()
end)

local isMinimized = false
local lastPos = MainFrame.Position

MinBtn.MouseButton1Click:Connect(function()
    if not isMinimized then
        lastPos = MainFrame.Position
        isMinimized = true
        Tween(MainFrame, 0.3, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0, 15, 0.5, -25), BackgroundTransparency = 1}, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.wait(0.25)
        MainFrame.Visible = false
        FloatingBtn.Visible = true
        Tween(FloatingBtn, 0.3, {Size = UDim2.new(0, 50, 0, 50)}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    end
end)

FloatingBtn.MouseButton1Click:Connect(function()
    if isMinimized then
        Tween(FloatingBtn, 0.3, {Size = UDim2.new(0, 0, 0, 0)}, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.wait(0.25)
        FloatingBtn.Visible = false
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        MainFrame.Position = UDim2.new(0, 15, 0.5, -25)
        MainFrame.BackgroundTransparency = 0.1
        Tween(MainFrame, 0.4, {Size = UDim2.new(0, 400, 0, 350), Position = lastPos}, Enum.EasingStyle.Quart)
        isMinimized = false
    end
end)

local Dragging, DragInput, DragStart, StartPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = input.Position
        StartPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then Dragging = false end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        DragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == DragInput and Dragging then
        local Delta = input.Position - DragStart
        MainFrame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
    end
end)

RunService.RenderStepped:Connect(function()
    -- Deteksi kalau player yang dipilih leave
    if SelectedPlayer then
        if not SelectedPlayer:IsDescendantOf(game) then
            SelectedPlayer = nil
            ResetUI()
        end
    end

    if SelectedPlayer then
        local strValueFound, stamValueFound, winsValueFound = 0, 0, 0
        local foundStr, foundStam, foundWins = false, false, false
        local healthFound = 0
        local foundHealth = false

        -- HEALTH (Pake Humanoid.Health biar pasti akurat)
        if SelectedPlayer.Character then
            local humanoid = SelectedPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                healthFound = humanoid.Health
                foundHealth = true
            end
        end

        -- Attributes
        local strAttr = SelectedPlayer:GetAttribute("Strength") or SelectedPlayer:GetAttribute("strength") or SelectedPlayer:GetAttribute("Str") or SelectedPlayer:GetAttribute("Power")
        if strAttr and type(strAttr) == "number" then strValueFound = strAttr foundStr = true end

        local stamAttr = SelectedPlayer:GetAttribute("Stamina") or SelectedPlayer:GetAttribute("stamina") or SelectedPlayer:GetAttribute("Stam")
        if stamAttr and type(stamAttr) == "number" then stamValueFound = stamAttr foundStam = true end

        local winsAttr = SelectedPlayer:GetAttribute("Wins") or SelectedPlayer:GetAttribute("wins") or SelectedPlayer:GetAttribute("Win")
        if winsAttr and type(winsAttr) == "number" then winsValueFound = winsAttr foundWins = true end

        -- Folders
        local folders = {"leaderstats", "Stats", "HiddenStats", "Values", "Data", "PlayerStats", "SaveData"}
        for _, fName in pairs(folders) do
            local folder = SelectedPlayer:FindFirstChild(fName)
            if folder then
                for _, v in pairs(folder:GetChildren()) do
                    if v:IsA("ValueBase") and type(v.Value) == "number" then
                        local n = v.Name:lower()
                        if not foundStr and (n:find("str") or n:find("pow") or n:find("dmg")) then strValueFound = v.Value foundStr = true end
                        if not foundStam and (n:find("stam")) then stamValueFound = v.Value foundStam = true end
                        if not foundWins and (n:find("win")) then winsValueFound = v.Value foundWins = true end
                    end
                end
            end
        end

        -- Update Health
        if foundHealth then
            if HealthValue.Text ~= FormatNumber(healthFound) then
                HealthValue.Text = FormatNumber(healthFound)
                Tween(HealthValue, 0.2, {TextColor3 = Color3.fromRGB(255, 255, 255)})
                Tween(HealthValue, 0.2, {TextColor3 = Color3.fromRGB(100, 255, 100)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            end
        else
            HealthValue.Text = "0"
        end

        -- Update Strength & Damage
        if foundStr and strValueFound > 0 then
            local CurrentStr = strValueFound
            local CalculatedDmg = math.floor(CurrentStr * DAMAGE_MULTIPLIER)
            local CalculatedPunch = math.floor(CurrentStr * PUNCH_MULTIPLIER)
            
            if StrValue.Text ~= FormatNumber(CurrentStr) then
                StrValue.Text = FormatNumber(CurrentStr)
                Tween(StrValue, 0.2, {TextColor3 = Color3.fromRGB(255, 255, 255)})
                Tween(StrValue, 0.2, {TextColor3 = Color3.fromRGB(255, 200, 100)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            end
            
            DmgValue.Text = FormatNumber(CalculatedDmg)
            PunchValue.Text = FormatNumber(CalculatedPunch)
        else
            StrValue.Text = "0"
            DmgValue.Text = "0"
            PunchValue.Text = "0"
        end

        -- Update Stamina
        if foundStam and stamValueFound > 0 then
            local CurrentStam = stamValueFound
            if StamValue.Text ~= FormatNumber(CurrentStam) then
                StamValue.Text = FormatNumber(CurrentStam)
                Tween(StamValue, 0.2, {TextColor3 = Color3.fromRGB(255, 255, 255)})
                Tween(StamValue, 0.2, {TextColor3 = Color3.fromRGB(100, 200, 255)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            end
        else
            StamValue.Text = "0"
        end

        -- Update Wins
        if foundWins and winsValueFound > 0 then
            local CurrentWins = winsValueFound
            if WinsValue.Text ~= FormatNumber(CurrentWins) then
                WinsValue.Text = FormatNumber(CurrentWins)
                Tween(WinsValue, 0.2, {TextColor3 = Color3.fromRGB(255, 255, 255)})
                Tween(WinsValue, 0.2, {TextColor3 = Color3.fromRGB(200, 100, 255)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            end
        else
            WinsValue.Text = "0"
        end
    end
end)
