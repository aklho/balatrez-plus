SMODS.Atlas{
    key = "vouchers",
    path = "vouchers.png",
    px = 71,
    py = 95 
}

SMODS.Voucher {
    key = "Equilibrium",
    loc_txt = {
        name = "Equilibrium",
        text = {"{C:attention}-1 {C:purple}card selection limit{} for {C:red}discards",
               "{C:attention}+1 {C:purple}card selection limit{} for {C:blue}hands"}
    },
    config = { extra = {extraselect = 1}},
    cost = 12,
    unlocked = true,
    discovered = true,
    atlas = "vouchers", pos = {x = 0, y = 0},
    redeem = function(self, card)
        SMODS.change_play_limit(card.ability.extra.extraselect or self.config.extra.extraselect)
        SMODS.change_discard_limit(-card.ability.extra.extraselect or -self.config.extra.extraselect)
    end
}

SMODS.Voucher {
    key = "Equilibrium_neo",
    loc_txt = {
        name = "Equilibrium NEO",
        text = {"{C:attention}-1 {C:purple}card selection limit{} for {C:red}discards",
               "{C:attention}+1 {C:purple}card selection limit{} for {C:blue}hands"}
    },
    config = { extra = {extraselect = 1}},
    cost = 16,
    unlocked = true,
    discovered = true,
    atlas = "vouchers", pos = {x = 1, y = 0},
    requires = {'v_mucho_equilibrium'},
    redeem = function(self, card)
        SMODS.change_play_limit(card.ability.extra.extraselect or self.config.extra.extraselect)
        SMODS.change_discard_limit(-card.ability.extra.extraselect or -self.config.extra.extraselect)
    end
}

SMODS.Voucher {
    key = "Equilibrium_max",
    loc_txt = {
        name = "Equilibrium MAX",
        text = {"{C:attention}-2 {C:purple}card selection limit{} for {C:red}discards",
               "{C:attention}+1 {C:purple}card selection limit{} for {C:blue}hands"}
    },
    config = { extra = {extraselect = 1, extralost = 2}},
    cost = 20,
    unlocked = true,
    discovered = true,
    atlas = "vouchers", pos = {x = 2, y = 0},
    requires = {'v_mucho_equilibrium','v_mucho_equilibrium_neo'},
    redeem = function(self, card)
        SMODS.change_play_limit(card.ability.extra.extraselect or self.config.extra.extraselect)
        SMODS.change_discard_limit(-card.ability.extra.extralost or -self.config.extra.extralost)
    end
}