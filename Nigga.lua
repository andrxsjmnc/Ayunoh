-- Dark Spawner-Style Visual Pet System (Grow a Garden Lookalikes)
-- With fake models & optional idle animations

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Loading Screen (3 seconds)
local loadingGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
loadingGui.IgnoreGuiInset = true
local black = Instance.new("Frame", loadingGui)
black.Size = UDim2.new(1, 0, 1, 0)
black.BackgroundColor3 = Color3.new(0, 0, 0)
local text = Instance.new("TextLabel", black)
text.Size = UDim2.new(1, 0, 0, 50)
text.Position = UDim2.new(0, 0, 0.5, -25)
text.Text = "Loading..."
text.Font = Enum.Font.SourceSansBold
text.TextScaled = true
text.TextColor3 = Color3.new(1, 1, 1)
text.BackgroundTransparency = 1
wait(3)
loadingGui:Destroy()

-- Pet List
local petNames = {
    "Bunny", "Dog", "Bee", "Butterfly", "Frog", "Cow", "Raccoon", "Pig", "Cat", "Monkey",
    "Pumpkin Panda", "Candy Spider", "Petal Bee", "Disco Bee", "Night Owl", "Blood Kiwi", "Mole", "Otter"
}

-- Fake model generator (with optional bounce)
local function createFakePet(name, weight, age)
    local model = Instance.new("Model")
    model.Name = name .. " (" .. weight .. "kg, " .. age .. "y)"

    local body = Instance.new("Part")
    body.Size = Vector3.new(2, 1.5, 2)
    body.Anchored = false
    body.Position = Vector3.new(0, 5, 0)
    body.BrickColor = BrickColor.Random()
    body.TopSurface = Enum.SurfaceType.Smooth
    body.BottomSurface = Enum.SurfaceType.Smooth
    body.CanCollide = false
    body.Parent = model

    local bv = Instance.new("BodyPosition")
    bv.Position = Vector3.new(0, 5, 0)
    bv.MaxForce = Vector3.new(0, 10000, 0)
    bv.Parent = body

    local labelGui = Instance.new("BillboardGui", body)
    labelGui.Size = UDim2.new(0, 200, 0, 50)
    labelGui.AlwaysOnTop = true

    local label = Instance.new("TextLabel", labelGui)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Text = model.Name
    label.TextColor3 = Color3.new(1, 1, 1)
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.Font = Enum.Font.SourceSansBold

    model.PrimaryPart = body
    return model
end

-- GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 350, 0, 300)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Visual Pet Spawner"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18

local dropdown = Instance.new("TextButton", frame)
dropdown.Position = UDim2.new(0, 10, 0, 40)
dropdown.Size = UDim2.new(0, 150, 0, 30)
dropdown.Text = "Select Pet"
dropdown.TextColor3 = Color3.new(1, 1, 1)
dropdown.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

local menu = Instance.new("ScrollingFrame", frame)
menu.Position = UDim2.new(0, 10, 0, 70)
menu.Size = UDim2.new(0, 150, 0, 120)
menu.CanvasSize = UDim2.new(0, 0, 0, #petNames * 30)
menu.Visible = false
menu.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
menu.ScrollBarThickness = 6

for i, name in ipairs(petNames) do
    local btn = Instance.new("TextButton", menu)
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

    btn.MouseButton1Click:Connect(function()
        dropdown.Text = name
        menu.Visible = false
    end)
end

-- Age & Weight
local age = Instance.new("TextBox", frame)
age.Position = UDim2.new(0, 180, 0, 40)
age.Size = UDim2.new(0, 150, 0, 30)
age.PlaceholderText = "Age"
age.TextColor3 = Color3.new(1,1,1)
age.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

local kg = Instance.new("TextBox", frame)
kg.Position = UDim2.new(0, 180, 0, 80)
kg.Size = UDim2.new(0, 150, 0, 30)
kg.PlaceholderText = "Weight (kg)"
kg.TextColor3 = Color3.new(1,1,1)
kg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

-- Inventory
local inventory = {}

local spawn = Instance.new("TextButton", frame)
spawn.Position = UDim2.new(0, 10, 0, 200)
spawn.Size = UDim2.new(0, 140, 0, 30)
spawn.Text = "Spawn Pet"
spawn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
spawn.TextColor3 = Color3.new(1,1,1)

local listFrame = Instance.new("ScrollingFrame", frame)
listFrame.Position = UDim2.new(0, 180, 0, 120)
listFrame.Size = UDim2.new(0, 150, 0, 130)
listFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
listFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
listFrame.ScrollBarThickness = 6

local function refreshInventory()
    listFrame:ClearAllChildren()
    listFrame.CanvasSize = UDim2.new(0, 0, 0, #inventory * 40)
    for i, data in ipairs(inventory) do
        local b = Instance.new("TextButton", listFrame)
        b.Size = UDim2.new(1, 0, 0, 40)
        b.Position = UDim2.new(0, 0, 0, (i-1)*40)
        b.Text = data.name .. " (" .. data.kg .. "kg, " .. data.age .. "y)"
        b.TextColor3 = Color3.new(1, 1, 1)
        b.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
        b.MouseButton1Click:Connect(function()
            local pet = createFakePet(data.name, data.kg, data.age)
            local pos = mouse.Hit.p + Vector3.new(0, 2, 0)
            pet:SetPrimaryPartCFrame(CFrame.new(pos))
            pet.Parent = workspace
        end)
    end
end

spawn.MouseButton1Click:Connect(function()
    local name = dropdown.Text
    local weight = tonumber(kg.Text) or 1
    local a = tonumber(age.Text) or 1
    if name ~= "Select Pet" then
        table.insert(inventory, {name = name, kg = weight, age = a})
        refreshInventory()
    end
end)

dropdown.MouseButton1Click:Connect(function()
    menu.Visible = not menu.Visible
end)
