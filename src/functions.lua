-- get name of joker
function getJokerName(card)
    local _cardname = card.config.center.name
    if string.find(_cardname,"j_") then _cardname = card.config.center.loc_txt.name end
    return _cardname
end

function everythingRedSteelKing()
	for _, card in ipairs(G.playing_cards) do
		card.base.value = "King"
		card.base.face_nominal = 0.4
		card.base.suit_nominal_original = 0.04
		card.nominal = 10
		card:set_seal('Red')
		card.config.card.value = "King"
		card:set_ability("m_steel")
	end
end

G.PingProbabilityUsed = 0

SMODS.Sound{
    key = "sbruh",
    path = "bruh.ogg"
}

G.FreudActivations = 0

if next(SMODS.find_mod("Talisman")) then
	SMODS.Keybind{
		key = 'losemoney',
		key_pressed = 'o',
		held_keys = {'lctrl'}, -- other key(s) that need to be held

		action = function(self)
			local freud = next(SMODS.find_card("j_mucho_senorfreud"))
			if freud then
				if lenient_bignum(G.GAME.dollars) > lenient_bignum(20) then
					G.GAME.dollars = lenient_bignum(G.GAME.dollars / 2)
				else
					G.GAME.dollars = lenient_bignum(G.GAME.dollars - 10)
				end
				sendInfoMessage("Freud activated, current freud counter: "..G.FreudActivations, "Balatrez+")
				play_sound('mucho_sbruh', math.random(1500,4000)/2000, 1)
				G.FreudActivations = lenient_bignum(G.FreudActivations + 1)
				if pseudorandom("lose card selection?") < G.GAME.probabilities.normal / 25 then
					SMODS.change_play_limit(-1 or -1)
					SMODS.change_discard_limit(-1 or -1)
					G.E_MANAGER:add_event(Event({
						func = function()
							change_shop_size(-1)
							play_sound("mucho_soulhurt", 0.3, 2)
							play_sound("mucho_soulhurt", 0.6, 2)
							play_sound("mucho_soulhurt", 0.9, 2)
							play_sound("mucho_soulhurt", 1.2, 2)
							play_sound("mucho_soulhurt", 1.5, 2)
							play_sound("mucho_snd_explosion", 0.6, 2)
							play_sound("mucho_snd_explosion", 0.3, 2)
							play_sound("mucho_snd_explosion", 0.9, 2)
							play_sound("mucho_glassbreak", 0.6, 2)
							play_sound("mucho_glassbreak", 0.3, 2)
							play_sound("mucho_glassbreak", 0.9, 2)
							return true
						end
					}))
				end
			end
		end,
	}
else
	SMODS.Keybind{
		key = 'losemoney',
		key_pressed = 'o',
		held_keys = {'lctrl'}, -- other key(s) that need to be held

		action = function(self)
			local freud = next(SMODS.find_card("j_mucho_senorfreud"))
			if freud then
				if G.GAME.dollars > 20 then
					G.GAME.dollars = G.GAME.dollars / 2
				else
					G.GAME.dollars = G.GAME.dollars - 10
				end
				sendInfoMessage("Freud activated, current freud counter: "..G.FreudActivations, "Balatrez+")
				play_sound('mucho_sbruh', math.random(1500,4000)/2000, 1)
				G.FreudActivations = G.FreudActivations + 1
				if pseudorandom("lose card selection?") < G.GAME.probabilities.normal / 25 then
					SMODS.change_play_limit(-1 or -1)
					SMODS.change_discard_limit(-1 or -1)
					G.E_MANAGER:add_event(Event({
						func = function()
							change_shop_size(-1)
							play_sound("mucho_soulhurt", 0.3, 1)
							return true
						end
					}))
				end
			end
		end,
	}
end

G.SigmundActivated = false
G.TextSigmund = {
            	'Press the following combination to',
            	'activate the joker:',
            	'{V:1}LEFT CTRL{} + {V:2}RIGHT SHIFT{} + {V:3}CAPS LOCK{} + {V:4}SPACE{} + {V:5}D{} + {V:6}8{} + {V:7}A{}',
            	'{V:8}(Currently inactive)'
        }


SMODS.Keybind{
	key = 'activatejoker',
	key_pressed = 'a',
    held_keys = {'lctrl', 'rshift', 'capslock', 'space', 'd', '8'}, -- other key(s) that need to be held

    action = function(self)
        sendInfoMessage("Combination Sigmund pressed", "Balatrez+")
		play_sound('mucho_sbruh', math.random(1500,4000)/2000, 1)
		if G.SigmundActivated == false then
			G.SigmundActivated = true
			G.TextSigmund = {
				'{V:9}+#2#{} Mult per {V:10}Señor Freud{} activation',
				'{V:8}(Currently: {V:9}+#3#{}{V:8} Mult){}',
            	'Press the following combination to',
            	'disable the joker:',
            	'{V:1}LEFT CTRL{} + {V:2}RIGHT SHIFT{} + {V:3}CAPS LOCK{} + {V:4}SPACE{} + {V:5}D{} + {V:6}8{} + {V:7}A{}',
            	'{V:8}(Currently active)'
        }
		else
			G.SigmundActivated = false
			G.TextSigmund = {
            	'Press the following combination to',
            	'activate the joker:',
            	'{V:1}LEFT CTRL{} + {V:2}RIGHT SHIFT{} + {V:3}CAPS LOCK{} + {V:4}SPACE{} + {V:5}D{} + {V:6}8{} + {V:7}A{}',
            	'{V:8}(Currently inactive)'
        }
		end
    end,
}

-- code taken from Bunco, thanks!
function disable_extras()
    if G.GAME then G.GAME.ExtraMucho = false end
end

disable_extras()

function enable_extras()
    if G.GAME then G.GAME.ExtraMucho = true end
end

leaves_in_pool = function()
    if G.GAME and G.GAME.ExtraMucho then return true end
    local spectrum_played = false
    return spectrum_played
end

troubadours_in_pool = function()
    if G.GAME and G.GAME.ExtraMucho then return true end
    local spectrum_played = false
    return spectrum_played
end