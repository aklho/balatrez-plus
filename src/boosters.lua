SMODS.Atlas{
    key = 'boosteratlas',
    path = 'boosteratlas.png',
    px = 142,
    py = 192,
}

SMODS.Sound({
    key = "music_balatrez",
    path = "music_balatrez.ogg",
    pitch = 1,
    volume = 0.6,
    select_music_track = function()
        if G.STATE == G.STATES.SMODS_BOOSTER_OPENED then
            if G.pack_cards
                and G.pack_cards.cards
                and G.pack_cards.cards[1]
                and G.pack_cards.cards[1].config
                and G.pack_cards.cards[1].config.center
                and G.pack_cards.cards[1].config.center.mod
                and G.pack_cards.cards[1].config.center.mod.id 
                and G.pack_cards.cards[1].config.center.mod.id == "muchoJokers" then
		        return true 
            end
        end
	end,
})

SMODS.Sound({
    key = "music_bohemian",
    path = "music_bohemian.ogg",
    pitch = 1,
    volume = 0.6,
    select_music_track = function()
        if G.STATE == G.STATES.SMODS_BOOSTER_OPENED then
            if G.pack_cards
                and G.pack_cards.cards
                and G.pack_cards.cards[1]
                and G.pack_cards.cards[1].config
                and G.pack_cards.cards[1].config.center
                and G.pack_cards.cards[1].config.center.rarity
                and G.pack_cards.cards[1].config.center.rarity == 4 then
		        return true 
            end
        end
	end,
})


SMODS.Booster{
    key = 'booster_balatrez',

    atlas = 'boosteratlas', 
    pos = { x = 0, y = 0 },

    loc_txt= {
        name = 'Balatrez Balatrito Booster Pack',
        text = { "Choose {C:attention}#1#{} of up",
                "to {C:attention}#2#{} {V:1}Balatrez+{} joker cards", },
        group_name = {"Sale balatrito?"},
    },
    draw_hand = false,
    config = {
        extra = 2,
        choose = 1
    },
    cost = 4,
    weight = 1.2,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {G.C.SECONDARY_SET.Enhanced} } }
    end,
    kind = "balatrezboosters",

    create_card = function(self, card)
        return {set = "BalatrezAddition", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "mucho"}
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.RED)
        ease_background_colour({ new_colour = G.C.RED, special_colour = G.C.BLACK, contrast = 2 })
    end,
}


SMODS.Booster{
    key = 'booster_balatrez_large',

    atlas = 'boosteratlas', 
    pos = { x = 1, y = 0 },

    loc_txt= {
        name = 'Largo Balatrez Balatrito Booster Pack',
        text = { "Choose {C:attention}#1#{} of up",
                "to {C:attention}#2#{} {V:1}Balatrez+{} joker cards", },
        group_name = {"Sale balatrito?"},
    },
    draw_hand = false,
    config = {
        extra = 4,
        choose = 1
    },
    cost = 6,
    weight = 0.6,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {G.C.SECONDARY_SET.Enhanced} } }
    end,
    kind = "balatrezboosters",

    create_card = function(self, card)
        return {set = "BalatrezAddition", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "mucho"}
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.WHITE)
        ease_background_colour({ new_colour = G.C.WHITE, special_colour = G.C.BLACK, contrast = 2 })
    end,
}

SMODS.Booster{
    key = 'booster_balatrez_grandioso',

    atlas = 'boosteratlas', 
    pos = { x = 0, y = 1 },

    loc_txt= {
        name = 'Grandioso Balatrez Balatrito Booster Pack',
        text = { "Choose {C:attention}#1#{} of up",
                "to {C:attention}#2#{} {V:1}Balatrez+{} joker cards", },
        group_name = {"Sale balatrito?"},
    },
    draw_hand = false,
    config = {
        extra = 4,
        choose = 2
    },
    cost = 8,
    weight = 0.4,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {G.C.SECONDARY_SET.Enhanced} } }
    end,
    kind = "balatrezboosters",

    create_card = function(self, card)
        return {set = "BalatrezAddition", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "mucho"}
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX('46B678'))
        ease_background_colour({ new_colour = HEX('46B678'), special_colour = HEX('B94987'), contrast = 2 })
    end,
}

