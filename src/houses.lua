SMODS.Atlas {
    key = "atlashouse",
    path = "atlashouse.png",
    px = 71,
    py = 95
}

SMODS.ObjectType{
    key = "MuchoHouses",
    default = "j_joker",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		-- insert base game food jokers
	end,
    rarities = {
        {key = 'Common', rate = 0.3},
        {key = 'Uncommon', rate = 0.75},
        {key = 'Rare', rate = 0.95},
        {key = 'mucho_rarerthanrare', rate = 0.99},
        {key = 'mucho_exceptional', rate = 0.998},
        {key = 'mucho_unobtainable', rate = 1},
    },
}

--[[ EXAMPLE HOUSE (for practicity of the dev)

SMODS.Joker{
    key = "",
    atlas = "atlashouse", pos = {x = ..., y = ...},

    rarity = ...,
    cost = ...,

    pools = {["BalatrezAddition"] = true, ["MuchoHouses"] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = {  }},
    
    loc_vars = function(self, info_queue, card)
        return {
            key = "...",
            vars = {},
            colours = {},
        }
    end,

    calculate = function(self, card, context)
        -- ...
    end
}

]]--

-- Common House
SMODS.Joker{
    key = "common_house",
    atlas = "atlashouse", pos = {x = 0, y = 0},

    rarity = 1,
    cost = 3,

    pools = {["MuchoHouses"] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { hands_remaining = 0, needed_hands = 171, exmult = 4 }},
    
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_common_house",
            vars = {card.ability.extra.exmult, card.ability.extra.hands_remaining, card.ability.extra.needed_hands},
            colours = {},
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            if card.ability.extra.hands_remaining < card.ability.extra.needed_hands then
                card.ability.extra.hands_remaining = card.ability.extra.hands_remaining + G.GAME.muchohandgain
                return {
                    extra = { message = card.ability.extra.hands_remaining.."/"..card.ability.extra.needed_hands, colour = G.C.GREEN}
                }
            end
        end
        if context.joker_main and not context.blueprint and card.ability.extra.hands_remaining >= card.ability.extra.needed_hands then
            if next(SMODS.find_mod("Talisman")) then
                return {
                    emult = card.ability.extra.exmult,
                }
            else
                return {
                    xmult = mult ^ (card.ability.extra.exmult-1),
                    extra = { message = "^"..card.ability.extra.exmult.." Mult", colour = G.C.DARK_EDITION}
                }
            end
        end
    end
}



-- Rare House
SMODS.Joker{
    key = "rare_house",
    atlas = "atlashouse", pos = {x = 1, y = 0},

    rarity = 3,
    cost = 9,

    pools = {["MuchoHouses"] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { hands_remaining = 0, needed_hands = 87, exmult = 4 }},
    
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_rare_house",
            vars = {card.ability.extra.exmult, card.ability.extra.hands_remaining, card.ability.extra.needed_hands},
            colours = {},
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            if card.ability.extra.hands_remaining < card.ability.extra.needed_hands then
                card.ability.extra.hands_remaining = card.ability.extra.hands_remaining + G.GAME.muchohandgain
                return {
                    extra = { message = card.ability.extra.hands_remaining.."/"..card.ability.extra.needed_hands, colour = G.C.GREEN}
                }
            end
        end
        if context.joker_main and not context.blueprint and card.ability.extra.hands_remaining >= card.ability.extra.needed_hands then
            if next(SMODS.find_mod("Talisman")) then
                return {
                    emult = card.ability.extra.exmult,
                }
            else
                return {
                    xmult = mult ^ (card.ability.extra.exmult-1),
                    extra = { message = "^"..card.ability.extra.exmult.." Mult", colour = G.C.DARK_EDITION}
                }
            end
        end
    end
}



