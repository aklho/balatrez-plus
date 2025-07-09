if not Mucho then
	Mucho = {}
end
local global = {}
BalatrezMod = SMODS.current_mod
BalatrezModConfig = BalatrezMod.config

local mod_path = "" .. SMODS.current_mod.path
Mucho.path = mod_path
Mucho_config = SMODS.current_mod.config

G.effectmanager = {}

BalatrezMod.config_tab = function()
    return {n = G.UIT.ROOT, config = {align = "m", r = 0.1, padding = 0.1, colour = G.C.BLACK, minw = 8, minh = 6}, nodes = {
        {n = G.UIT.R, config = {align = "cl", padding = 0, minh = 0.1}, nodes = {}},

        {n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
            {n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
                create_toggle{ col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = BalatrezModConfig, ref_value = "bltrz_x_freaky" },
            }},
            {n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
                { n = G.UIT.T, config = { text = "Cross-compatibility with Freakylatro*", scale = 0.45, colour = G.C.UI.TEXT_LIGHT }},
            }},
        }},

        {n = G.UIT.R, config = {align = "cm", padding = 0.5}, nodes = {
            {n = G.UIT.T, config = {text = "*Must restart to apply changes", scale = 0.35, colour = G.C.UI.TEXT_LIGHT}},
        }},

    }}
end

setting_tabRef = G.UIDEF.settings_tab
function G.UIDEF.settings_tab(tab)
    local setting_tab = setting_tabRef(tab)

    if tab == 'Game' then
        local speeds = create_option_cycle({label = localize('b_set_gamespeed'),scale = 0.8, options = {0.0625, 0.125, 0.25, 0.5, 1, 2, 3, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048}, opt_callback = 'change_gamespeed', current_option = (
			G.SETTINGS.GAMESPEED == 0.0625 and 0.25 or
			G.SETTINGS.GAMESPEED == 0.125 and 0.5 or
			G.SETTINGS.GAMESPEED == 0.25 and 1 or
            G.SETTINGS.GAMESPEED == 0.5 and 2 or 
            G.SETTINGS.GAMESPEED == 1 and 3 or 
            G.SETTINGS.GAMESPEED == 2 and 4 or
            G.SETTINGS.GAMESPEED == 3 and 5 or
            G.SETTINGS.GAMESPEED == 4 and 6 or 
            G.SETTINGS.GAMESPEED == 8 and 7 or 
            G.SETTINGS.GAMESPEED == 16 and 8 or 
			G.SETTINGS.GAMESPEED == 32 and 16 or 
			G.SETTINGS.GAMESPEED == 64 and 32 or 
			G.SETTINGS.GAMESPEED == 128 and 64 or 
			G.SETTINGS.GAMESPEED == 256 and 128 or 
			G.SETTINGS.GAMESPEED == 512 and 256 or 
			G.SETTINGS.GAMESPEED == 1024 and 512 or 
			G.SETTINGS.GAMESPEED == 2048 and 1024 or 
			G.SETTINGS.GAMESPEED == 4096 and 2048 or 
            3 -- Default to 1 if none match, adjust as necessary
        )})
        setting_tab.nodes[1] = speeds
    end
    return setting_tab
end

local Getid_old = Card.get_id
function Card:get_id()
    local ret = Getid_old(self)
    if ret >=2 and ret <=10 and next(find_joker("j_mucho_equality")) then ret = MuchoNumberRank
    elseif ret >=11 and ret <=13 and next(find_joker("j_mucho_equality")) then ret = MuchoFaceRank end
    return ret
end

SMODS.Atlas({
	key = "modicon",
	path = "muchoicon.png",
	px = 34,
	py = 34,
})

assert(SMODS.load_file("src/functions.lua"))()
assert(SMODS.load_file("src/jokers.lua"))()
assert(SMODS.load_file("src/blinds.lua"))()
assert(SMODS.load_file("src/consumables.lua"))()
assert(SMODS.load_file("src/sounds.lua"))()
assert(SMODS.load_file("src/boosters.lua"))()
assert(SMODS.load_file("src/editions.lua"))()
assert(SMODS.load_file("src/videos.lua"))()
assert(SMODS.load_file("src/suits.lua"))()
assert(SMODS.load_file("src/pokerhands.lua"))()
assert(SMODS.load_file("src/backs.lua"))()
assert(SMODS.load_file("src/tags.lua"))()
assert(SMODS.load_file("src/vouchers.lua"))()
assert(SMODS.load_file("src/seals.lua"))()
assert(SMODS.load_file("src/enhancements.lua"))()