SMODS.Booster{
    key = 'booster_balatrez_Fabuloso',

    atlas = 'boosteratlas', 
    pos = { x = 1, y = 1 },

    loc_txt= {
        name = 'Fabuloso Balatrez Balatrito Booster Pack',
        text = { "Choose {C:attention}#1#{} of up",
                "to {C:attention}#2#{} {V:1}Balatrez+{} joker cards", },
        group_name = {"Sale balatrito?"},
    },
    draw_hand = false,
    config = {
        extra = 7,
        choose = 2
    },
    cost = 13,
    weight = 0.2,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {G.C.SECONDARY_SET.Enhanced} } }
    end,
    kind = "balatrezboosters",

    create_card = function(self, card)
        return {set = "BalatrezAddition", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "mucho"}
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX('F9EDD3'))
        ease_background_colour({ new_colour = HEX('F9EDD3'), special_colour = HEX('4E73C2'), contrast = 2 })
    end,
}

SMODS.Booster{
    key = 'negative_buffoon',

    atlas = 'boosteratlas', 
    pos = { x = 0, y = 2 },

    loc_txt= {
        name = 'Negative Buffoon Pack',
        text = { "Choose {C:attention}#1#{} of up",
                "to {C:attention}#2#{} {V:1}Negative{} joker cards", },
        group_name = {"Make your choice!"},
    },
    draw_hand = false,
    config = {
        extra = 2,
        choose = 1
    },
    cost = 12,
    weight = 0.12,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {G.C.DARK_EDITION} } }
    end,
    kind = "vanillalikeboosters",
    skip_materialize = true,
    create_card = function(self, card)
        return {set = "Joker", area = G.pack_cards, skip_materialize = true, soulable = true, edition = "e_negative"}
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX('04BEAA'))
        ease_background_colour({ new_colour = HEX('04BEAA'), special_colour = HEX('000000'), contrast = 2 })
    end

    
}

SMODS.Booster{
    key = 'negative_arcana',

    atlas = 'boosteratlas',
    pos = { x = 1, y = 2 },

    loc_txt= {
        name = 'Negative Arcana Pack',
        text = { "Choose {C:attention}#1#{} of up",
                "to {C:attention}#2#{} {V:1}Negative{} {V:2}Tarot{} cards",
                "to be {C:attention}kept{}" },
        group_name = {"Make your choice!"},
    },
    draw_hand = false,
    config = {
        extra = 3,
        choose = 1
    },
    cost = 12,
    weight = 0.4,
    select_card = "consumeables",
    skip_materialize = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {G.C.DARK_EDITION, G.C.SECONDARY_SET.Tarot} } }
    end,
    kind = "vanillalikeboosters",

    create_card = function(self, card)
        return {set = "Tarot", area = G.pack_cards, skip_materialize = true, soulable = true, edition = "e_negative"}
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX('6C9643'))
        ease_background_colour({ new_colour = HEX('6C9643'), special_colour = HEX('000000'), contrast = 2 })
    end
}

SMODS.Booster{
    key = 'negative_celestial',

    atlas = 'boosteratlas', 
    pos = { x = 0, y = 3 },

    loc_txt= {
        name = 'Negative Celestial Pack',
        text = { "Choose {C:attention}#1#{} of up",
                "to {C:attention}#2#{} {V:1}Negative{} {V:2}Planet{} cards",
                "to be {C:attention}kept{}" },
        group_name = {"Make your choice!"},
    },
    draw_hand = false,
    config = {
        extra = 3,
        choose = 1
    },
    cost = 12,
    weight = 0.4,
    select_card = "consumeables",
    skip_materialize = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {G.C.DARK_EDITION, G.C.SECONDARY_SET.Planet} } }
    end,
    kind = "vanillalikeboosters",

    create_card = function(self, card)
        return {set = "Planet", area = G.pack_cards, skip_materialize = true, soulable = true, edition = "e_negative"}
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX('A87E3E'))
        ease_background_colour({ new_colour = HEX('A87E3E'), special_colour = HEX('000000'), contrast = 2 })
    end
}

SMODS.Booster{
    key = 'negative_spectral',

    atlas = 'boosteratlas', 
    pos = { x = 1, y = 3 },

    loc_txt= {
        name = 'Negative Spectral Pack',
        text = { "Choose {C:attention}#1#{} of up",
                "to {C:attention}#2#{} {V:1}Negative{} {V:2}Spectral{} cards",
                "to be {C:attention}kept{}" },
        group_name = {"Make your choice!"},
    },
    draw_hand = false,
    config = {
        extra = 2,
        choose = 1
    },
    cost = 12,
    weight = 0.06,
    select_card = "consumeables",
    skip_materialize = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {G.C.DARK_EDITION, G.C.SECONDARY_SET.Spectral} } }
    end,
    kind = "vanillalikeboosters",

    create_card = function(self, card)
        return {set = "Spectral", area = G.pack_cards, skip_materialize = true, soulable = true, edition = "e_negative"}
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX('4953C1'))
        ease_background_colour({ new_colour = HEX('4953C1'), special_colour = HEX('C1AB47'), contrast = 2 })
    end
}

