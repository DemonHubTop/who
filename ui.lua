-- GUI Key System
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Description = Instance.new("TextLabel")
local KeyInput = Instance.new("TextBox")
local VerifyButton = Instance.new("TextButton")
local GetKeyButton = Instance.new("TextButton")
local JoinDiscordButton = Instance.new("TextButton")

-- Ensure this script runs only in LocalScript
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui", 5)

if not playerGui then
    error("PlayerGui not found. Ensure this is running as a LocalScript.")
end

-- ScreenGui Properties
ScreenGui.Parent = playerGui
ScreenGui.Name = "KeySystemGUI"

-- Dragging functionality
local UIS = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Frame Properties
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Size = UDim2.new(0, 300, 0, 220)
Frame.Position = UDim2.new(0.5, -150, 0.5, -110)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BorderSizePixel = 0
Frame.ClipsDescendants = true

-- Add corner and shadow
local corner = Instance.new("UICorner", Frame)
corner.CornerRadius = UDim.new(0, 10)
local shadow = Instance.new("ImageLabel", Frame)
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0.5, 5, 0.5, 5)
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.6

-- Title Properties
Title.Parent = Frame
Title.Text = "Key System"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20

-- Description Properties
Description.Parent = Frame
Description.Text = "Having issues with your key? Join our Discord!"
Description.TextColor3 = Color3.fromRGB(200, 200, 200)
Description.Size = UDim2.new(1, -20, 0, 50)
Description.Position = UDim2.new(0, 10, 0, 35)
Description.BackgroundTransparency = 1
Description.Font = Enum.Font.SourceSans
Description.TextSize = 14
Description.TextWrapped = true

-- KeyInput Properties
KeyInput.Parent = Frame
KeyInput.PlaceholderText = "Enter your key here..."
KeyInput.Text = ""
KeyInput.Size = UDim2.new(1, -20, 0, 30)
KeyInput.Position = UDim2.new(0, 10, 0, 90)
KeyInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.Font = Enum.Font.SourceSans
KeyInput.TextSize = 16

-- Button hover effect
local function animateButton(button)
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)
end

-- VerifyButton Properties
VerifyButton.Parent = Frame
VerifyButton.Text = "Verify Key"
VerifyButton.Size = UDim2.new(0.5, -15, 0, 30)
VerifyButton.Position = UDim2.new(0, 10, 0, 130)
VerifyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
VerifyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyButton.Font = Enum.Font.SourceSans
VerifyButton.TextSize = 16
animateButton(VerifyButton)

-- GetKeyButton Properties
GetKeyButton.Parent = Frame
GetKeyButton.Text = "Get Key"
GetKeyButton.Size = UDim2.new(0.5, -15, 0, 30)
GetKeyButton.Position = UDim2.new(0.5, 5, 0, 130)
GetKeyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyButton.Font = Enum.Font.SourceSans
GetKeyButton.TextSize = 16
animateButton(GetKeyButton)

-- JoinDiscordButton Properties
JoinDiscordButton.Parent = Frame
JoinDiscordButton.Text = "Join Discord"
JoinDiscordButton.Size = UDim2.new(1, -20, 0, 30)
JoinDiscordButton.Position = UDim2.new(0, 10, 0, 170)
JoinDiscordButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
JoinDiscordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
JoinDiscordButton.Font = Enum.Font.SourceSans
JoinDiscordButton.TextSize = 16
animateButton(JoinDiscordButton)

-- Clipboard and key functions
local HttpService = game:GetService("HttpService")
local permanentKeys = { "Yq7v&nxl9Nhsx", "StarX Is Crazy" }
local dynamicKeyUrl = "https://pastebin.com/raw/DyLxXSPc"

