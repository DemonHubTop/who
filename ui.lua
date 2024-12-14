local v126 = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local v127 =
    v126:CreateWindow(
    {
        ["Title"] = "DEMONSTAR HUB | FISCHv1.2",
        ["SubTitle"] = "by hassanxzayn",
        ["Size"] = UDim2.fromOffset(580, 460),
        ["Acrylic"] = true,
        ["Theme"] = "Dark",
        ["MinimizeKey"] = Enum.KeyCode.LeftControl
    }
)

local v128 = {
    ["Main"] = v127:AddTab({["Title"] = "Main", ["Icon"] = "rbxassetid://7733749837"}),
    ["Settings"] = v127:AddTab({["Title"] = "Settings", ["Icon"] = "settings"})
}

local v129 = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local v130 = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
v129:SetLibrary(v126)
v130:SetLibrary(v126)
v130:BuildInterfaceSection(v128.Settings)
v129:BuildConfigSection(v128.Settings)
v127:SelectTab(1)

v128.Main:AddButton(
    {
        ["Title"] = "Sell Holding Fish",
        ["Description"] = "Sold Fish That Is In Your Hand",
        ["Callback"] = function()
            Workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Marc Merchant"):WaitForChild(
                "merchant"
            ):WaitForChild("sell"):InvokeServer()
        end
    }
)

v128.Main:AddButton(
    {
        ["Title"] = "Sell All Fishes",
        ["Description"] = "Sold All Fishes That Are In Your Inventory",
        ["Callback"] = function()
            Workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Marc Merchant"):WaitForChild(
                "merchant"
            ):WaitForChild("sellall"):InvokeServer()
        end
    }
)

v128.Main:AddButton(
    {
        ["Title"] = "Appraise Fish",
        ["Description"] = "Appraise the fish in your inventory.",
        ["Callback"] = function()
            Workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Appraiser"):WaitForChild("appraiser"):WaitForChild(
                "appraise"
            ):InvokeServer()
        end
    }
)

local function v167()
    v160 = not v160
    if v160 then
        v164 = v159.Character.HumanoidRootPart.Position
        v166("Auto Farm ON!!", 1.5)
        task.spawn(
            function()
                while v160 do
                    if v161 then
                        v161.events.shake:FireServer()
                        print("Shaking rod...")
                    end
                    task.wait(0.1)
                end
            end
        )
    else
        v163 = false
        v162 = false
        v166("Auto Farm: Disabled", 1.5)
        v155.SelectedObject = nil
        if v161 then
            v161.events.reset:FireServer()
        end
    end
end

local v153 = game:GetService("Players")
local v154 = game:GetService("StarterGui")
local v155 = game:GetService("GuiService")
local v156 = game:GetService("ReplicatedStorage")
local v157 = game:GetService("VirtualInputManager")
local v158 = game:GetService("UserInputService")
local v159 = v153.LocalPlayer
local v160 = false
local v161 = nil
local v162 = false
local v163 = false
local v164
local v165 = 0

local function v166(v236, v237)
    v154:SetCore(
        "SendNotification",
        {
            ["Title"] = "DEMONSTAR HUB",
            ["Text"] = v236,
            ["Duration"] = v237 or 0.5,
            ["Button1Text"] = "Okay"
        }
    )
end

v159.Character.ChildAdded:Connect(
    function(v240)
        if (v240:IsA("Tool") and v240.Name:lower():find("rod")) then
            v161 = v240
        end
    end
)

v159.Character.ChildRemoved:Connect(
    function(v241)
        if (v241 == v161) then
            v160 = false
            v163 = false
            v162 = false
            v161 = nil
            v155.SelectedObject = nil
        end
    end
)

v159.PlayerGui.DescendantAdded:Connect(
    function(v242)
        if v160 then
            if ((v242.Name == "button") and (v242.Parent.Name == "safezone")) then
                task.wait(0.3)
                v155.SelectedObject = v242
                v157:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                v157:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                task.wait(0.1)
                v155.SelectedObject = nil
            elseif ((v242.Name == "playerbar") and (v242.Parent.Name == "bar")) then
                v163 = true
                v242:GetPropertyChangedSignal("Position"):Wait()
                v156.events.reelfinished:FireServer(100, true)
                v165 = v165 + 1
            end
        end
    end
)

v159.PlayerGui.DescendantRemoving:Connect(
    function(v243)
        if (v243.Name == "reel") then
            v163 = false
            v162 = false
        end
    end
)

task.spawn(
    function()
        while true do
            if v160 and not v162 then
                if v161 then
                    v162 = true
                    task.wait(0.5)
                    v161.events.reset:FireServer()
                    v161.events.cast:FireServer(100)
                end
            end
            task.wait()
        end
    end
)

task.spawn(
    function()
        while true do
            if v160 then
                v159.Character.HumanoidRootPart.Position = v164
            end
            task.wait(0.75)
        end
    end
)

v152:Button(
    "Enable/Disable",
    function()
        v167()
    end
)

local v168 = v152:Label("Auto Farm OFF!!", Color3.fromRGB(255, 255, 255))
local v169 = v152:Label("Catches: 0", Color3.fromRGB(255, 255, 255))

task.spawn(
    function()
        while true do
            task.wait(1)
            if v160 then
                v168.Text = "Auto Farm ON!!"
            else
                v168.Text = "Auto Farm OFF!!"
            end
            v169.Text = "Fishes Catches: " .. v165
        end
    end
)

v128.Misc:AddButton(
    {["Title"] = "Anti AFK", ["Description"] = "Best For Farming", ["Callback"] = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/hassanxzayn-lua/Anti-afk/main/antiafkbyhassanxzyn"))()
        end}
)
