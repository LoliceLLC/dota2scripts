local Sniper = {}

local myHero = Heroes.GetLocal()

if myHero then
    isSniper = NPC.GetUnitName(myHero) == "npc_dota_hero_sniper"
end
HeroesCore.UseCurrentPath(isSniper)

Sniper.Enable = HeroesCore.AddOptionBool({"Hero Specific", "Agility",  "Sniper"}, "Ultimate sound", false)
HeroesCore.AddOptionIcon(Sniper.Enable, '~/MenuIcons/Enable/enable_check_round.png')

HeroesCore.AddMenuIcon({"Hero Specific", "Agility", "Sniper"},"panorama/images/heroes/icons/npc_dota_hero_sniper_png.vtex_c")

local lastAssassinate = -1231231
local headshotHandle = Renderer.LoadImage("~/headshot.png")
local ScreenWidth, ScreenHeight = Renderer.GetScreenSize()

function Sniper.OnDraw()

    if myHero == nil then return end

    if not isSniper then return end

    if not Menu.IsEnabled(Sniper.Enable) then return end

    if not Engine.IsInGame() or not Heroes.GetLocal() then return end

    local alpha = ((GameRules.GetGameTime() - lastAssassinate) * 2) * 255
    if alpha > 255 then
        alpha = 255
    end
    Renderer.SetDrawColor(255, 255, 255, math.floor(alpha))
    if (GameRules.GetGameTime() - lastAssassinate) < 3 then
        Renderer.DrawImageCentered(headshotHandle, ScreenWidth / 2, 200, 376, 200)
    end

end

function Sniper.OnStartSound(sound)

    if myHero == nil then return end

    if not isSniper then return end

    if not Menu.IsEnabled(Sniper.Enable) then return end

    if not Engine.IsInGame() or not Heroes.GetLocal() then return end

    if sound["name"] == "Hero_Sniper.AssassinateDamage" then
        Engine.ExecuteCommand("playsound sounds/fanibani/headshot.vsnd_c")
        lastAssassinate = GameRules.GetGameTime()
    end

end

return Sniper
