SMODS.Atlas {
    key = "sealatlas",
    path = "sealatlas.png",
    px = 710,
    py = 960
}

SMODS.Seal {
    name = "horse_seal",
    key = "horse_seal",
    badge_colour = HEX("795223"),
	config = { x_mult = 1.5  },
    loc_txt = {
        -- Badge name (displayed on card description when seal is applied)
        label = 'Mult ',
        -- Tooltip description
        name = 'Horse Seal',
        text = {
            '{C:mult}#1#{} Mult',
            '{C:chips}#2#{} Chips',
            '{C:money}$#3#{}',
            '{X:mult,C:white}X#4#{} Mult',
        }
    },


    sound = { sound = 'yahimod_horse', per = 1.6, vol = 0.4 },

    loc_vars = function(self, info_queue)
        return { vars = {self.config.mult, self.config.chips, self.config.money, self.config.x_mult, } }
    end,
    atlas = "horse_seal",
    pos = {x=0, y=0},

    -- self - this seal prototype
    -- card - card this seal is applied to
    calculate = function(self, card, context)
        -- main_scoring context is used whenever the card is scored
        
        if context.main_scoring and context.cardarea == G.play then
            return {
                G.E_MANAGER:add_event(Event({func = function()
                play_sound('yahimod_horse')
                
                return true end })),

                message = "Neigh.",
                mult = self.config.mult,
                chips = self.config.chips,
                dollars = self.config.money,
                x_mult = self.config.x_mult
            }
        end
    end,
}