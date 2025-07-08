SMODS.Shader({ key = 'balatritic', path = 'balatritic.fs' })

SMODS.Edition{
    key = "ebalatritic",
    shader = "balatritic",
    loc_txt = {
        name = "Balatritic",
        label = "Balatritic",
        text = {
            '{X:mult,C:white}X#1#{} Mult per {V:2}consumable{}',
            'when this card is {V:2}scored{}',
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                self.config.mult_per,
                colours = {
                    G.C.UI.TEXT_INACTIVE,
                    G.C.FILTER,
                }
            }
        } end,
    config = { mult_per = 0.75 },
    sound = {
		sound = "mucho_salebalatritosound",
		per = 1,
		vol = 0.5,
	},
    weight = 1.5,
    in_shop = true,
    extra_cost = 15,
    apply_to_float = true,
    discovered = true,
    unlocked = true,
    get_weight = function(self)
	    return G.GAME.edition_rate * self.weight
    end,

    calculate = function(self, card, context)
		if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
			return { x_mult = (self.config.mult_per * #G.consumeables.cards) + 1 } -- updated value
		end
	end,
}

local miscitems = {
    ebalatritic_shader,
    ebalatritic,
    }

return {
    name = "Misc.",
    items = miscitems,
}