-- Rarer than Rare House
SMODS.Joker{
    key = "rarer_than_rare_house",
    atlas = "atlashouse", pos = {x = 2, y = 0},

    rarity = "mucho_rarerthanrare",
    cost = 15,

    pools = {["MuchoHouses"] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { hands_remaining = 0, needed_hands = 57, exmult = 3 }},
    
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_rarer_than_rare_house",
            vars = {card.ability.extra.exmult, card.ability.extra.hands_remaining, card.ability.extra.needed_hands},
            colours = {},
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            if card.ability.extra.hands_remaining < card.ability.extra.needed_hands then
                card.ability.extra.hands_remaining = card.ability.extra.hands_remaining + G.GAME.muchohandgain
                return {
                    extra = { message = card.ability.extra.hands_remaining.."/"..card.ability.extra.needed_hands, colour = G.C.GREEN}
                }
            end
        end
        if context.joker_main and not context.blueprint and card.ability.extra.hands_remaining >= card.ability.extra.needed_hands then
            if next(SMODS.find_mod("Talisman")) then
                return {
                    emult = card.ability.extra.exmult,
                }
            else
                return {
                    xmult = mult ^ (card.ability.extra.exmult-1),
                    extra = { message = "^"..card.ability.extra.exmult.." Mult", colour = G.C.DARK_EDITION}
                }
            end
        end
    end
}



-- Exceptional House
SMODS.Joker{
    key = "exceptional_house",
    atlas = "atlashouse", pos = {x = 3, y = 0}, soul_pos = {x = 3, y = 1},

    rarity = "mucho_exceptional",
    cost = 25,

    pools = {["MuchoHouses"] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { hands_remaining = 0, needed_hands = 11, exmult = 4, exmultgain = 4 }},
    
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_exceptional_house",
            vars = {card.ability.extra.exmult, card.ability.extra.hands_remaining, card.ability.extra.needed_hands, card.ability.extra.exmultgain},
            colours = {},
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            if card.ability.extra.hands_remaining < card.ability.extra.needed_hands then
                card.ability.extra.hands_remaining = card.ability.extra.hands_remaining + G.GAME.muchohandgain
                return {
                    extra = { message = card.ability.extra.hands_remaining.."/"..card.ability.extra.needed_hands, colour = G.C.GREEN}
                }
            end
            if card.ability.extra.hands_remaining >= card.ability.extra.needed_hands then
                card.ability.extra.exmult = card.ability.extra.exmult + card.ability.extra.exmultgain
                card.ability.extra.hands_remaining = 0
                return {
                    extra = { message = "Upgrade!", colour = G.C.GREEN}
                }
            end
        end
        if context.joker_main and not context.blueprint then
            if next(SMODS.find_mod("Talisman")) then
                return {
                    emult = card.ability.extra.exmult,
                }
            else
                return {
                    xmult = mult ^ (card.ability.extra.exmult-1),
                    extra = { message = "^"..card.ability.extra.exmult.." Mult", colour = G.C.DARK_EDITION}
                }
            end
        end
    end
}



-- Upside Down House
SMODS.Joker{
    key = "upside_down_house",
    atlas = "atlashouse", pos = {x = 4, y = 0},

    rarity = 2,
    cost = 5,

    pools = {["MuchoHouses"] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { hands_remaining = 0, needed_hands = 'naneinf', exmult = 114 }},
    
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_upside_down_house",
            vars = {card.ability.extra.exmult, card.ability.extra.needed_hands},
            colours = {},
        }
    end,
}



-- Long House
SMODS.Joker{
    key = "long_house",
    atlas = "atlashouse", pos = {x = 5, y = 0},

    rarity = 2,
    cost = 5,

    pools = {["MuchoHouses"] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { hands_remaining = 0, needed_hands = 1140, exmult = 40 }},
    
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_long_house",
            vars = {card.ability.extra.exmult, card.ability.extra.hands_remaining, card.ability.extra.needed_hands},
            colours = {},
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            if card.ability.extra.hands_remaining < card.ability.extra.needed_hands then
                card.ability.extra.hands_remaining = card.ability.extra.hands_remaining + G.GAME.muchohandgain
                return {
                    extra = { message = card.ability.extra.hands_remaining.."/"..card.ability.extra.needed_hands, colour = G.C.GREEN}
                }
            end
        end
        if context.joker_main and not context.blueprint and card.ability.extra.hands_remaining >= card.ability.extra.needed_hands then
            if next(SMODS.find_mod("Talisman")) then
                return {
                    emult = card.ability.extra.exmult,
                }
            else
                return {
                    xmult = mult ^ (card.ability.extra.exmult-1),
                    extra = { message = "^"..card.ability.extra.exmult.." Mult", colour = G.C.DARK_EDITION}
                }
            end
        end
    end
}



