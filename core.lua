if not Mucho then
	Mucho = {}
end
local global = {}

local mod_path = "" .. SMODS.current_mod.path
Mucho.path = mod_path
Mucho_config = SMODS.current_mod.config

G.effectmanager = {}

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