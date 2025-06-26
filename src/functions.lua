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

SMODS.Sound{
    key = "sbruh",
    path = "bruh.ogg"
}

G.FreudActivations = 0

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
		end
    end,
}

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