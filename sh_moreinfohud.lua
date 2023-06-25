
local PLUGIN = PLUGIN
PLUGIN.name = "More Information HUD"
PLUGIN.author = "Cloud Rese, Wade, with ChatGPT help!"
PLUGIN.description = "Gives information on your character, & gives prettier bars than the normal, ugly bars. Made for Aeternum HL2rp. First plugin."
-- Define the position and size of the bars
local barX = 10
local barY = 980
local barWidth = 375
local barHeight = 25
local barMargin = 2.5
-- Define the transparent box.
local boxX = 0
local boxY = 850
local boxWidth = 400
local boxHeight = 250
local boxColor = Color(50, 50, 50, 205)
-- Define the colors for health, armor, and stamina bars
local healthColor = Color(205, 0, 0, 200)
local armorColor = Color(0, 128, 235, 200)
local staminaColor = Color(255, 205, 50, 200)

-- Hook into the GMOD Helix's HUDPaint function
hook.Add("HUDPaint", "HelixHealthBar", function()
    local ply = LocalPlayer()
    -- Check if the player is valid and alive
    if not IsValid(ply) or not ply:Alive() then return end
    -- Get the player's character and data
    local char = ply:GetCharacter()
    local hp = ply:Health()
    local maxHP = 100
    local armor = ply:Armor()
    local maxArmor = 100 -- Modify this value if needed
    local stamina = ply:GetLocalVar('stm')
    local maxStamina = 100 -- Modify this value if needed
    -- Define box information
    local charname = ply:GetCharacter():GetName()
    local factionIndex = ply:GetCharacter():GetFaction()
	local factionObject = ix.faction.Get(factionIndex)
	local charjob = factionObject.name
	local classIndex = ply:GetCharacter():GetClass()
	local classObject = ix.class.Get(classIndex)
    local charclass = classObject.name
    local richOrNot = ply:GetCharacter():GetMoney()
    -- Draw box
    draw.RoundedBox(6, boxX, boxY, boxWidth, boxHeight, boxColor)
    -- Draw box information
    draw.DrawText("Name: " .. charname, "HudDefault", 2, 865, color_white)
    draw.DrawText("Job: " .. charjob, "HudDefault", 2, 885, color_white)
	draw.DrawText("Rank: " .. charclass, "HudDefault", 2, 905, color_white)
	draw.DrawText("Tokens: " .. richOrNot, "HudDefault", 2, 925, color_white)
    -- Draw the health bar
    draw.RoundedBox(4, barX, barY, barWidth * (hp / maxHP), barHeight, healthColor)
    -- Draw the armor bar
    draw.RoundedBox(4, barX, barY + barHeight + barMargin, barWidth * (armor / maxArmor), barHeight, armorColor)
    -- Draw the stamina bar
    draw.RoundedBox(4, barX, barY + (barHeight + barMargin) * 2, barWidth * (stamina / maxStamina), barHeight, staminaColor)
end)

-- Display the bar values as a HUD message
-- draw.SimpleText("Health: " .. hp .. "/" .. maxHP, "DermaDefault", barX, barY + barHeight + barMargin, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
-- draw.SimpleText("Armor: " .. armor .. "/" .. maxArmor, "DermaDefault", barX, barY + (barHeight + barMargin) * 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
-- draw.SimpleText("Stamina: " .. stamina .. "/" .. maxStamina, "DermaDefault", barX, barY + (barHeight + barMargin) * 3, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
function PLUGIN:ShouldHideBars()
    return true
end