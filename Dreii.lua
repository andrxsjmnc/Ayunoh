-- 🌑 Black Loading Screen
local loadingGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
loadingGui.Name = "LoadingScreen"
loadingGui.IgnoreGuiInset = true

local blackFrame = Instance.new("Frame", loadingGui)
blackFrame.Size = UDim2.new(1, 0, 1, 0)
blackFrame.BackgroundColor3 = Color3.new(0, 0, 0)

local loadingText = Instance.new("TextLabel", blackFrame)
loadingText.Size = UDim2.new(1, 0, 0, 50)
loadingText.Position = UDim2.new(0, 0, 0.5, -25)
loadingText.Text = "Loading..."
loadingText.TextColor3 = Color3.new(1, 1, 1)
loadingText.Font = Enum.Font.SourceSansBold
loadingText.TextScaled = true
loadingText.BackgroundTransparency = 1

task.wait(2)
loadingGui:Destroy()

-- 🐾 Grow a Garden Pet List (Real Pets as of 2025)
local pets = {
    -- 🟢 Common / Basic
    "Dog", "Golden Lab", "Bunny",

    -- 🟡 Uncommon/Rare
    "Snail", "Cow", "Frog", "Turtle", "Monkey", "Squirrel", "Otter", "Crab", "Raccoon", "Bee",
    "Bear", "Butterfly", "Mole", "Cat", "Pig", "Chicken",

    -- 🔴 Rare/Legendary/Mythical
    "Dragonfly", "Giant Ant", "Red Giant Ant", "Honey Bee", "Disco Bee", "Bear Bee", "Petal Bee",
    "Hedgehog", "Night Owl", "Blood Owl", "Blood Hedgehog", "Blood Kiwi", "Echo Frog", "Mimic Octopus",

    -- 🟣 Exotic/Event
    "Polar Bear", "Fennec Fox", "Hyacinth Macaw", "Sand Snake", "Flamingo", "Orangutan",

    -- 🌊 Summer Event 2025
    "Toucan", "Sea Turtle", "Seal"
}

-- 🎮 GUI Setup
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "GrowAGardenSpawner"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 370)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true

-- 🔹 Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -30, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "GAG Pet Spawner (Visual)"
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20

-- 🧲 Open/Close Toggle Button
local toggleBtn = Instance.new("TextButton", frame)
toggleBtn.Position = UDim2.new(1, -30, 0, 0)
toggleBtn.Size = UDim2.new(0, 30, 0, 30)
toggleBtn.Text = "-"
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 20

-- 🔽 Pet Dropdown
local selectedPet = Instance.new("TextButton", frame)
selectedPet.Position = UDim2.new(0, 10, 0, 40)
selectedPet.Size = UDim2.new(0, 200, 0, 30)
selectedPet.Text = "Select Pet"
selectedPet.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
selectedPet.TextColor3 = Color3.new(1, 1, 1)

local dropdown = Instance.new("ScrollingFrame", frame)
dropdown.Position = UDim2.new(0, 10, 0, 70)
dropdown.Size = UDim2.new(0, 200, 0, 150)
dropdown.CanvasSize = UDim2.new(0, 0, 0, #pets * 30)
dropdown.Visible = false
dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
dropdown.ScrollBarThickness = 6

for i, pet in ipairs(pets) do
    local btn = Instance.new("TextButton", dropdown)
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
    btn.Text = pet
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)

    btn.MouseButton1Click:Connect(function()
        selectedPet.Text = pet
        dropdown.Visible = false
    end)
end

selectedPet.MouseButton1Click:Connect(function()
    dropdown.Visible = not dropdown.Visible
end)

-- ⚖️ Weight Input
local weightBox = Instance.new("TextBox", frame)
weightBox.Position = UDim2.new(0, 10, 0, 230)
weightBox.Size = UDim2.new(0, 200, 0, 30)
weightBox.PlaceholderText = "Pet Weight (kg)"
weightBox.TextColor3 = Color3.new(1,1,1)
weightBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

-- 🕒 Age Input
local ageBox = Instance.new("TextBox", frame)
ageBox.Position = UDim2.new(0, 10, 0, 270)
ageBox.Size = UDim2.new(0, 200, 0, 30)
ageBox.PlaceholderText = "Pet Age"
ageBox.TextColor3 = Color3.new(1,1,1)
ageBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

-- 🧬 Spawn Button
local spawnButton = Instance.new("TextButton", frame)
spawnButton.Position = UDim2.new(0, 10, 0, 310)
spawnButton.Size = UDim2.new(0, 100, 0, 30)
spawnButton.Text = "Spawn Pet"
spawnButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
spawnButton.TextColor3 = Color3.new(1,1,1)

-- 📜 Output
local output = Instance.new("TextLabel", frame)
output.Position = UDim2.new(0, 10, 0, 340)
output.Size = UDim2.new(0, 380, 0, 30)
output.Text = ""
output.TextWrapped = true
output.BackgroundTransparency = 1
output.TextColor3 = Color3.new(1, 1, 1)
output.TextSize = 14

-- 📦 Toggle Logic
local isOpen = true
local toggledElements = {selectedPet, dropdown, weightBox, ageBox, spawnButton, output}

toggleBtn.MouseButton1Click:Connect(function()
	isOpen = not isOpen
	for _, obj in pairs(toggledElements) do
		obj.Visible = isOpen
	end
	toggleBtn.Text = isOpen and "-" or "+"
	frame.Size = isOpen and UDim2.new(0, 400, 0, 370) or UDim2.new(0, 400, 0, 30)
end)

-- 🧠 Simulated Pet Spawner
spawnButton.MouseButton1Click:Connect(function()
    local pet = selectedPet.Text
    local weight = tonumber(weightBox.Text)
    local age = tonumber(ageBox.Text)

    if pet == "Select Pet" or not weight or not age then
        output.Text = "❌ Fill all fields correctly."
    else
        output.Text = "✅ Spawned "..pet.." (Weight: "..weight.."kg, Age: "..age..")"
    end
end)