-- Bubble Gum Machine House
SMODS.Joker{
    key = "bubble_gum_machine_house",
    atlas = "atlashouse", pos = {x = 6, y = 0},

    rarity = 3,
    cost = 9,

    pools = {["MuchoHouses"] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { hands_remaining = 0, needed_hands = 11, exmult = 1, exmultgain = 0.25, odds = 4 }},
    
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_bubble_gum_machine_house",
            vars = {card.ability.extra.exmult, G.GAME.probabilities.normal, card.ability.extra.odds, card.ability.extra.hands_remaining, card.ability.extra.needed_hands, card.ability.extra.exmultgain},
            colours = {},
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            if card.ability.extra.hands_remaining < card.ability.extra.needed_hands then
                card.ability.extra.hands_remaining = card.ability.extra.hands_remaining + G.GAME.muchohandgain
                return {
                    extra = { message = card.ability.extra.hands_remaining.."/"..card.ability.extra.needed_hands, colour = G.C.GREEN}
                }
            end
            if card.ability.extra.hands_remaining >= card.ability.extra.needed_hands then
                if pseudorandom("upgrade emult?") < G.GAME.probabilities.normal / card.ability.extra.odds then
                    card.ability.extra.exmult = card.ability.extra.exmult + card.ability.extra.exmultgain
                    card.ability.extra.hands_remaining = 0
                    return {
                        extra = { message = "Upgrade!", colour = G.C.GREEN}
                    }
                else
                    return {
                        extra = { message = "Upgrade failed!", colour = G.C.RED}
                    }
                end
            end
        end
        if context.joker_main and not context.blueprint then
            if next(SMODS.find_mod("Talisman")) then
                    return {
                        emult = card.ability.extra.exmult,
                    }
            else
                if card.ability.extra.exmult > 1 then
                    return {
                        xmult = mult ^ (card.ability.extra.exmult-1),
                        extra = { message = "^"..card.ability.extra.exmult.." Mult", colour = G.C.DARK_EDITION}
                    }
                end
            end
        end
    end
}



-- Doorless House
SMODS.Joker{
    key = "doorless_house",
    atlas = "atlashouse", pos = {x = 7, y = 0},

    rarity = 2,
    cost = 5,

    pools = {["MuchoHouses"] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { hands_remaining = 0, needed_hands = 171, exmult = 4 }},
    
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_doorless_house",
            vars = {card.ability.extra.exmult, card.ability.extra.hands_remaining, card.ability.extra.needed_hands},
            colours = {},
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            if card.ability.extra.hands_remaining < 99999 then -- useful for this joker; useless for any other jokers. exceedingly high arbitrary value to circumvent prevention of progress in the hand counter
                card.ability.extra.hands_remaining = card.ability.extra.hands_remaining + G.GAME.muchohandgain
                return {
                    extra = { message = card.ability.extra.hands_remaining.."/"..card.ability.extra.needed_hands, colour = G.C.GREEN}
                }
            end
        end
        if context.joker_main and not context.blueprint and card.ability.extra.hands_remaining >= card.ability.extra.needed_hands then
            if next(SMODS.find_mod("Talisman")) then
                return {
                    emult = card.ability.extra.exmult,
                }
            else
                return {
                    xmult = mult ^ (card.ability.extra.exmult-1),
                    extra = { message = "^"..card.ability.extra.exmult.." Mult", colour = G.C.DARK_EDITION}
                }
            end
        end
        if context.end_of_round and context.cardarea == G.jokers then
            card.ability.extra.needed_hands = pseudorandom("changeneededhands!", 1, 200)
        end
    end
}