SMODS.Booster{
    key = 'keeper_arcana',

    atlas = 'boosteratlas',
    pos = { x = 0, y = 4 },

    loc_txt= {
        name = "Keeper's Arcana Pack",
        text = { "Choose {C:attention}#1#{} of up",
                "to {C:attention}#2#{} {V:2}Tarot{} cards",
                "to be {C:attention}kept{}" },
        group_name = {"Make your choice!"},
    },
    draw_hand = false,
    config = {
        extra = 5,
        choose = 1
    },
    cost = 8,
    weight = 1,
    select_card = "consumeables",
    skip_materialize = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {G.C.DARK_EDITION, G.C.SECONDARY_SET.Tarot} } }
    end,
    kind = "vanillalikeboosters",

    create_card = function(self, card)
        return {set = "Tarot", area = G.pack_cards, skip_materialize = true, soulable = true}
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Tarot)
        ease_background_colour({ new_colour = G.C.SECONDARY_SET.Tarot, special_colour = G.C.DARK_EDITION, contrast = 2 })
    end
}

SMODS.Booster{
    key = 'keeper_spectral',

    atlas = 'boosteratlas', 
    pos = { x = 1, y = 4 },

    loc_txt= {
        name = "Keeper's Spectral Pack",
        text = { "Choose {C:attention}#1#{} of up",
                "to {C:attention}#2#{} {V:2}Spectral{} cards",
                "to be {C:attention}kept{}" },
        group_name = {"Make your choice!"},
    },
    draw_hand = false,
    config = {
        extra = 4,
        choose = 1
    },
    cost = 8,
    weight = 0.1,
    select_card = "consumeables",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {G.C.DARK_EDITION, G.C.SECONDARY_SET.Spectral} } }
    end,
    kind = "vanillalikeboosters",

    create_card = function(self, card)
        return {set = "Spectral", area = G.pack_cards, skip_materialize = true, soulable = true}
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Spectral)
        ease_background_colour({ new_colour = G.C.SECONDARY_SET.Spectral, special_colour = G.C.DARK_EDITION, contrast = 2 })
    end
}

SMODS.Booster{
    key = 'balatrianrhapsody',

    atlas = 'boosteratlas', 
    pos = { x = 0, y = 5 },

    loc_txt= {
        name = "Balatrian Rhapsody",
        text = { "Choose {C:attention}#1#{} out of all",
                "vanilla {V:1}Legendary{} Joker cards" },
        group_name = {"Is this the real life? Is this just fantasy?"},
    },
    draw_hand = false,
    config = {
        extra = 5,
        choose = 1
    },
    cost = 25,
    weight = 0.01,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {G.C.RARITY[4], G.C.SECONDARY_SET.Spectral} } }
    end,
    kind = "vanillalikeboosters",

    create_card = function(self, card, i)
        local legkey = "j.reserved_parking"
        if i == 1 then
            legkey = "j_caino"
        end
        if i == 2 then
            legkey = "j_chicot"
        end
        if i == 3 then
            legkey = "j_perkeo"
        end
        if i == 4 then
            legkey = "j_triboulet"
        end
        if i == 5 then
            legkey = "j_yorick"
        end
        return {set = "Joker", area = G.pack_cards, legendary = true, skip_materialize = true, soulable = true, key = legkey}
    end,


    d_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
        ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.BLACK, contrast = 0 })
    end,
}

SMODS.Booster{
    key = 'TESTBOOSTER',

    atlas = 'boosteratlas', 
    pos = { x = 0, y = 0 },

    loc_txt= {
        name = 'Negative Buffoon Pack',
        text = { "Choose {C:attention}#1#{} of up",
                "to {C:attention}#2#{} joker cards", },
        group_name = {"Make your choice!"},
    },
    draw_hand = false,
    config = {
        extra = 150,
        choose = 1
    },
    cost = 1,
    weight = 0.00001,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
    kind = "vanillalikeboosters",

    create_card = function(self, card)
        return {set = "Joker", area = G.pack_cards, skip_materialize = true, }
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.EDITION)
        ease_background_colour({ new_colour = G.C.EDITION, special_colour = G.C.DARK_EDITION, contrast = 0 })
    end,
}