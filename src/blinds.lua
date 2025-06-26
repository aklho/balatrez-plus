SMODS.Atlas {
    key = "muchoblinds",
    path = "blindatlas.png",
    px = 340,
    py = 340,
    frames = 1,
    atlas_table = 'ANIMATION_ATLAS'
}

SMODS.Blind {
    name = "el_monstruo",
    key = "el_monstruo",
    atlas = "muchoblinds", -- or your custom atlas name if using a custom icon
    pos = { x = 0, y = 0 },
    dollars = 10,
    mult = 2,
    loc_vars = function(self)
        return {
            key = next(SMODS.find_card("j_mucho_translator")) and "bl_mucho_el_monstruotranslated" or "bl_mucho_el_monstruo",
        }
    end,
    boss = { min = 1 },
    boss_colour = HEX('A80024'),

    modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
        return mult / 3, hand_chips / 3, true
    end,
}


SMODS.Blind {
    name = "los_chinos",
    key = "los_chinos",
    atlas = "muchoblinds", -- or your custom atlas name if using a custom icon
    pos = { x = 0, y = 1 },
    dollars = 18,
    mult = 3,
    loc_vars = function(self)
        return {
            key = next(SMODS.find_card("j_mucho_translator")) and "bl_mucho_los_chinostranslated" or "bl_mucho_los_chinos",
        }
    end,
    boss = { min = 6 },
    boss_colour = HEX('A80071'),

    recalc_debuff = function(self, card, from_blind)
		if (card.area == G.jokers) and not G.GAME.blind.disabled and card.config.center.rarity == 1 then
			return true
		end
        if (card.area == G.jokers) and not G.GAME.blind.disabled and card.config.center.rarity == 3 then
			return true
		end
        if (card.area == G.jokers) and not G.GAME.blind.disabled and card.config.center.rarity == 4 then
			return true
		end
		return false
	end,

    disable = function(self)
       for i = 1, #G.jokers.cards do
            G.jokers.cards[i]:set_debuff(false)
       end
    end,

    defeat = function(self)
       for i = 1, #G.jokers.cards do
            G.jokers.cards[i]:set_debuff(false)
       end
    end,
}

SMODS.Blind {
    name = "el_jugador",
    key = "el_jugador",
    atlas = "muchoblinds", -- or your custom atlas name if using a custom icon
    pos = { x = 0, y = 2 },
    dollars = 5,
    mult = 4.42,
    loc_vars = function(self)
        return {
            key = next(SMODS.find_card("j_mucho_translator")) and "bl_mucho_el_jugadortranslated" or "bl_mucho_el_jugador",
        }
    end,
    boss = { min = 1 },
    boss_colour = HEX('9170CC'),

    modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
        return mult * (math.random(0, 4000)/1000), hand_chips * (math.random(0, 4000)/1000), true
    end,
}

--[[
SMODS.Blind {
    name = "boss_vibe",
    key = "boss_vibe",
    atlas = "muchoblinds",
    pos = { y = 2 },
    dollars = 2,
    loc_txt = {
        name = 'La parada del tiempo',
        text = {
            'Establece la velocidad del juego a x0,25'
        }
    },
    boss = {  min = 1 },
    boss_colour = HEX('333333'),

    defeat = function(self)
        G.SETTINGS.GAMESPEED = G.GAME.normalgamespeed
        G.GAME.normalgamespeed = nil
    end,

    disable = function(self)
        G.SETTINGS.GAMESPEED = G.GAME.normalgamespeed
        G.GAME.normalgamespeed = nil
    end,
}
]]--

SMODS.Blind {
    name = "el_destructor",
    key = "el_destructor",
    atlas = "muchoblinds", -- or your custom atlas name if using a custom icon
    pos = { x = 0, y = 4 },
    dollars = 15,
    mult = 25,
    loc_vars = function(self)
        return {
            key = next(SMODS.find_card("j_mucho_translator")) and "bl_mucho_el_destructortranslated" or "bl_mucho_el_destructor",
        }
    end,
    boss = { min = 8 },
    boss_colour = HEX('9170CC'),
}

SMODS.Blind {
    name = "el_rico",
    key = "el_rico",
    atlas = "muchoblinds", -- or your custom atlas name if using a custom icon
    pos = { y = 3 },
    dollars = 0,
    mult = 5,
    loc_vars = function(self)
        return {
            key = next(SMODS.find_card("j_mucho_translator")) and "bl_mucho_el_ricotranslated" or "bl_mucho_el_rico",
        }
    end,
    boss = { min = 1, max = 8 },
    boss_colour = HEX('9170CC'),

    drawn_to_hand = function(self)
        ease_dollars(1, true)
    end,

    press_play = function(self)
        ease_dollars(1, true)
    end,

    set_blind = function(self)
        ease_dollars(1, true)
    end,
}
