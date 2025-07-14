SMODS.Atlas {
    key = "atlas_con",
    path = "consumables.png",
    px = 71,
    py = 95
}

SMODS.Sound{
    key = "smustard",
    path = "s_mustard.ogg"
}

SMODS.Sound{
    key = "semployment",
    path = "s_employment.ogg"
}

SMODS.Sound{
    key = "skashpaint",
    path = "s_kashpaint.ogg"
}

MostazaCounter = 1

SMODS.Consumable{
    key = 'employment',
    set = "Tarot",
    loc_txt = {
        name = "Employment",
        text = {
            "Gain {V:3}3${} per Joker owned",
            "{V:1}(Currently: {V:3}a certain amount of money (do the math yourself){}{V:1}){}"
        }
    },
    loc_vars = function(self, info_queue, card)
        card.ability.extra.totalmoney = card.ability.extra.moneygained * #G.jokers.cards
        return {
            
            vars = {
                card.ability.extra.moneygained,
                card.ability.extra.totalmoney,
                colours = {
                    G.C.UI.TEXT_INACTIVE,
                    G.C.FILTER,
                    G.C.MONEY
                }
            }
        } end,
    atlas = 'atlas_con', pos = {x = 1, y = 0},
    cost = 3,
    unlocked = true,
    discovered = false,
    config = { extra = { moneygained = 3, totalmoney = 0 }},
    can_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
        play_sound('mucho_semployment', math.random(1500,2100)/2000, 1)
        ease_dollars(card.ability.extra.totalmoney, true)
    end

}

MostazaPCounter = 2

SMODS.Consumable{
    key = 'mostaza',
    set = "Tarot",
    loc_vars = function(self, info_queue, card)
        return {
            key = next(SMODS.find_card("j_mucho_translator")) and "c_mucho_mostazatranslated" or "c_mucho_mostaza",
            vars = {
                MostazaCounter,
                colours = {
                    G.C.UI.TEXT_INACTIVE,
                    G.C.FILTER,
                    G.C.MONEY,
                    G.C.SECONDARY_SET.Tarot

                }
            }
        } end,
    atlas = 'atlas_con', pos = {x = 0, y = 0},
    cost = 0,
    unlocked = true,
    discovered = false,
    config = { extra = {}},
    can_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
        play_sound('mucho_smustard', math.random(1500,4000)/2000, 1)
        ease_dollars(MostazaCounter, true)
        if math.random(1,3) == 2 then
            MostazaCounter = 1
        else
            MostazaCounter = MostazaCounter + 2
        end
    end

}





SMODS.Consumable{
    key = 'balatrobalatrez',
    set = "Tarot",
    loc_txt = {
        name = "Balatro Balatrez",
        text = {
            "Creates a random {C:green}Uncommon {}Balatrez+ {C:attention}Joker",
            "{C:inactive}(Must have room){}"
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
        } end,
    atlas = 'atlas_con', pos = {x = 0, y = 1},
    cost = 3,
    unlocked = true,
    discovered = true,
    config = { extra = { }},
    can_use = function(self, card)
        return #G.jokers.cards < G.jokers.config.card_limit or card.area == G.jokers
    end,

    use = function(self, card, area, copier)
        local value = 2
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                local card = create_card("BalatrezAddition", G.jokers, nil, value, nil, nil, nil, "mucho_balatrobalatrez")
				card:add_to_deck()
                G.jokers:emplace(card)
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,

}


SMODS.Consumable{
    key = 'spear',
    set = "Tarot",
    loc_txt = {
        name = "Spear of Justice",
        text = {
            "Has a {C:green,E:1}1 in 2 chance{} {C:inactive}(fixed){} to create",
            "a {C:tarot}Justice{} card (or any other {C:tarot}Tarot{} card)",
            "{C:inactive}(Doesn't need room)"
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
        } end,
    atlas = 'atlas_con', pos = {x = 2, y = 1},
    cost = 3,
    unlocked = true,
    discovered = true,
    config = { extra = { }},
    can_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                if pseudorandom("spear!ofjustice") < 1 / 2 and G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('mucho_snd_spear')
                    SMODS.add_card({ set = 'Tarot', area = G.consumeables, key = 'c_justice' })
                    card:juice_up(0.3, 0.5)
                end
                return true
            end
        }))
        delay(0.6)
    end,

}

