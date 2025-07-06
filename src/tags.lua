SMODS.Atlas {
    key = "tagatlas",
    path = "tagatlas.png",
    px = 34,
    py = 34
}

SMODS.Tag {
    key = "rarerthanraretag",
    loc_txt = {
        name = '"Rarer than Rare" Tag',
        text = {
            "Shop has a {C:green}#1# in #2#{} chance to have",
            "a free {V:1}Rarer than Rare{} {C:attention}Joker{}",
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.GAME.probabilities.normal,
                card.config.prob2,
                colours = {
                    HEX("a83283")
                }
            }
        } end,
    config = {prob2 = 2},
    min_ante = 1,
    atlas = "tagatlas", pos = {x=0, y=0},
    apply = function(self, tag, context)
        if pseudorandom("rarerthanraretag") < G.GAME.probabilities.normal / self.config.prob2 and context.type == 'store_joker_create' then
            local card = SMODS.create_card {
                set = "Joker",
                rarity = "mucho_rarerthanrare",
                area = context.area,
                key_append = "vremade_uta"
            }
            create_shop_card_ui(card, 'Joker', context.area)
            card.states.visible = false
            tag:yep('+', HEX("a83283"), function()
                card:start_materialize()
                card.ability.couponed = true
                card:set_cost()
                return true
            end)
            tag.triggered = true
            return card
        elseif pseudorandom("rarerthanraretag") > G.GAME.probabilities.normal / self.config.prob2 and context.type == 'store_joker_create' then
            tag:nope()
            tag.triggered = true
        end
    end
}


SMODS.Tag{
    key = 'balatrezbooster1',
    loc_txt = {
        name = '"Chicot" Tag',
        text = {
            "Gives a free",
            "{C:attention}Balatrez Balatrito Booster Pack"
        }
    },
    pos = {x = 1, y = 0},
    min_ante = 1,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', HEX("e87f83"),function()
                local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
                G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS['p_mucho_booster_balatrez'], {bypass_discovery_center = true, bypass_discovery_ui = true})
                card.cost = 0
                card.from_tag = true
                G.FUNCS.use_card({config = {ref_table = card}})
                card:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end,
    atlas = "tagatlas",
}

SMODS.Tag{
    key = 'balatrezbooster2',
    loc_txt = {
        name = '"Canio" Tag',
        text = {
            "Gives a free",
            "{C:attention}Largo Balatrez Balatrito Booster Pack"
        }
    },
    pos = {x = 2, y = 0},
    min_ante = 1,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', HEX("dbdbdb"),function()
                local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
                G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS['p_mucho_booster_balatrez_large'], {bypass_discovery_center = true, bypass_discovery_ui = true})
                card.cost = 0
                card.from_tag = true
                G.FUNCS.use_card({config = {ref_table = card}})
                card:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end,
    atlas = "tagatlas",
}

SMODS.Tag{
    key = 'balatrezbooster3',
    loc_txt = {
        name = '"Perkeo" Tag',
        text = {
            "Gives a free",
            "{C:attention}Grandioso Balatrez Balatrito Booster Pack"
        }
    },
    pos = {x = 3, y = 0},
    min_ante = 2,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', HEX("46b678"),function()
                local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
                G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS['p_mucho_booster_balatrez_grandioso'], {bypass_discovery_center = true, bypass_discovery_ui = true})
                card.cost = 0
                card.from_tag = true
                G.FUNCS.use_card({config = {ref_table = card}})
                card:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end,
    atlas = "tagatlas",
}

SMODS.Tag{
    key = 'balatrezbooster4',
    loc_txt = {
        name = '"Brainstorm" Tag',
        text = {
            "Gives a free",
            "{C:attention}Fabuloso Balatrez Balatrito Booster Pack"
        }
    },
    pos = {x = 4, y = 0},
    min_ante = 3,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', HEX("ffddaa"),function()
                local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
                G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS['p_mucho_booster_balatrez_Fabuloso'], {bypass_discovery_center = true, bypass_discovery_ui = true})
                card.cost = 0
                card.from_tag = true
                G.FUNCS.use_card({config = {ref_table = card}})
                card:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end,
    atlas = "tagatlas"
}