-- Realistic House
SMODS.Joker{
    key = "realistic_house",
    atlas = "atlashouse", pos = {x = 8, y = 0},

    rarity = 2,
    cost = 5,

    pools = {["MuchoHouses"] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { hands_remaining = 0, needed_hands = 171, exmult = 4.01 }},
    
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_realistic_house",
            vars = {card.ability.extra.exmult, card.ability.extra.hands_remaining, card.ability.extra.needed_hands},
            colours = {},
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            if card.ability.extra.hands_remaining < card.ability.extra.needed_hands then
                card.ability.extra.hands_remaining = card.ability.extra.hands_remaining + G.GAME.muchohandgain
                return {
                    extra = { message = card.ability.extra.hands_remaining.."/"..card.ability.extra.needed_hands, colour = G.C.GREEN}
                }
            end
        end
        if context.joker_main and not context.blueprint and card.ability.extra.hands_remaining >= card.ability.extra.needed_hands then
            if next(SMODS.find_mod("Talisman")) then
                return {
                    emult = card.ability.extra.exmult,
                }
            else
                return {
                    xmult = mult ^ (card.ability.extra.exmult-1),
                    extra = { message = "^"..card.ability.extra.exmult.." Mult", colour = G.C.DARK_EDITION}
                }
            end
        end
    end
}



