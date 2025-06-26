SMODS.Atlas {
    key = "mucho_deck",
    path = "mucho_deck.png",
    px = 71,
    py = 95
}

SMODS.Back{ -- Lowkey Deck
	key = "fivesuitdeck", 
    loc_txt = {
        name = "Five-Suit Deck",
        text = {
            "Deck starts with a fifth suit and",
            "an additional card rank"
        }
    },
    atlas = 'mucho_deck',
	pos = {x = 0, y = 0},
	
	unlocked = true,

    config = {},
    loc_vars = function(self)
        return {vars = {}}
    end,

    apply = function(self)
		
		--Enable all the pool flags
		setPoolRankFlagEnable('mucho_Troubadour', true);
	
		--Notice: used card_key version and not standard key
		local added_rank = {'mucho_Troubadour'}
				
		local all_suit = {}
		
		for k, v in pairs(SMODS.Suits) do
			--If has in_pool, check in_pool
			if type(v) == 'table' and type(v.in_pool) == 'function' and v.in_pool then
				if v:in_pool({initial_deck = true}) then
					all_suit[#all_suit+1] = v.card_key
				end
			else --Otherwise, added by default
				all_suit[#all_suit+1] = v.card_key
			end
			
		end
		
		--print(inspect(all_suit))
		
		local extra_cards = {}
		
		for i=1, #all_suit do
			for j=1, #added_rank do
				extra_cards[#extra_cards+1] = {s = all_suit[i], r = added_rank[j]}
			end
		end
		
		G.GAME.starting_params.extra_cards = extra_cards
		
		
    end,

}