SMODS.Consumable{
    key = 'thecure',
    set = "Tarot",
    loc_vars = function(self, info_queue, card)
        return {
            key = "c_mucho_thecure",
        } end,
    atlas = 'atlas_con', pos = {x = 3, y = 1},
    cost = -999,
    sell_cost = 0,
    unlocked = true,
    discovered = true,
    config = { extra = { }},
    can_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
        G.GAME.dollar_buffer = 0
        G.GAME.dollars = 0
    end,

}

SMODS.Consumable {
    key = 'smwgtc',
    set = 'Tarot',
    atlas = "atlas_con",
    pos = { x = 3, y = 2 },
    config = { max_highlighted = 2, mod_conv = 'm_mucho_smwgenhancement' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { key = "c_mucho_smwgtc", vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
}

SMODS.Consumable{
    key = 'mostazapremium',
    set = "Spectral",
    loc_vars = function(self, info_queue, card)
        return {
            key = next(SMODS.find_card("j_mucho_translator")) and "c_mucho_mostazapremiumtranslated" or "c_mucho_mostazapremium",
            vars = {
                MostazaPCounter,
                colours = {
                    G.C.UI.TEXT_INACTIVE,
                    G.C.FILTER,
                    G.C.MONEY,
                    G.C.DARK_EDITION,
                    G.C.SECONDARY_SET.Spectral

                }
            }
        } end,
    atlas = 'atlas_con', pos = {x = 3, y = 0}, soul_pos = {x = 4, y = 0},
    cost = 0,
    unlocked = true,
    discovered = false,
    config = { extra = {mustardchoral = 1}},
    can_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
        card.ability.extra.mustardchoral = math.random(1000,1250)/2000
        play_sound('mucho_smustard', card.ability.extra.mustardchoral*1.5, 1)
        play_sound('mucho_smustard', card.ability.extra.mustardchoral*2, 1)
        play_sound('mucho_smustard', card.ability.extra.mustardchoral*2.5, 1)
        play_sound('mucho_smustard', card.ability.extra.mustardchoral*3, 1)
        ease_dollars(MostazaPCounter, true)
        MostazaPCounter = MostazaPCounter + 2
    end

}

SMODS.Consumable{
    key = 'familiabalatrez',
    set = "Spectral",
    loc_txt = {
        name = "Familia Balatrez",
        text = {
            "Creates a random {C:red}Rare {}or",
            "higher Balatrez+ {C:attention}Joker",
            "{C:inactive}(Must have room){}"
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
        } end,
    atlas = 'atlas_con', pos = {x = 1, y = 1},
    cost = 6,
    unlocked = true,
    discovered = true,
    config = { extra = { }},
    can_use = function(self, card)
        return #G.jokers.cards < G.jokers.config.card_limit or card.area == G.jokers
    end,

    use = function(self, card, area, copier)
        local raritych = pseudorandom("raritycheck", 1, 20)
        local value = nil
        if raritych < 13 then
            value = 3
        elseif raritych > 12 and raritych < 19 then
            value = "mucho_rarerthanrare"
        elseif raritych >= 19 then
            value = "mucho_exceptional"
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                local card = create_card("BalatrezAddition", G.jokers, nil, value, nil, nil, nil, "mucho_balatrobalatrez")
				card:add_to_deck()
                G.jokers:emplace(card)
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,

}


SMODS.Consumable {
    key = "antoine",
    set = "Spectral",
    loc_txt = {
        name = "Antoine",
        text = {
            "Add {V:1}Balatritic{} effect to",
            "{V:2}#1#{} selected card in hand"
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_mucho_balatritic
        return {
            vars = {
                card.ability.max_highlighted,
                colours = {
                    G.C.DARK_EDITION,
                    G.C.FILTER,
                }
            }
        }
    end,
    atlas = 'atlas_con',
    pos = {x = 2, y = 0},
    cost = 10,
    unlocked = true,
    discovered = false,
    config = { max_highlighted = 1 },
    use = function(self, card, area, copier)
        for i = 1, math.min(#G.hand.highlighted, card.ability.max_highlighted) do
            G.E_MANAGER:add_event(Event({func = function()
                play_sound('mucho_skashpaint', math.random(1500,2500)/2000, 1)
                card:juice_up(0.3, 0.5)
                return true end }))
            
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                G.hand.highlighted[1]:set_edition("e_mucho_ebalatritic")
                return true end }))
            
            delay(0.5)
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end
}

SMODS.Consumable {
    key = 'smwgsc',
    set = 'Spectral',
    atlas = "atlas_con",
    pos = { x = 4, y = 2 },
    config = { extra = { seal = 'mucho_smwgseal' }, max_highlighted = 2 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return { key = "c_mucho_smwgsc", vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        for i = 1, #G.hand.highlighted do
            local conv_card = G.hand.highlighted[i]
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    conv_card:set_seal(card.ability.extra.seal, nil, true)
                    return true
                end
            }))

            delay(0.5)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
        end
    end,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}


SMODS.Consumable {
    key = "pipis",
    set = "Spectral",
    loc_vars = function(self, info_queue, card)
        return {
            key = "c_mucho_pipis",
            vars = {
                G.GAME.probabilities.normal,
                card.ability.odds1,
                card.ability.odds2,
                card.ability.odds3,
                colours = {
                    HEX("a83283")
                }
            }
        }
    end,
    atlas = 'atlas_con',
    pos = {x = 4, y = 1},
    cost = 10,
    unlocked = true,
    discovered = true,
    config = { odds1 = 16, odds2 = 48, odds3 = 144, extraselect = 1 },
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        local randomtrigger = pseudorandom("pipischoice!", 1, 5)
        if randomtrigger == 1 then
            if G.consumeables.cards[1] then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local card_to_copy, _ = pseudorandom_element(G.consumeables.cards, 'mucho_pipisduplicate')
                        local copied_card = copy_card(card_to_copy)
                        copied_card:add_to_deck()
                        G.consumeables:emplace(copied_card)
                        return true
                    end
                }))
            else
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        attention_text({
                            text = "No cards to copy!",
                            scale = 1.3,
                            hold = 2,
                            major = card,
                            backdrop_colour = G.C.SECONDARY_SET.Tarot,
                            align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                                'tm' or 'cm',
                            offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                            silent = true
                        })
                        play_sound('mucho_soulhurt', 1, 0.4)
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
            end
        elseif randomtrigger == 2 then
            local randommoney = pseudorandom("pipischoice! (money)", 1, 10)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('timpani')
                    card:juice_up(0.3, 0.5)
                    ease_dollars(randommoney, true)
                    return true
                end
            }))
        delay(0.6)
        elseif randomtrigger == 3 then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    attention_text({
                        text = "Rolling for [[Three]]...",
                        scale = 1.3,
                        hold = 2,
                        major = card,
                        backdrop_colour = G.C.SECONDARY_SET.Tarot,
                        align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                            'tm' or 'cm',
                        offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                        silent = true
                    })
                    play_sound('explosion_buildup1', 1, 0.4)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            delay(1.8)
            if pseudorandom("pipischoice! (RtR tag)") < G.GAME.probabilities.normal / card.ability.odds1 then
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        add_tag(Tag('tag_mucho_rarerthanraretag'))
                        play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                        return true
                    end)
                }))
            else
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        attention_text({
                            text = localize('k_nope_ex'),
                            scale = 1.3,
                            hold = 1.4,
                            major = card,
                            backdrop_colour = G.C.SECONDARY_SET.Tarot,
                            align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                                'tm' or 'cm',
                            offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                            silent = true
                        })
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.06 * G.SETTINGS.GAMESPEED,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound('tarot2', 0.76, 0.4)
                                return true
                            end
                        }))
                        play_sound('tarot2', 1, 0.4)
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
            end
        elseif randomtrigger == 4 then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    attention_text({
                        text = "Rolling for [[Four]]...",
                        scale = 1.3,
                        hold = 2,
                        major = card,
                        backdrop_colour = G.C.SECONDARY_SET.Tarot,
                        align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                            'tm' or 'cm',
                        offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                        silent = true
                    })
                    play_sound('explosion_buildup1', 1, 0.4)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            delay(1.8)
            if pseudorandom("pipischoice! (card select. limit)") < G.GAME.probabilities.normal / card.ability.odds2 then
                SMODS.change_play_limit(card.ability.extraselect or self.config.extraselect)
                SMODS.change_discard_limit(card.ability.extraselect or self.config.extraselect)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        attention_text({
                            text = "Success!",
                            scale = 1.3,
                            hold = 2,
                            major = card,
                            backdrop_colour = G.C.SECONDARY_SET.Tarot,
                            align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                                'tm' or 'cm',
                            offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                            silent = true
                        })
                        play_sound('explosion_buildup1', 1, 0.4)
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
            else
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        attention_text({
                            text = localize('k_nope_ex'),
                            scale = 1.3,
                            hold = 1.4,
                            major = card,
                            backdrop_colour = G.C.SECONDARY_SET.Tarot,
                            align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                                'tm' or 'cm',
                            offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                            silent = true
                        })
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.06 * G.SETTINGS.GAMESPEED,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound('tarot2', 0.76, 0.4)
                                return true
                            end
                        }))
                        play_sound('tarot2', 1, 0.4)
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
            end
        elseif randomtrigger == 5 then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    attention_text({
                        text = "Rolling for [[Five]]...",
                        scale = 1.3,
                        hold = 2,
                        major = card,
                        backdrop_colour = G.C.SECONDARY_SET.Tarot,
                        align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                            'tm' or 'cm',
                        offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                        silent = true
                    })
                    play_sound('explosion_buildup1', 1, 0.4)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            delay(1.8)
            if pseudorandom("pipischoice! (balatrez max)") < G.GAME.probabilities.normal / card.ability.odds3 then
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    SMODS.add_card({ set = 'Spectral', key = "c_mucho_balatrezmax" })
                    card:juice_up(0.3, 0.5)
                else
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            attention_text({
                                text = "No room!",
                                scale = 1.3,
                                hold = 1.4,
                                major = card,
                                backdrop_colour = G.C.SECONDARY_SET.Tarot,
                                align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                                    'tm' or 'cm',
                                offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                                silent = true
                            })
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.06 * G.SETTINGS.GAMESPEED,
                                blockable = false,
                                blocking = false,
                                func = function()
                                    play_sound('tarot2', 0.76, 0.4)
                                    return true
                                end
                            }))
                            play_sound('tarot2', 1, 0.4)
                            card:juice_up(0.3, 0.5)
                            return true
                        end
                    }))
                end
            else
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        attention_text({
                            text = localize('k_nope_ex'),
                            scale = 1.3,
                            hold = 1.4,
                            major = card,
                            backdrop_colour = G.C.SECONDARY_SET.Tarot,
                            align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                                'tm' or 'cm',
                            offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                            silent = true
                        })
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.06 * G.SETTINGS.GAMESPEED,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound('tarot2', 0.76, 0.4)
                                return true
                            end
                        }))
                        play_sound('tarot2', 1, 0.4)
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
            end
        else
        end
    end
}

