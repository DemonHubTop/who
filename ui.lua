local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Workspace = game:GetService("Workspace")

local localPlayer = Players.LocalPlayer
local isAutoFarmEnabled = false
local fishingRod = nil
local isCasting = false
local isReeling = false
local originalPosition = nil
local fishCount = 0

local function sendNotification(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration,
        Button1 = "Okay"
    })
end

local function toggleAutoFarm()
    isAutoFarmEnabled = not isAutoFarmEnabled
    if isAutoFarmEnabled then
        originalPosition = localPlayer.Character.HumanoidRootPart.Position
        sendNotification("Auto Farm ON!!", "Auto Farm has been enabled.", 2.5)
        task.spawn(function()
            while isAutoFarmEnabled do
                if fishingRod then
                    fishingRod.events.shake:FireServer()
                    print("Shaking rod...")
                end
                task.wait(0.1)
            end
        end)
    else
        isReeling = false
        isCasting = false
        sendNotification("Auto Farm OFF!!", "Auto Farm has been disabled.", 2.5)
        GuiService.SelectedObject = nil
        if fishingRod then
            fishingRod.events.reset:FireServer()
        end
    end
end

localPlayer.Character.ChildAdded:Connect(function(child)
    if child:IsA("Tool") and child.Name:lower():find("rod") then
        fishingRod = child
    end
end)

localPlayer.Character.ChildRemoved:Connect(function(child)
    if child == fishingRod then
        isAutoFarmEnabled = false
        isReeling = false
        isCasting = false
        fishingRod = nil
        GuiService.SelectedObject = nil
    end
end)

localPlayer.PlayerGui.DescendantAdded:Connect(function(descendant)
    if isAutoFarmEnabled then
        if descendant.Name == "button" and descendant.Parent.Name == "safezone" then
            task.wait(0.3)
            GuiService.SelectedObject = descendant
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
            task.wait(0.1)
            GuiService.SelectedObject = nil
        elseif descendant.Name == "playerbar" and descendant.Parent.Name == "bar" then
            isReeling = true
            descendant:GetPropertyChangedSignal("Position"):Wait()
            ReplicatedStorage:WaitForChild("events"):WaitForChild("reelfinished"):FireServer(100, true)
            fishCount = fishCount + 1
        end
    end
end)

localPlayer.PlayerGui.DescendantRemoving:Connect(function(descendant)
    if descendant.Name == "reel" then
        isReeling = false
        isCasting = false
    end
end)

task.spawn(function()
    while true do
        if isAutoFarmEnabled and not isCasting then
            if fishingRod then
                isCasting = true
                task.wait(0.5)
                fishingRod.events.reset:FireServer()
                fishingRod.events.cast:FireServer(100)
            end
        end
        task.wait()
    end
end)

task.spawn(function()
    while true do
        if isAutoFarmEnabled then
            localPlayer.Character.HumanoidRootPart.Position = originalPosition
        end
        task.wait(0.75)
    end
end)

local library = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local window = library:CreateWindow({
    Title = "DEMONSTAR HUB | FISCHv1.2",
    SubTitle = "by hassanxzayn",
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local homeTab = window:AddTab({Title = "Home", Icon = "rbxassetid://7733960981"})

homeTab:AddButton({
    Title = "Join our Discord",
    Description = "Click on this button to copy the invite link!",
    Callback = function()
        local inviteLink = "https://discord.gg/25ms"
        if setclipboard then
            setclipboard(inviteLink)
            print("Discord invite link copied to clipboard!")
        else
            print("setclipboard function not available.")
        end
    end
})

homeTab:AddParagraph({
    Title = "About Our Discord",
    Content = [[
        DEMONSTAR HUB, the ultimate Roblox exploit hub, now has its very own Discord server! This is your go-to place to stay updated on all the latest features, scripts, and announcements. Here’s what you can do in our server:
        - Stay Informed: Get real-time updates on the latest developments, script releases, and exploit features available in DEMONSTAR HUB.
        - Script Requests: Need a specific script? Submit your requests, and our team or community may create one for you.
        - Exclusive Giveaways: Participate in exciting Robux giveaways exclusively for our Discord members.
        - Community Interaction: Connect with like-minded exploit enthusiasts, share tips, and get help from a supportive community.
        - Much More: Enjoy sneak peeks, community events, and future features tailored for DEMONSTAR HUB users.
    ]]
})

homeTab:AddParagraph({
    Title = "Credits",
    Content = "DEMONSTAR HUB | FISCHv1.2 by hassanxzayn"
})

local mainTab = window:AddTab({Title = "Main", Icon = "rbxassetid://7733749837"})

mainTab:AddButton({
    Title = "Sell Holding Fish",
    Description = "Sold Fish That Is In Your Hand",
    Callback = function()
        Workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Marc Merchant"):WaitForChild("merchant"):WaitForChild("sell"):InvokeServer()
    end
})

mainTab:AddButton({
    Title = "Sell All Fishes",
    Description = "Sold All Fishes That Are In Your Inventory",
    Callback = function()
        Workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Marc Merchant"):WaitForChild("merchant"):WaitForChild("sellall"):InvokeServer()
    end
})

mainTab:AddButton({
    Title = "Appraise Fish",
    Description = "Appraise the fish in your inventory.",
    Callback = function()
        Workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Appraiser"):WaitForChild("appraiser"):WaitForChild("appraise"):InvokeServer()
    end
})

mainTab:AddButton({
    Title = "Enable/Disable Auto Farm",
    Callback = function()
        toggleAutoFarm()
    end
})

local autoFarmLabel = mainTab:AddLabel("Auto Farm OFF!!")
local catchCountLabel = mainTab:AddLabel("Catches: 0")

task.spawn(function()
    while true do
        task.wait(1)
        if isAutoFarmEnabled then
            autoFarmLabel:SetText("Auto Farm ON!!")
        else
            autoFarmLabel:SetText("Auto Farm OFF!!")
        end
        catchCountLabel:SetText("Catches: " .. fishCount)
    end
end)

local miscTab = window:AddTab({Title = "Misc", Icon = "rbxassetid://7733789088"})

miscTab:AddButton({
    Title = "Anti AFK",
    Description = "Best For Farming",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hassanxzayn-lua/Anti-afk/main/antiafkbyhassanxzyn"))()
    end
})
