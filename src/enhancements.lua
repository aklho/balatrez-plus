SMODS.Atlas {
    key = "enhancementatlas",
    path = "enhancementatlas.png",
    px = 71,
    py = 95
}

SMODS.Enhancement {
    key = "smwgenhancement",
    loc_txt = {
        name = "Smart Man With Glasses Download Wallpaper Enhancement",
        text = {"{C:money}$#1#{} per Joker owned when scored"}
    },
    atlas = "enhancementatlas", pos = {x = 0, y = 0},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.dolar } }
    end,
    config = {dolar = 1},

    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                dollars = card.ability.dolar * #G.jokers.cards
            }
        end
    end
    }