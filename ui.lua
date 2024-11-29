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
        return HttpService:JSONDecode(game:HttpGet(dynamicKeyUrl))
    end)
    return success and result.Key or nil
end

GetKeyButton.MouseButton1Click:Connect(function()
    local keyUrl = "https://key-home.vercel.app/"
    if setclipboard then
        setclipboard(keyUrl)
        game.StarterGui:SetCore("SendNotification", { Title = "Clipboard", Text = "URL copied to clipboard.", Icon = "" })
    else
        warn("Clipboard API not supported!")
    end
end)

VerifyButton.MouseButton1Click:Connect(function()
    local inputKey = KeyInput.Text
    local isValid = false

    for _, key in ipairs(permanentKeys) do
        if inputKey == key then
            isValid = true
            break
        end
    end

    if not isValid then
        local dynamicKey = fetchDynamicKey()
        if dynamicKey and inputKey == dynamicKey then
            isValid = true
        end
    end

    if isValid then
        ScreenGui:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Kraker-g/Scripts/refs/heads/main/Blade-Ball"))()
    else
        KeyInput.Text = ""
        KeyInput.PlaceholderText = "Invalid key. Try again!"
    end
end)

JoinDiscordButton.MouseButton1Click:Connect(function()
    local discordUrl = "https://discord.gg/EwARkGncq4"
    if setclipboard then
        setclipboard(discordUrl)
        game.StarterGui:SetCore("SendNotification", { Title = "Join Discord", Text = "Discord URL copied to clipboard!", Icon = "" })
    else
        warn("Clipboard API not supported!")
    end
end)
