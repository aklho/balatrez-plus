SMODS.Atlas {
    key = "suits",
    path = "suits.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "suitshc",
    path = "suitshc.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "troubadouratlas",
    path = "troubadour.png",
    px = 71,
    py = 95
}


SMODS.Atlas {
    key = "troubadouratlashc",
    path = "troubadourhc.png",
    px = 71,
    py = 95
}

 -- ! Code borrowed from Unstable mod, thanks!

function setPoolSuitFlagEnable(suit, isEnable)
	if not G.GAME or G.GAME.pool_flags[suit] == isEnable then return end
	
	G.GAME.pool_flags[suit] = isEnable
end

function setPoolRankFlagEnable(rank, isEnable)
	if not G.GAME or G.GAME.pool_flags[rank] == isEnable then return end
	
	G.GAME.pool_flags[rank] = isEnable
end

function getPoolRankFlagEnable(rank)
	return (G.GAME and G.GAME.pool_flags[rank] or false)
end

function getPoolSuitFlagEnable(suit)
	return (G.GAME and G.GAME.pool_flags[suit] or false)
end

--Shared pool rank checking function
local function unstb_rankCheck(self, args)
	if args and args.initial_deck then
        return false
    end
	
	return getPoolRankFlagEnable(self.key)
end
-- end of borrowed code

function CheckifRank(rank)
    local passed = false
    for k, v in pairs(G.playing_cards) do
        if v:get_id() == rank then
            passed = true
            break
        end
    end
end

SMODS.Rank {
    key = "Troubadour",
    card_key = "T",
    lc_atlas = "troubadouratlas", hc_atlas = "troubadouratlashc",
    face_nominal = 0.05,
    pos = { x = 0 },
    nominal = 10,
    face = true,
    next = {"Jack"},
    loc_txt = {
        name = "Troubadour"
    },
    shorthand = "T",
    suit_map = {mucho_leaves = 0, Hearts = 1, Clubs = 2, Diamonds = 3, Spades = 4},
    in_pool = function(self, args)
        if args and args.initial_deck then
            return false
        end
    return troubadours_in_pool()
    end,
    update = function(self, card, dt)
        if CheckifRank(15) == true then
            SMODS.Rank:take_ownership("10", { next = {"mucho_Troubadour"} }, true)
        end
    end
}
-- TODO: activate the 10->T only if there actually are troubadours in the deck (kinda works? very wanky)


SMODS.Suit {
    key = "leaves",
    card_key = "L",
    lc_atlas = "suits",
    hc_atlas = "suitshc", 
    pos = { y = 0 },

    lc_colour = HEX("828230"),
    hc_colour = HEX("26A047"),

    ui_pos = { x = 0, y = 0 },

    loc_txt = {
        singular = "Leaf",
        plural = "Leaves"
    },
    in_pool = function(self, args)
        if args and args.initial_deck then
            return false
        end
    return leaves_in_pool()
    end
    
}