-- Not a House
SMODS.Joker{
    key = "not_a_house",
    atlas = "atlashouse", pos = {x = 9, y = 0}, soul_pos = {x = 9, y = 1},

    rarity = "mucho_rarerthanrare",
    cost = 15,

    pools = {["MuchoHouses"] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,


    config = { extra = { hands_remaining = 0, needed_hands = 11, exmult = 1, exmultgain = 0.171 }},
    
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_not_a_house",
            vars = {card.ability.extra.exmult, card.ability.extra.hands_remaining, card.ability.extra.needed_hands, card.ability.extra.exmultgain},
            colours = {},
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            if card.ability.extra.hands_remaining < card.ability.extra.needed_hands then
                card.ability.extra.hands_remaining = card.ability.extra.hands_remaining + G.GAME.muchohandgain
                return {
                    extra = { message = card.ability.extra.hands_remaining.."/"..card.ability.extra.needed_hands, colour = G.C.GREEN}
                }
            end
            if card.ability.extra.hands_remaining >= card.ability.extra.needed_hands then
                card.ability.extra.exmult = card.ability.extra.exmult + card.ability.extra.exmultgain
                card.ability.extra.hands_remaining = 0
                return {
                    extra = { message = "Upgrade!", colour = G.C.GREEN}
                }
            end
        end
        if context.joker_main and not context.blueprint then
            if next(SMODS.find_mod("Talisman")) then
                return {
                    emult = card.ability.extra.exmult,
                }
            else
                return {
                    xmult = mult ^ (card.ability.extra.exmult-1),
                    extra = { message = "^"..card.ability.extra.exmult.." Mult", colour = G.C.DARK_EDITION}
                }
            end
        end
    end
}



-- AI-Generated House
SMODS.Joker{
    key = "ai_generated_house",
    atlas = "atlashouse", pos = {x = 10, y = 0},

    rarity = 1,
    cost = 3,

    pools = {["MuchoHouses"] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { hands_remaining = 0, needed_hands = 171, exmult = 4, videos_remaining = 0, needed_videos = 43, odds = 3 }},
    
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_ai_generated_house",
            vars = {card.ability.extra.exmult, card.ability.extra.hands_remaining, card.ability.extra.needed_hands, card.ability.extra.needed_videos, card.ability.extra.videos_remaining, G.GAME.probabilities.normal, card.ability.extra.odds},
            colours = {},
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            if card.ability.extra.hands_remaining < card.ability.extra.needed_hands then
                card.ability.extra.hands_remaining = card.ability.extra.hands_remaining + G.GAME.muchohandgain
                return {
                    extra = { message = card.ability.extra.hands_remaining.."/"..card.ability.extra.needed_hands, colour = G.C.GREEN}
                }
            end
            if card.ability.extra.videos_remaining < card.ability.extra.needed_videos then
                G.FUNCS.overlay_menu{
                    definition = Create_UIBox_custom_video1("5sec",'Not enough Videos watched! Please watch this one.', 5),
                    config = {no_esc = true},
                    pause = true
                }
            end
        end
        if context.joker_main and not context.blueprint and card.ability.extra.hands_remaining >= card.ability.extra.needed_hands and card.ability.extra.videos_remaining >= card.ability.extra.needed_videos then
            if next(SMODS.find_mod("Talisman")) then
                return {
                    emult = card.ability.extra.exmult,
                }
            else
                return {
                    xmult = mult ^ (card.ability.extra.exmult-1),
                    extra = { message = "^"..card.ability.extra.exmult.." Mult", colour = G.C.DARK_EDITION}
                }
            end
        end
    end
}



-- Lots of Houses Stacked on One Another
SMODS.Joker{
    key = "lots_of_houses_stacked_on_one_another",
    atlas = "atlashouse", pos = {x = 11, y = 0},

    rarity = 3,
    cost = 9,

    pools = {["MuchoHouses"] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { hands_remaining = 0, needed_hands = 57, exmult = 4 }},
    
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_lots_of_houses_stacked_on_one_another",
            vars = {card.ability.extra.exmult, card.ability.extra.hands_remaining, card.ability.extra.needed_hands},
            colours = {},
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            if card.ability.extra.hands_remaining < card.ability.extra.needed_hands then
                card.ability.extra.hands_remaining = card.ability.extra.hands_remaining + G.GAME.muchohandgain
                return {
                    extra = { message = card.ability.extra.hands_remaining.."/"..card.ability.extra.needed_hands, colour = G.C.GREEN}
                }
            end
        end
        if context.joker_main and not context.blueprint and card.ability.extra.hands_remaining >= card.ability.extra.needed_hands then
            if next(SMODS.find_mod("Talisman")) then
                return {
                    emult = card.ability.extra.exmult,
                    xmult = card.ability.extra.exmult,
                    mult = card.ability.extra.exmult,
                    echips = card.ability.extra.exmult,
                    xchips = card.ability.extra.exmult,
                    chips = card.ability.extra.exmult,
                }
            else
                return {
                    xmult = mult ^ (card.ability.extra.exmult+1),
                    extra = { message = "You're getting ^6 Mult as a compensation for not using Talisman", colour = G.C.DARK_EDITION}
                }
            end
        end
    end
}




-- Negative House
SMODS.Joker{
    key = "negative_house",
    atlas = "atlashouse", pos = {x = 12, y = 0},

    rarity = 2,
    cost = 5,

    pools = {["MuchoHouses"] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { hands_remaining = 0, needed_hands = 171, exmult = 4, needed_hands2 = 2 }},
    
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_negative_house",
            vars = {card.ability.extra.exmult, card.ability.extra.hands_remaining, card.ability.extra.needed_hands, card.ability.extra.needed_hands2},
            colours = {},
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            if card.ability.extra.hands_remaining < card.ability.extra.needed_hands then
                card.ability.extra.hands_remaining = card.ability.extra.hands_remaining + G.GAME.muchohandgain
                return {
                    extra = { message = card.ability.extra.hands_remaining.."/"..card.ability.extra.needed_hands, colour = G.C.GREEN}
                }
            end
        end
        if context.joker_main and not context.blueprint and card.ability.extra.hands_remaining >= card.ability.extra.needed_hands then
            if next(SMODS.find_mod("Talisman")) then
                return {
                    emult = card.ability.extra.exmult,
                }
            else
                return {
                    xmult = mult ^ (card.ability.extra.exmult-1),
                    extra = { message = "^"..card.ability.extra.exmult.." Mult", colour = G.C.DARK_EDITION}
                }
            end
        end
        if context.joker_main and not context.blueprint and not (card.edition and card.edition.negative) then
            if card.ability.extra.hands_remaining >= card.ability.extra.needed_hands2 then
                card:set_edition('e_negative')
            end
        end
    end
}



-- Doctor House
SMODS.Joker{
    key = "doctor_house",
    atlas = "atlashouse", pos = {x = 13, y = 0},

    rarity = 2,
    cost = 8,

    pools = {["MuchoHouses"] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { hands_remaining = 0, needed_hands = 22, exmult = 3, }},
    
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_doctor_house",
            vars = {card.ability.extra.exmult, card.ability.extra.hands_remaining, card.ability.extra.needed_hands},
            colours = {},
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint and next(context.poker_hands['Full House']) then
            if card.ability.extra.hands_remaining < card.ability.extra.needed_hands then
                card.ability.extra.hands_remaining = card.ability.extra.hands_remaining + G.GAME.muchohandgain
                return {
                    extra = { message = card.ability.extra.hands_remaining.."/"..card.ability.extra.needed_hands, colour = G.C.GREEN}
                }
            end
        end
        if context.joker_main and not context.blueprint and card.ability.extra.hands_remaining >= card.ability.extra.needed_hands then
            if next(SMODS.find_mod("Talisman")) then
                return {
                    emult = card.ability.extra.exmult,
                }
            else
                return {
                    xmult = mult ^ (card.ability.extra.exmult-1),
                    extra = { message = "^"..card.ability.extra.exmult.." Mult", colour = G.C.DARK_EDITION}
                }
            end
        end
    end
}


-- Roofless House
SMODS.Joker{
    key = "roofless_house",
    atlas = "atlashouse", pos = {x = 14, y = 0},

    rarity = "mucho_rarerthanrare",
    cost = 15,

    pools = {["MuchoHouses"] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { hands_remaining = 0, needed_hands = 171, exmult = 1.99 }},
    
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_roofless_house",
            vars = {card.ability.extra.exmult, card.ability.extra.hands_remaining, card.ability.extra.needed_hands},
            colours = {},
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main and not context.blueprint then
            if next(SMODS.find_mod("Talisman")) then
                return {
                    emult = card.ability.extra.exmult,
                }
            else
                return {
                    xmult = mult ^ (card.ability.extra.exmult-1),
                    extra = { message = "^"..card.ability.extra.exmult.." Mult", colour = G.C.DARK_EDITION}
                }
            end
        end
    end
}

-- Houseless Roof
SMODS.Joker{
    key = "houseless_roof",
    atlas = "atlashouse", pos = {x = 15, y = 0},

    rarity = 1,
    cost = 3,

    pools = {["MuchoHouses"] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { hands_remaining = 0, needed_hands = 171, exmult = 1.99 }},
    
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_houseless_roof",
            vars = {card.ability.extra.exmult, card.ability.extra.hands_remaining, card.ability.extra.needed_hands},
            colours = {},
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            if card.ability.extra.hands_remaining < card.ability.extra.needed_hands then
                card.ability.extra.hands_remaining = card.ability.extra.hands_remaining + G.GAME.muchohandgain
                return {
                    extra = { message = card.ability.extra.hands_remaining.."/"..card.ability.extra.needed_hands, colour = G.C.GREEN}
                }
            end
        end
    end
}



-- House with a Long Roof
SMODS.Joker{
    key = "house_with_a_long_roof",
    atlas = "atlashouse", pos = {x = 16, y = 0},

    rarity = 1,
    cost = 3,

    pools = {["MuchoHouses"] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { hands_remaining = 0, needed_hands = 513, exmult = 4 }},
    
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_house_with_a_long_roof",
            vars = {card.ability.extra.exmult, card.ability.extra.hands_remaining, card.ability.extra.needed_hands},
            colours = {},
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            if card.ability.extra.hands_remaining < card.ability.extra.needed_hands then
                card.ability.extra.hands_remaining = card.ability.extra.hands_remaining + G.GAME.muchohandgain
                return {
                    extra = { message = card.ability.extra.hands_remaining.."/"..card.ability.extra.needed_hands, colour = G.C.GREEN}
                }
            end
        end
        if context.joker_main and not context.blueprint and card.ability.extra.hands_remaining >= card.ability.extra.needed_hands then
            if next(SMODS.find_mod("Talisman")) then
                return {
                    emult = card.ability.extra.exmult,
                }
            else
                return {
                    xmult = mult ^ (card.ability.extra.exmult-1),
                    extra = { message = "^"..card.ability.extra.exmult.." Mult", colour = G.C.DARK_EDITION}
                }
            end
        end
    end
}



-- Incredibly Small House with a Long Roof
SMODS.Joker{
    key = "incredibly_small_house_with_a_long_roof",
    atlas = "atlashouse", pos = {x = 17, y = 0},

    rarity = 1,
    cost = 3,

    pools = {["MuchoHouses"] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { hands_remaining = 0, needed_hands = 513, exmult = 1.01 }},
    
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_incredibly_small_house_with_a_long_roof",
            vars = {card.ability.extra.exmult, card.ability.extra.hands_remaining, card.ability.extra.needed_hands},
            colours = {},
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            if card.ability.extra.hands_remaining < card.ability.extra.needed_hands then
                card.ability.extra.hands_remaining = card.ability.extra.hands_remaining + G.GAME.muchohandgain
                return {
                    extra = { message = card.ability.extra.hands_remaining.."/"..card.ability.extra.needed_hands, colour = G.C.GREEN}
                }
            end
        end
        if context.joker_main and not context.blueprint and card.ability.extra.hands_remaining >= card.ability.extra.needed_hands then
            if next(SMODS.find_mod("Talisman")) then
                return {
                    emult = card.ability.extra.exmult,
                }
            else
                return {
                    xmult = mult ^ (card.ability.extra.exmult-1),
                    extra = { message = "^"..card.ability.extra.exmult.." Mult", colour = G.C.DARK_EDITION}
                }
            end
        end
    end
}



-- Inverted House
SMODS.Joker{
    key = "inverted_house",
    atlas = "atlashouse", pos = {x = 18, y = 0},

    rarity = 3,
    cost = 9,

    pools = {["MuchoHouses"] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { hands_remaining = 0, needed_hands = 17, exmult = 3 }},
    
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_inverted_house",
            vars = {card.ability.extra.exmult, card.ability.extra.hands_remaining, card.ability.extra.needed_hands},
            colours = {},
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            if card.ability.extra.hands_remaining < card.ability.extra.needed_hands then
                card.ability.extra.hands_remaining = card.ability.extra.hands_remaining + G.GAME.muchohandgain
                return {
                    extra = { message = card.ability.extra.hands_remaining.."/"..card.ability.extra.needed_hands, colour = G.C.GREEN}
                }
            end
        end
        if context.joker_main and not context.blueprint and card.ability.extra.hands_remaining >= card.ability.extra.needed_hands then
            if next(SMODS.find_mod("Talisman")) then
                card.ability.extra.hands_remaining = 0
                return {
                    emult = card.ability.extra.exmult,
                    extra = { message = "Hands reset!", colour = G.C.BLACK},
                }
            else
                card.ability.extra.hands_remaining = 0
                return {
                    xmult = mult ^ (card.ability.extra.exmult-1),
                    extra = { message = "^"..card.ability.extra.exmult.." Mult", colour = G.C.DARK_EDITION},
                }
            end
        end
    end
}



-- Inverted House
SMODS.Joker{
    key = "the_house",
    atlas = "atlashouse", pos = {x = 19, y = 0}, soul_pos = {x = 19, y = 1},

    rarity = 'mucho_exceptional',
    cost = 30,

    pools = {["MuchoHouses"] = true},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    config = { extra = { hands_remaining = 0, needed_hands = 114, exmult = 4, handgain = 4 }},
    
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_the_house",
            vars = {card.ability.extra.exmult, card.ability.extra.hands_remaining, card.ability.extra.needed_hands, card.ability.extra.handgain},
            colours = {},
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        G.GAME.muchohandgain = G.GAME.muchohandgain + card.ability.extra.handgain
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.muchohandgain = G.GAME.muchohandgain - card.ability.extra.handgain
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            if card.ability.extra.hands_remaining < card.ability.extra.needed_hands then
                card.ability.extra.hands_remaining = card.ability.extra.hands_remaining + G.GAME.muchohandgain
                return {
                    extra = { message = card.ability.extra.hands_remaining.."/"..card.ability.extra.needed_hands, colour = G.C.GREEN}
                }
            end
        end
        if context.joker_main and not context.blueprint and card.ability.extra.hands_remaining >= card.ability.extra.needed_hands then
            if next(SMODS.find_mod("Talisman")) then
                return {
                    emult = card.ability.extra.exmult,
                }
            else
                return {
                    xmult = mult ^ (card.ability.extra.exmult-1),
                    extra = { message = "^"..card.ability.extra.exmult.." Mult", colour = G.C.DARK_EDITION}
                }
            end
        end
    end
}