local function fetchDynamicKey()
    local success, result = pcall(function()
-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Subtitle = Instance.new("TextLabel")
local TextBox = Instance.new("TextBox")
local VerifyButton = Instance.new("TextButton")
local GetKeyButton = Instance.new("TextButton")
local DiscordButton = Instance.new("TextButton")
local CreditLabel = Instance.new("TextLabel")

-- Parent
ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui

-- Frame Properties
Frame.Size = UDim2.new(0, 400, 0, 300)
Frame.Position = UDim2.new(0.5, -200, 0.5, -150)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0

-- Title Properties
Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Text = "DemonStar!!"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.BorderSizePixel = 0
Title.TextSize = 20
Title.Font = Enum.Font.SourceSansBold

-- Subtitle Properties
Subtitle.Parent = Frame
Subtitle.Size = UDim2.new(1, 0, 0, 20)
Subtitle.Position = UDim2.new(0, 0, 0, 40)
Subtitle.Text = "Having issues with your key? Join our Discord!"
Subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
Subtitle.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Subtitle.BorderSizePixel = 0
Subtitle.TextSize = 14
Subtitle.Font = Enum.Font.SourceSansItalic

-- TextBox Properties
TextBox.Parent = Frame
TextBox.Size = UDim2.new(0.9, 0, 0, 30)
TextBox.Position = UDim2.new(0.05, 0, 0, 70)
TextBox.PlaceholderText = "Enter your key here..."
TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BorderSizePixel = 0
TextBox.TextSize = 16
TextBox.Font = Enum.Font.SourceSans

-- Verify Button Properties
VerifyButton.Parent = Frame
VerifyButton.Size = UDim2.new(0.45, 0, 0, 30)
VerifyButton.Position = UDim2.new(0.05, 0, 0, 110)
VerifyButton.Text = "Check Key"
VerifyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
VerifyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyButton.BorderSizePixel = 0
VerifyButton.TextSize = 16
VerifyButton.Font = Enum.Font.SourceSansBold

-- Get Key Button Properties
GetKeyButton.Parent = Frame
GetKeyButton.Size = UDim2.new(0.45, 0, 0, 30)
GetKeyButton.Position = UDim2.new(0.5, 0, 0, 110)
GetKeyButton.Text = "Get Key"
GetKeyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyButton.BorderSizePixel = 0
GetKeyButton.TextSize = 16
GetKeyButton.Font = Enum.Font.SourceSansBold

-- Discord Button Properties
DiscordButton.Parent = Frame
DiscordButton.Size = UDim2.new(0.9, 0, 0, 30)
DiscordButton.Position = UDim2.new(0.05, 0, 0, 150)
DiscordButton.Text = "Join Discord"
DiscordButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
DiscordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordButton.BorderSizePixel = 0
DiscordButton.TextSize = 16
DiscordButton.Font = Enum.Font.SourceSansBold

-- Credit Label Properties
CreditLabel.Parent = Frame
CreditLabel.Size = UDim2.new(1, 0, 0, 20)
CreditLabel.Position = UDim2.new(0, 0, 1, -20)
CreditLabel.Text = "Made by burnurpizza_96 | Jova3435"
CreditLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
CreditLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
CreditLabel.BorderSizePixel = 0
CreditLabel.TextSize = 14
CreditLabel.Font = Enum.Font.SourceSansItalic

-- Script Logic
local function verifyKey(key)
    local url = "http://thor.pylex.software:10663/check?key=" .. key
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)

    if success then
        local successDecode, data = pcall(function()
            return game.HttpService:JSONDecode(response)
        end)

        if successDecode then
            return data.key == "correct"
        else
            warn("Failed to decode JSON: " .. tostring(data))
            return nil
        end
    else
        warn("Failed to contact server: " .. tostring(response))
        return nil
    end
end

VerifyButton.MouseButton1Click:Connect(function()
    local userKey = TextBox.Text
    if userKey == "" then
        Subtitle.Text = "Key cannot be empty!"
        Subtitle.TextColor3 = Color3.fromRGB(255, 85, 85)
        return
    end

    Subtitle.Text = "Verifying..."
    Subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)

    local isValid = verifyKey(userKey)

    if isValid == nil then
        Subtitle.Text = "Failed to contact server. Try again later."
        Subtitle.TextColor3 = Color3.fromRGB(255, 85, 85)
    elseif isValid then
        Subtitle.Text = "Key is valid! Loading script..."
        Subtitle.TextColor3 = Color3.fromRGB(85, 255, 85)
        wait(1)
        local success, err = pcall(function()
            ScreenGui:Destroy()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Kraker-g/Scripts/refs/heads/main/Blade-Ball"))() -- Replace with your script
        end)
        if not success then
            warn("Error loading script: " .. tostring(err))
            Subtitle.Text = "Error loading script. Check the script URL."
            Subtitle.TextColor3 = Color3.fromRGB(255, 85, 85)
        end
    else
        Subtitle.Text = "Invalid key! Please try again."
        Subtitle.TextColor3 = Color3.fromRGB(255, 85, 85)
    end
end)

GetKeyButton.MouseButton1Click:Connect(function()
    Subtitle.Text = "Opening key website..."
    Subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
    wait(0.5)
    setclipboard("http://thor.pylex.software:10663/getkey") -- Copy key website to clipboard
end)

DiscordButton.MouseButton1Click:Connect(function()
    Subtitle.Text = "Opening Discord invite..."
    Subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
    wait(0.5)
    setclipboard("https://discord.gg/") -- Copy Discord invite link to clipboard
end)
ick:Connect(function()
    local discordUrl = "https://discord.gg/EwARkGncq4"
    if setclipboard then
        setclipboard(discordUrl)
        game.StarterGui:SetCore("SendNotification", { Title = "Join Discord", Text = "Discord URL copied to clipboard!", Icon = "" })
    else
        warn("Clipboard API not supported!")
    end
end)