SMODS.Consumable {
    key = "balatrezmax",
    set = "Spectral",
    loc_txt = {
        name = "Balatrez {V:1,s:1.2}MAX",
        text = {
            "Creates a random {V:1}Exceptional{} {C:attention]Joker,",
            "{C:red,E:2}destroy{} two other random Jokers"
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_mucho_balatritic
        return {
            vars = {
                card.ability.max_highlighted,
                colours = {
                    G.C.DARK_EDITION,
                    G.C.FILTER,
                }
            }
        }
    end,
    atlas = 'atlas_con',
    pos = {x = 1, y = 2}, soul_pos = {x = 2, y = 2},
    cost = 10,
    unlocked = true,
    discovered = false,
    hidden = true,
    config = { },
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        local deletable_jokers = {}
		for k, v in pairs(G.jokers.cards) do
			if not v.ability.eternal and #deletable_jokers < 2 then
				deletable_jokers[#deletable_jokers + 1] = v
			end
		end
        local _first_dissolve = nil
        G.E_MANAGER:add_event(Event({
			trigger = "before",
			delay = 0.75,
			func = function()
				for k, v in pairs(deletable_jokers) do
					v:start_dissolve(nil, _first_dissolve)
					_first_dissolve = true
				end
				return true
			end,
		}))

        G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				local card = create_card("Joker", G.jokers, nil, "mucho_exceptional", nil, nil, nil, "mucho_balatrezmax")
				card:add_to_deck()
				G.jokers:emplace(card)
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))
		delay(0.6)
    end
}


-- Planets


SMODS.Consumable {
    key = "eightplanets",
    set = "Planet",
    cost = 3,
    atlas = 'atlas_con',
    pos = { x = 0, y = 2 },
    config = { hand_type = 'mucho_eightfold' },
    loc_vars = function(self, info_queue, card)
        return {
            key = "c_mucho_eightplanets",
            vars = {
                G.GAME.hands['mucho_eightfold'].level,
                "Eightfold",
                G.GAME.hands['mucho_eightfold'].l_mult,
                G.GAME.hands['mucho_eightfold'].l_chips,
                colours = { (G.GAME.hands['mucho_eightfold'].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands['mucho_eightfold'].level)]) }
            }
        }
    end
}