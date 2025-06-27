SMODS.Atlas {
    key = "mucho_deck",
    path = "mucho_deck.png",
    px = 71,
    py = 95
}

SMODS.Back{
    key = "xxl",
	loc_txt = {
		name = "Five-Suit Deck",
		text = {"Start run with {C:attention}a fifth suit{} and",
				"{C:attention}an additional rank{}"}

	},
    pos = {x = 0, y = 0},
    apply = function()
		enable_extras()
        G.E_MANAGER:add_event(Event({
            func = function()
                local cards_to_copy = {}
                for k, v in ipairs(G.deck.cards) do
                    cards_to_copy[#cards_to_copy+1] = v
                end
                for k, v in ipairs(cards_to_copy) do
					print(v:get_id())
					if v.base.suit == 'Clubs' then
						v:change_suit('mucho_leaves')
					end
					if v.base.suit == 'mucho_leaves' then
						G.playing_card = (G.playing_card and G.playing_card + 1) or 1
						local _card = copy_card(v)
						_card:add_to_deck()
						if _card.base.suit == 'mucho_leaves' then
							_card:change_suit('Clubs')
						end
						-- TODO: implement the troubadours (these fucks again)
						G.deck.config.card_limit = G.deck.config.card_limit + 1
						table.insert(G.playing_cards, _card)
						G.deck:emplace(_card)
					end
                end
				for k, v in ipairs(G.deck.cards) do -- change jacks in troubs
					if v:get_id() == 11 then
						assert(SMODS.change_base(v, nil, "mucho_Troubadour"))
					end
				end
				for k, v in ipairs(G.deck.cards) do -- recreate jacks
					if v:get_id() == 15 then
						G.playing_card = (G.playing_card and G.playing_card + 1) or 1
						local _card = copy_card(v)
						_card:add_to_deck()
						assert(SMODS.change_base(v, nil, "Jack"))
						G.deck.config.card_limit = G.deck.config.card_limit + 1
						table.insert(G.playing_cards, _card)
						G.deck:emplace(_card)
					end
				end
            return true
        end}))
    end,
    atlas = "mucho_deck"
}

SMODS.Back{
    name = "Fifty-two Red Seal Polychrome Steel Kings of Spades",
    key = "52rspsk",
	atlas = "mucho_deck",
    pos = {x = 1, y = 0},
    config = {polyglass = true},
    loc_txt = {
        name = "Fifty-two {C:red, T:Red}Red Seal {C:attention, T:e_polychrome}Polychrome {V:1, T:m_steel}Steel{} Kings of {V:2}Spades",
        text ={
            "Start run with",
            "fifty-two {C:red, T:Red}Red Seal {C:attention, T:e_polychrome}Polychrome {V:1, T:m_steel}Steel{} Kings of {V:2}Spades"
        },
    },
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				colours = {
					HEX('999999'),
					G.C.SUITS.Spades
				}
			}
		}
	end,
    apply = function()
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = #G.playing_cards, 1, -1 do
					assert(SMODS.change_base(G.playing_cards[i], "Spades", "King"))
                    G.playing_cards[i]:set_ability(G.P_CENTERS.m_steel)
					G.playing_cards[i]:set_seal("Red")
                    G.playing_cards[i]:set_edition({
                        polychrome = true
                    }, true, true)
                end
                return true
            end
        }))
    end
}
