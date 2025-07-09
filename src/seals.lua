SMODS.Atlas {
    key = "seals",
    path = "sealsatlas.png",
    px = 71,
    py = 95
}

SMODS.Seal {
    name = "Smart Man With Glasses Download Wallpaper Seal",
    key = "smwg_seal",
    badge_colour = HEX("e6b26e"),
	config = { dolar = 1  },
    loc_txt = {
        -- Badge name (displayed on card description when seal is applied)
        label = 'Smart Man With Glasses Download Wallpaper Seal',
        -- Tooltip description
        name = {'Smart Man With Glasses','Download Wallpaper Seal',},
        text = {
            '{C:money}$#1#{} per Joker owned',
        }
    },


    sound = { sound = 'mucho_hugebell', per = 1.6, vol = 0.4 },

    loc_vars = function(self, info_queue)
        return { vars = {self.config.dolar } }
    end,
    atlas = "seals",
    pos = {x=0, y=0},

    -- self - this seal prototype
    -- card - card this seal is applied to
    calculate = function(self, card, context)
        -- main_scoring context is used whenever the card is scored
        
        if context.main_scoring and context.cardarea == G.play then
            return {
                G.E_MANAGER:add_event(Event({func = function()
                play_sound('mucho_hugebell')
                
                return true end })),

                message = "Smart Man With Glasses Download Wallpaper",
                dollars = self.config.dolar * #G.jokers.cards
            }
        end
    end,
}