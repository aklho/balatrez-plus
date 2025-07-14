SMODS.Atlas {
    key = "atlas",
    path = "atlas.png",
    px = 355,
    py = 475
}

SMODS.Font {
    key = "utfont",
    path = "PixelOperator-Bold.ttf",
    FONTSCALE = 0.1
}

SMODS.Font {
    key = "classfont",
    path = "ChopinScript.otf",
    FONTSCALE = 0.1
}

SMODS.Font {
    key = "impact",
    path = "impact.ttf",
    FONTSCALE = 0.1
}


SMODS.Atlas {
    key = "atlas2",
    path = "atlas2.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "atlas3",
    path = "atlas3.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "atlas4",
    path = "atlas4.png",
    px = 142,
    py = 190
}


SMODS.Atlas {
    key = "chicotatlas",
    path = "chicot.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "canioatlas",
    path = "canio.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "coreatlas",
    path = "coreatlas.png",
    px = 230,
    py = 305
}

SMODS.Rarity{
    key = 'rarerthanrare',
    loc_txt = { name = "Rarer than Rare" },
    badge_colour = HEX("a83283"),
    default_weight = 0.01
}

SMODS.Rarity{
    key = 'exceptional',
    loc_txt = { name = "Exceptional" },
    badge_colour = HEX("c7f0e1"),
    text_colour = HEX("1f1f1f"),
    default_weight = 0.002
}

SMODS.Rarity{
    key = 'unobtainable',
    loc_txt = { name = "Unobtainable" },
    badge_colour = HEX("A3A3A3"),
    default_weight = 0
}


SMODS.ObjectType{
    key = "BalatrezAddition",
    default = "j_jolly",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		-- insert base game food jokers
	end,
    rarities = {
        {key = 'Common', rate = 0.3},
        {key = 'Uncommon', rate = 0.75},
        {key = 'Rare', rate = 0.95},
        {key = 'mucho_rarerthanrare', rate = 0.99},
        {key = 'mucho_exceptional', rate = 0.998},
        {key = 'mucho_unobtainable', rate = 1},
    },
}

-- little silly (taking ownership of Freakylatro's "Diddylord" to mess with it)
-- ! CROSS COMPATIBILITY WITH FREAKYLATRO (by Lamar Tiberi or NGNOX), only activates if both mods are activated at once

if BalatrezModConfig.bltrz_x_freaky then
    if next(SMODS.find_mod('freakylatro')) then

        SMODS.Atlas {
            key = "freakylatrocompatibility",
            path = "balatrezfreakylatrocrosscontent_diddylord.png",
            px = 355,
            py = 475
        }

        SMODS.Sound({key = "blud", path = "blud.ogg",})



        SMODS.Joker:take_ownership("freaky_diddylord", {
            config = { card_limit = 2 },
            atlas = "freakylatrocompatibility",
            pos = {x = 0, y = 0},
            pools = {["Freak"] = false},
            add_to_deck = function(self, card, from_debuff)
                self.loc_vars = function(self, info_queue, card)
                    return {key = "j_mucho_diddylordovertaken", vars = { number_format(card.ability.card_limit)}}
                end
                card.children.center:set_sprite_pos({x = 1, y = 0})
                play_sound('mucho_hugebell', 1, 2)
                play_sound('mucho_hugebell', 1.5, 2)
                G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.card_limit
            end,

            remove_from_deck = function(self, card, from_debuff)
                play_sound('mucho_hugebell', 1, 2)
                play_sound('mucho_hugebell', 1.5, 2)
                G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.card_limit
            end,

            calculate = function(self, card, context)
                if
                context.using_consumeable or 
                context.skip_blind or  
                context.reroll_shop or 
                context.selling_card or 
                context.buying_card or 
                context.open_booster 
                then
                return { 
                    play_sound('mucho_semployment', math.random(1500,2100)/2000, 1),
                    play_sound('mucho_smustard', math.random(1500,4000)/2000, 1)
                }
            end
            end
        })

        SMODS.Joker {
            key = "truediddylord",
            config = { card_limit = 2 },
            pos = { x = 0, y = 0 },
            rarity = 2,
            cost = 8,
            atlas = "freakylatrocompatibility",
            pools = {["Freak"] = true},
            loc_vars = function(self, info_queue, center)
                return { key = "j_mucho_diddylord", vars = { number_format(center.ability.card_limit) } }
            end,
            add_to_deck = function(self, card, from_debuff)
                self.loc_vars = function(self, info_queue, card)
                    return {key = "j_mucho_diddylordrevealed", vars = { number_format(card.ability.card_limit)}}
                end
                G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.card_limit
            end,
            remove_from_deck = function(self, card, from_debuff)
                G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.card_limit
            end,
            calculate = function(self, card, context)
                if
                context.using_consumeable or 
                context.skip_blind or  
                context.reroll_shop or 
                context.selling_card or 
                context.buying_card or 
                context.open_booster 
                then
                return { 
                    play_sound("mucho_blud", math.random(1500,2500)/2000), 0.1}
                end
            end
        }

        SMODS.Joker{
            key = "tuffmaster",
            loc_txt = {
                name = "The Tuffmaster",
                text = {"The tuffmaster calls for its food",
                        "{C:red}Does something"}
            },
            atlas = "freakylatrocompatibility", pos = {x = 2, y = 0},
            rarity = "freaky_tuff",
            cost = 11,
            pools = {["Freak"] = true},
            add_to_deck = function(self, card, from_debuff)
                play_sound("mucho_blud", 1, 1)
            end,

            remove_from_deck = function(self, card, from_debuff)
                play_sound("mucho_blud", 1, 1)
            end,

            calculate = function(self, card, context)
                if context.pre_joker then
                    play_sound("mucho_blud", 1, 1)
                    if pseudorandom("blow up?") < G.GAME.probabilities.normal / 10 then
                        explodeCard(card)
                    elseif pseudorandom("^5 mult?") < G.GAME.probabilities.normal / 15 then
                        return {
                            mult_mod = mult ^ 4 - mult,
                            extra = { message = '^5 Mult', colour = G.C.DARK_EDITION }
                        }
                    elseif pseudorandom("create fake diddybluds") < G.GAME.probabilities.normal / 20 then
                        SMODS.add_card { set = "Joker", area = G.jokers, skip_materialize = true, key = "j_freaky_are_you_sure", no_edition = true}
                    elseif pseudorandom("create tuffmaster") < G.GAME.probabilities.normal / 10 then
                        SMODS.add_card { set = "Joker", area = G.jokers, skip_materialize = true, key = "j_mucho_tuffmaster", no_edition = true}
                    elseif pseudorandom("add 1 dolar") < G.GAME.probabilities.normal / 3 then
                        SMODS.add_card { set = "Joker", area = G.jokers, skip_materialize = true, key = "j_mucho_ps3", no_edition = true}
                    else
                        G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + 1
                        G.GAME.dollars = G.GAME.dollars + 1
                        card_eval_status_text(card,'jokers',nil,nil,nil,{message = "+1 bluddollar"})
                    end

                end
            end
        }

        SMODS.Joker {
            key = "tuffytuff",
            loc_txt = {
                name = "{f:mucho_classfont}tuffy tuff tuff",
                text = {"{f:mucho_classfont,s:4}coming straight",
                "{f:mucho_classfont,s:4}from your house{}",
                "{C:inactive}(Currently {X:dark_edition,C:white}^#1#{} {C:mult}Mult{C:inactive})"}
            },
            config = { extra = {mult = 1}},
            loc_vars = function(self, info_queue, card)
                return { vars = {card.ability.extra.mult}}
            end,
            atlas = "freakylatrocompatibility", pos = {x = 3, y = 0},
            rarity = 2,
            cost = 999,
            calculate = function(self, card, context)
                if context.reroll_shop then
                    card_eval_status_text(card,'jokers',nil,nil,nil,{message = "tuffy"})
                    card_eval_status_text(card,'jokers',nil,nil,nil,{message = "tuff"})
                    card_eval_status_text(card,'jokers',nil,nil,nil,{message = "tuff"})
                    card.ability.extra.mult = card.ability.extra.mult + 0.01
                end
                if context.joker_main then
                    return {
                        mult_mod = mult ^ (card.ability.extra.mult-1) - mult,
                        extra = { message = '^'..card.ability.extra.mult..' tuffy tuff', colour = G.C.DARK_EDITION }
                    }
                end
                if context.end_of_round and context.game_over == false and context.main_eval and G.GAME.blind.boss then
                    if pseudorandom("resettuffytufftuff?") < G.GAME.probabilities.normal / 6 then
                        card.ability.extra.mult = 1
                        card_eval_status_text(card,'jokers',nil,nil,nil,{message = "tuffy"})
                        card_eval_status_text(card,'jokers',nil,nil,nil,{message = "tuff"})
                        card_eval_status_text(card,'jokers',nil,nil,nil,{message = "tuff"})
                        card_eval_status_text(card,'jokers',nil,nil,nil,{message = "back to ^1 tuffy tuff"})
                        card_eval_status_text(card,'jokers',nil,nil,nil,{message = "tuffy tuff reset to 1"})
                    end
                end
            end
        }
    end
end


SMODS.Joker{
    key = "aterrador_joker",

    loc_vars = function(self, info_queue, card)
        return {
            key = next(SMODS.find_card("j_mucho_translator")) and "j_mucho_aterrador_jokertranslated" or "j_mucho_aterrador_joker",
        }
    end,

    atlas = 'atlas', pos = {x = 0, y = 0},
    rarity = 2,
    cost = 5,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
            context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + 1
            return {
                extra = { message = localize('k_upgrade_ex'), colour = G.C.MULT },
                card = card
            }
            
        end
    end
}

SMODS.Joker{
    key = "roulette",
    config = { extra = { normal_odds = 1, roulette_odds = 36, dollars = 36, evil_dollars = -1 }},
    loc_vars = function(self, info_queue, card)
        return {
            key = next(SMODS.find_card("j_mucho_translator")) and "j_mucho_roulettetranslated" or "j_mucho_roulette",
            vars = {
                G.GAME.probabilities.normal,
                card.ability.extra.roulette_odds,
                (card.ability.extra.roulette_odds - G.GAME.probabilities.normal),
                card.ability.extra.dollars,
                colours = {
                    G.C.GREEN,
                    G.C.MONEY,
                    G.C.RED,
                    G.C.DARK_EDITION
                }
            }
        
    } end,
    atlas = "atlas", pos = {x = 1, y = 0},
    rarity = 2,
    cost = 5,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,

    calculate = function(self, card, context)
        if context.pre_discard then
            if pseudorandom("first_odd") < G.GAME.probabilities.normal / card.ability.extra.roulette_odds then
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
                return {
                    dollars = card.ability.extra.dollars,
                }
            else
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) - card.ability.extra.dollars
                return {
                    dollars = card.ability.extra.evil_dollars,
                }
            end
        end
    end
}


SMODS.Joker {
	-- How the code refers to the joker.
	key = 'joker_ultrarrealista',
	-- loc_text is the actual name and description that show in-game for the card.
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { mult = 5 } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		return { key = next(SMODS.find_card("j_mucho_translator")) and "j_mucho_joker_ultrarrealistatranslated" or "j_mucho_joker_ultrarrealista", vars = { card.ability.extra.mult } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 1,
	-- Which atlas key to pull from.
	atlas = 'atlas',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 2, y = 0 },
	-- Cost of card in shop.
	cost = 4,
    pools = {["BalatrezAddition"] = true},
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)
		-- Tests if context.joker_main == true.
		-- joker_main is a SMODS specific thing, and is where the effects of jokers that just give +stuff in the joker area area triggered, like Joker giving +Mult, Cavendish giving XMult, and Bull giving +Chips.
		if context.joker_main then
			-- Tells the joker what to do. In this case, it pulls the value of mult from the config, and tells the joker to use that variable as the "mult_mod".
			return {
				mult_mod = card.ability.extra.mult,
				-- This is a localize function. Localize looks through the localization files, and translates it. It ensures your mod is able to be translated. I've left it out in most cases for clarity reasons, but this one is required, because it has a variable.
				-- This specifically looks in the localization table for the 'variable' category, specifically under 'v_dictionary' in 'localization/en-us.lua', and searches that table for 'a_mult', which is short for add mult.
				-- In the localization file, a_mult = "+#1#". Like with loc_vars, the vars in this message variable replace the #1#.
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
				-- Without this, the mult will stil be added, but it'll just show as a blank red square that doesn't have any text.
			}
		end
	end
}

SMODS.Joker{
    key = "tragaperras",
    loc_vars = function(self, info_queue, card)
        return {
            key = next(SMODS.find_card("j_mucho_translator")) and "j_mucho_tragaperrastranslated" or "j_mucho_tragaperras",
            vars = {
                card.ability.extra.minimumpossible,
                card.ability.extra.maximumpossible,
                colours = {
                    G.C.MONEY,
                    G.C.DARK_EDITION
                }
            }
        } end,
    config = { extra = { minimumpossible = 0, maximumpossible = 20 }},
    atlas = 'atlas', pos = {x = 1, y = 1},
    rarity = 2,
    cost = 10,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    calc_dollar_bonus = function(self, card)
        return pseudorandom("tragaperras", card.ability.extra.minimumpossible, card.ability.extra.maximumpossible)
    end,
}

SMODS.Joker{
    key = "lamar_tiberi",
    loc_vars = function(self, info_queue, card)
        return {
            key = next(SMODS.find_card("j_mucho_translator")) and "j_mucho_lamar_tiberitranslated" or "j_mucho_lamar_tiberi",
            vars = {
                card.ability.extra.minimumpossible,
                card.ability.extra.maximumpossible,
                colours = {
                    G.C.CHIPS,
                    G.C.DARK_EDITION
                }
            }
        } end,
    config = { extra = { minimumpossible = 0, maximumpossible = 500, currentchips = 0, currentquip = 0, quips = { 'Me encantan tanto los mangos que me metería uno en la nariz.', 'SKY FACTORY 4 PUEDE FOLLARME EL CULO HASTA QUE ME CORRA', 'hé faut arrêter la cigarette hein', 'Mi cara cuando Balatro me da color en la ronda 1 ante 1 pero lo juego y veo 74x4', 'Skibidi Toilet es la mejor película que he visto jamás.', 'La Declaración unánime de los trece Estados unidos de América, Cuando en el curso de los acontecimientos humanos, se hace necesario que un pueblo disuelva las bandas políticas que los han conectado con otro, y que asuma entre los poderes de la tierra, la posición separada e igualitaria a la que las Leyes de la Naturaleza y del Dios de la Naturaleza les dan derecho, un respeto decente a las opiniones de la humanidad requiere que declaren las causas que los impulsan a la separación. Sostenemos que estas verdades son evidentes, que todos los hombres son creados iguales, que están dotados por su Creador de ciertos derechos inalienables, que entre ellos se encuentran la Vida, la Libertad y la búsqueda de la Felicidad.---Que para asegurar estos derechos, los gobiernos sean instituidos entre los hombres, derivando sus poderes justos del consentimiento de los gobernados, -Que siempre que cualquier forma de gobierno se vuelva destructiva de estos fines, es el derecho del pueblo alterarlo o abolirlo, e instituir un nuevo Gobierno, sentando sus bases sobre tales principios y organizando sus poderes en la forma, que parece muy probable que transmitan su Seguridad y Felicidad. La prudencia, de hecho, dictará que los gobiernos establecidos desde hace mucho tiempo no se cambien por motivos de luz y de transición; y en consecuencia toda experiencia ha deshecho, que la humanidad está más dispuesta a sufrir, mientras que los males son padecibles, que a corregirse a sí mismos mediante la abolición de las formas a las que están acostumbrados. Pero cuando un largo tren de abusos y usurpaciones, persiguiendo invariablemente el mismo Objeto evidencia un diseño para reducirlos bajo despotismo absoluto, es su derecho, es su deber, deshacerse de tal Gobierno, y proporcionar nuevos Guardias para su futura seguridad.-Tal ha sido el paciente sufrimiento de estas colonias; y tal es ahora la necesidad que los limita para alterar sus antiguos Sistemas de Gobierno. La historia del actual Rey de Gran Bretaña es un historial de repetidas lesiones y usurpaciones, todos teniendo en objeto directo el establecimiento de una tiranía absoluta sobre estos Estados. Para demostrarlo, que los hechos se sometan a un mundo sincero. Ha rechazado su Asentimiento a las Leyes, el más sano y necesario para el bien público. Ha prohibido a sus gobernadores aprobar leyes de importancia inmediata y apremiante, a menos que se suspendan en su operación hasta que se obtenga su consentimiento; y cuando así lo suspendan, ha descuidado totalmente atenderlos. Se ha negado a aprobar otras Leyes para el alojamiento de grandes distritos de personas, a menos que esas personas renuncien al derecho de representación en la Legislatura, un derecho inestimable para ellos y formidable sólo para los tiranos. Ha convocado a los órganos legislativos en lugares insólidos, incómodos y distantes del depósito de sus registros públicos, con el único fin de engordarlos para que cumplan con sus medidas. Ha disuelto las Cámaras de Representantes en repetidas ocasiones, por oponerse con una firmeza varonil a sus invasiones a los derechos del pueblo. Se ha negado durante mucho tiempo, después de tales disoluciones, a hacer que otros sean elegidos; por lo que los poderes legislativos, incapaces de aniquilar, han regresado al pueblo en general para su ejercicio; el Estado permanece en el tiempo medio expuesto a todos los peligros de la invasión desde fuera, y convulsiones dentro. Se ha esforzado por impedir que la población de estos Estados; para ello obstruyan las leyes de naturalización de los extranjeros; negándose a aprobar a otros para alentar sus migraciones y aumentando las condiciones de las nuevas consignaciones de tierras. Ha obstruido la Administración de Justicia, al rechazar su asentimiento a las leyes para establecer poderes judiciales. Ha hecho que los jueces dependan solo de su voluntad, de la permanencia en sus cargos, y del monto y pago de sus salarios. Ha erigido una multitud de New Offices, y ha enviado enjambres de oficiales para acosar a nuestra gente, y comer su sustancia. Ha mantenido entre nosotros, en tiempos de paz, ejércitos permanentes sin el consentimiento de nuestras legislaturas. Se ha visto afectado para hacer a los militares independientes y superiores al poder civil. Se ha combinado con otros para someternos a una jurisdicción ajena a nuestra constitución, y no ha sido reconocida por nuestras leyes; dando su Asentimiento a sus Actos de la pretendida Legislación: Para Cuarmar grandes cuerpos de tropas armadas entre nosotros: Por protegerlos, mediante un simulacro de juicio, del castigo por cualquier asesinato que deban cometer sobre los habitantes de estos Estados: Por cortar nuestro comercio con todas partes del mundo: Por imponernos impuestos sin nuestro consentimiento: Por privarnos en muchos casos, de los beneficios de Juicio por Jurado: Que nos transporte más allá de Seas sea juzgado por delitos falsos: Por abolir el sistema libre de leyes inglesas en una provincia vecina, establecer en ella un gobierno arbitrario, y ampliar sus límites para convertirlo a la vez como un ejemplo e instrumento adecuado para introducir la misma regla absoluta en estas colonias: Por quitar nuestras Cartas, abolir nuestras leyes más valiosas y alterar fundamentalmente las Formas de nuestros Gobiernos: Por suspender nuestras propias Legislaturas, y declararse investidos de poder para legislarnos en todos los casos. Ha abdicó al Gobierno aquí, declarándonos fuera de su protección y librando la guerra contra nosotros. Ha saqueado nuestros mares, ha arrasado nuestras costas, quemado nuestras ciudades y destruido las vidas de nuestro pueblo. En este momento está transportando grandes ejércitos de mercenarios extranjeros para completar las obras de muerte, desolación y tiranía, ya iniciadas con circunstancias de crueldad y perfidia apenas paralelas en las edades más bárbaras, y totalmente indigna la Cabeza de una nación civilizada. Ha obligado a nuestros compañeros ciudadanos a llevar cautivos en el alto mar a llevar armas contra su país, a convertirse en los verdugos de sus amigos y hermanos, o caerse por sus manos. Ha entusiasmado las insurrecciones internas entre nosotros, y se ha esforzado por traer a los habitantes de nuestras fronteras, los despiadados escudos indios, cuyo conocido gobierno de guerra, es una destrucción indistinguible de todas las edades, sexos y condiciones. En cada etapa de estas opresiones hemos pedido la posibilidad de Redress en los términos más humildes: Nuestras repetidas peticiones han sido respondidas sólo por lesiones repetidas. Un príncipe, cuyo carácter está marcado por cada acto que puede definir a un tirano, no es apto para ser el gobernante de un pueblo libre. Tampoco hemos estado queriendo en las atenciones a nuestros hermanos Brittish. Les hemos advertido de vez en cuando de intentos de su legislatura de extender una jurisdicción injustificable sobre nosotros. Les hemos recordado las circunstancias de nuestra emigración y arreglo aquí. Hemos apelado a su justicia nativa y magnanimidad, y los hemos conjurado por los lazos de nuestra parentesca común para desautorizar estas usurpaciones, lo que inevitablemente interrumpiría nuestras conexiones y correspondencia. Ellos también han sido sordos a la voz de la justicia y de la consanguinidad. Debemos, por lo tanto, consentir en la necesidad, que denuncia nuestra separación, y sostenerlos, como sostenemos al resto de la humanidad, enemigos en la guerra, en Amigos de la Paz. Por lo tanto, los Representantes de los Estados Unidos unidos de los Estados Unidos, reunidos, apelando al Juez Supremo del mundo para que rectifique nuestras intenciones, hacemos, en el Nombre, y por la Autoridad del Pueblo Bueno de estas colonias, publican y declaran solemnemente, que estas Colonias de los Estados Unidos son, y de Derecho deben ser Estados Libres e Independientes; que están Absueltos de toda la Lealtad a la Corona Británica, y que toda conexión política entre ellos y el Estado de Gran Bretaña, es y debe ser totalmente disuelta; y que como Estados Libres e Independientes, tienen pleno poder para cobrar la guerra, concluyen la Paz, los contratos de las alianzas, el comercio y para hacer todas las demás leyes y cosas que los Estados independientes pueden hacer. Y para el apoyo de esta Declaración, con una firme dependencia de la protección de la Providencia divina, nos comprometemos mutuamente nuestras vidas, nuestras Fortunas y nuestro sagrado honor.' } }},
    atlas = 'atlas', pos = {x = 3, y = 0},
    rarity = 2,
    cost = 8,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,

    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.currentquip = card.ability.extra.currentquip + 1
            if card.ability.extra.currentquip > 6 then
                card.ability.extra.currentquip = 1
            end
        card.ability.extra.currentchips = pseudorandom("lamar_tiberi", card.ability.extra.minimumpossible, card.ability.extra.maximumpossible)
        return {
            chips = card.ability.extra.currentchips,
            message = card.ability.extra.quips[card.ability.extra.currentquip]
        } end
    end
}


SMODS.Joker{
    key = "falso_chicot",
    loc_vars = function(self, info_queue, card)
        return {
            key = next(SMODS.find_card("j_mucho_translator")) and "j_mucho_falso_chicottranslated" or "j_mucho_falso_chicot",
            vars = {
                card.ability.extra.fakeXmult
            }
        } end,
    atlas = 'atlas', pos = {x = 3, y = 1},
    rarity = 1,
    cost = -3,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { minXmult = 0, maxXmult = 200, fakeXmult = 15, Xmult = '¡MALDITO HIJO DE PUTA! ¡SABES QUE NO SOY LA VERDADERA CHICOT, MALDITO ESTÚPIDO!'}},

	calculate = function(self, card, context)
		-- Tests if context.joker_main == true.
		-- joker_main is a SMODS specific thing, and is where the effects of jokers that just give +stuff in the joker area area triggered, like Joker giving +Mult, Cavendish giving XMult, and Bull giving +Chips.
		if context.joker_main then
			-- Tells the joker what to do. In this case, it pulls the value of mult from the config, and tells the joker to use that variable as the "mult_mod".
			return {
				Xmult_mod = pseudorandom("falso_chicot", card.ability.extra.minXmult, card.ability.extra.maxXmult)/1000,
				-- This is a localize function. Localize looks through the localization files, and translates it. It ensures your mod is able to be translated. I've left it out in most cases for clarity reasons, but this one is required, because it has a variable.
				-- This specifically looks in the localization table for the 'variable' category, specifically under 'v_dictionary' in 'localization/en-us.lua', and searches that table for 'a_mult', which is short for add mult.
				-- In the localization file, a_mult = "+#1#". Like with loc_vars, the vars in this message variable replace the #1#.
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
				-- Without this, the mult will stil be added, but it'll just show as a blank red square that doesn't have any text.
			}
		end
	end
}

SMODS.Joker{
    key = "elbueno",
    loc_vars = function(self, info_queue, card)
        return {
            key = next(SMODS.find_card("j_mucho_translator")) and "j_mucho_elbuenotranslated" or "j_mucho_elbueno",
            vars = {
                card.ability.extra.add_hands,
                colours = {
                    G.C.BLUE,
                    G.C.UI.TEXT_INACTIVE
                }
            }
        } end,
    atlas = 'atlas', pos = {x = 0, y = 2},
    rarity = 1,
    cost = 3,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { add_hands = 1 }},

    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.add_hands
        ease_hands_played(card.ability.extra.add_hands)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.add_hands
        ease_hands_played(-card.ability.extra.add_hands)
    end
}

SMODS.Joker{
    key = "elbruto",
    loc_vars = function(self, info_queue, card)
        return {
            key = next(SMODS.find_card("j_mucho_translator")) and "j_mucho_elbrutotranslated" or "j_mucho_elbruto",
            vars = {
                card.ability.extra.add_discards,
                colours = {
                    G.C.RED,
                    G.C.UI.TEXT_INACTIVE
                }
            }
        } end,
    atlas = 'atlas', pos = {x = 1, y = 2},
    rarity = 1,
    cost = 3,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { add_discards = 1 }},

    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.add_discards
        ease_discard(card.ability.extra.add_discards)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.add_discards
        ease_discard(-card.ability.extra.add_discards)
    end
}






SMODS.Joker{
    key = "elfeo",
    loc_vars = function(self, info_queue, card)
        return {
            key = next(SMODS.find_card("j_mucho_translator")) and "j_mucho_elfeotranslated" or "j_mucho_elfeo",
            vars = {
                card.ability.extra.xxmult,
                colours = {
                    G.C.RARITY.Common
                }
            }
        } end,
    atlas = 'atlas', pos = {x = 2, y = 2},
    rarity = 'mucho_rarerthanrare',
    cost = 9,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { buenofound = 'test: bueno found', xxmult = 10, xxmultmsg = 'Lo has logrado. X10', xxmultlost = 0, xxmultlostmsg = 'Has fallado. X0' }},

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local elbueno, elbruto = next(SMODS.find_card("j_mucho_elbueno")), next(SMODS.find_card("j_mucho_elbruto"))
            if elbueno then
                if elbruto then
                    return {
                        Xmult_mod = card.ability.extra.xxmult,
                        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xxmultmsg } }
                    }
                end
            end
            return {
                Xmult_mod = card.ability.extra.xxmultlost,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xxmultlostmsg } }
            }
        end
    end
}


SMODS.Joker{
    key = "quandale_tiberi",
    loc_vars = function(self, info_queue, card)
        return {
            key = next(SMODS.find_card("j_mucho_translator")) and "j_mucho_quandale_tiberitranslated" or "j_mucho_quandale_tiberi",
            vars = {
                G.GAME.probabilities.normal,
                card.ability.extra.secondprob,
                colours = {
                    G.C.UI.TEXT_INACTIVE,
                    G.C.FILTER
                }
            }
        } end,
    atlas = 'atlas', pos = {x = 3, y = 2},
    rarity = "mucho_rarerthanrare",
    cost = 11,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { firstprob = 1, secondprob = 10, current_upgrade = 0 }},

	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if pseudorandom("chips") < G.GAME.probabilities.normal / card.ability.extra.secondprob then

                card.ability.extra.current_upgrade = pseudorandom("quandaletiberi",1, 4)

                if card.ability.extra.current_upgrade == 1 then -- add chips to the card!
                    context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
                    context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + pseudorandom("lamar_tiberichips", 1, 5)
                    return {
                        extra = { message = '¡+ fichas!', colour = G.C.CHIPS },
                        card = card
                    }

                elseif card.ability.extra.current_upgrade == 2 then -- add +mult to the card!
                    context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
                    context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + pseudorandom("lamar_tiberimult", 1, 5)
                    return {
                        extra = { message = '¡+ múltiple!', colour = G.C.MULT },
                        card = card
                    }

                elseif card.ability.extra.current_upgrade == 3 then -- add xmult to the card!
                    context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult or 1
                    context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult + (pseudorandom("lamar_tiberixchips",500,1500) / 1000)
                    return {
                        extra = { message = '¡x múltiple!', colour = G.C.MULT },
                        card = card
                    }

                elseif card.ability.extra.current_upgrade == 4 then -- add xchips to the card!
                    context.other_card.ability.perma_x_chips = context.other_card.ability.perma_x_chips or 1
                    context.other_card.ability.perma_x_chips = context.other_card.ability.perma_x_chips + (pseudorandom("lamar_tiberixmult",500,1500) / 1000)
                    return {
                        extra = { message = '¡x fichas!', colour = G.C.CHIPS },
                        card = card
                    }
                end
            end
		end
        if context.end_of_round and context.cardarea == G.jokers then
            card.ability.extra.secondprob = pseudorandom("lamar_tiberiprob",16, 64)
        end
	end
}

SMODS.Joker{
    key = "sinmostaza",
    loc_vars = function(self, info_queue, card)
        return {
            key = next(SMODS.find_card("j_mucho_translator")) and "j_mucho_sinmostazatranslated" or "j_mucho_sinmostaza",
            vars = {
                card.ability.extra.add_hands,
                colours = {
                    G.C.SECONDARY_SET.Tarot,
                    G.C.FILTER,
                    G.C.UI.TEXT_INACTIVE
                }
            }
        } end,
    atlas = 'atlas', pos = {x = 0, y = 3},
    rarity = 2,
    cost = 6,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = {}},

    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            SMODS.add_card{key = "c_mucho_mostaza"}
        end
    end
}

SMODS.Joker{
    key = "senorfreud",
    loc_vars = function(self, info_queue, card)
        return {
            key = next(SMODS.find_card("j_mucho_translator")) and "j_mucho_senorfreudtranslated" or "j_mucho_senorfreud",
            vars = {
                G.GAME.probabilities.normal,
                colours = {
                    G.C.SECONDARY_SET.Tarot,
                    G.C.FILTER
                }
            }
        } end,
    atlas = 'atlas', pos = {x = 3, y = 3},
    rarity = 2,
    cost = 6,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { backupfreudactivations = 0}},

    update = function(self, card, dt)
        if next(SMODS.find_card("j_mucho_senorfreud")) then
            if G.FreudActivations == 0 then
                G.FreudActivations = card.ability.extra.backupfreudactivations
            end
            card.ability.extra.backupfreudactivations = G.FreudActivations
        end
        -- print("total mult "..card.ability.extra.totalxmult, "mult per ".. card.ability.extra.xmult_per, "freudactivations " ..G.FreudActivations, "backupfreud "..card.ability.extra.backupfreudactivations)
    end,
}

SMODS.Sound{
    key = 'salebalatritosound',
    path = 'salebalatrito.ogg'
}


SMODS.Joker{
    key = "salebalatrito",
    loc_vars = function(self, info_queue, card)
        return {
            key = next(SMODS.find_card("j_mucho_translator")) and "j_mucho_salebalatritotranslated" or "j_mucho_salebalatrito",
            vars = {
                colours = {
                    G.C.SECONDARY_SET.Tarot,
                    G.C.FILTER
                }
            }
        } end,
    atlas = 'atlas', pos = {x = 2, y = 3},
    rarity = 2,
    cost = 6,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = {msg = 'Sale balatrito?'}},

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = pseudorandom("salebalatrito",0,10),
                message = card.ability.extra.msg,
                play_sound('mucho_salebalatritosound', pseudorandom("salebalatritopitch",1500,4000)/2000, 1)
            }
        end
    end
}

SMODS.Joker{
    key = "ohhokay",
    loc_vars = function(self, info_queue, card)
        return {
            key = next(SMODS.find_card("j_mucho_translator")) and "j_mucho_ohhokaytranslated" or "j_mucho_ohhokay",
            vars = {
                G.GAME.probabilities.normal,
                card.ability.extra.chance,
                colours = {
                    G.C.SECONDARY_SET.Tarot,
                    G.C.FILTER
                }
            }
        } end,
    atlas = 'atlas', pos = {x = 1, y = 3},
    rarity = 3,
    cost = 6,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = {normal = 1, chance = 15}},


    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if pseudorandom("socialcredit") < G.GAME.probabilities.normal / card.ability.extra.chance then
                context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult or 0
                context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult + 2
                return {
                    extra = { message = 'X2 yǒng jiǔ duō zhòng ！', colour = G.C.MULT },
                    card = card                    
                }
            end
        end
    end
}

SMODS.Joker{
    key = "verdadero_chicot",
    loc_vars = function(self, info_queue, card)
        return {
            key = next(SMODS.find_card("j_mucho_translator")) and "j_mucho_verdadero_chicottranslated" or "j_mucho_verdadero_chicot",
            vars = {
                card.ability.extra.realXmult,
                colours = {
                    G.C.UI.TEXT_INACTIVE
                }
            }
        } end,
    atlas = 'chicotatlas', pos = {x = 0, y = 0}, soul_pos = {x = 1, y = 0},
    rarity = "mucho_exceptional",
    cost = 35,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    config = { extra = { realXmult = 7, Xmult = ''}},

	calculate = function(self, card, context)
		-- Tests if context.joker_main == true.
		-- joker_main is a SMODS specific thing, and is where the effects of jokers that just give +stuff in the joker area area triggered, like Joker giving +Mult, Cavendish giving XMult, and Bull giving +Chips.
		if context.joker_main then
			-- Tells the joker what to do. In this case, it pulls the value of mult from the config, and tells the joker to use that variable as the "mult_mod".
			return {
				Xmult_mod = mult ^ (card.ability.extra.realXmult-1),
				-- This is a localize function. Localize looks through the localization files, and translates it. It ensures your mod is able to be translated. I've left it out in most cases for clarity reasons, but this one is required, because it has a variable.
				-- This specifically looks in the localization table for the 'variable' category, specifically under 'v_dictionary' in 'localization/en-us.lua', and searches that table for 'a_mult', which is short for add mult.
				-- In the localization file, a_mult = "+#1#". Like with loc_vars, the vars in this message variable replace the #1#.
				extra = { message = "^7 Mult", colour = G.C.DARK_EDITION}
				-- Without this, the mult will stil be added, but it'll just show as a blank red square that doesn't have any text.
			}
		end
	end
}

SMODS.Joker{
    key = "verdadero_canio",
    loc_vars = function(self, info_queue, card)
        return {
            key = next(SMODS.find_card("j_mucho_translator")) and "j_mucho_verdadero_caniotranslated" or "j_mucho_verdadero_canio",
            vars = {
                card.ability.extra.realXchips,
                colours = {
                    G.C.UI.TEXT_INACTIVE,
                    G.C.FILTER
                }
            }
        } end,
    atlas = 'canioatlas', pos = {x = 0, y = 0}, soul_pos = {x = 1, y = 0},
    rarity = "mucho_exceptional",
    cost = 35,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    config = { extra = { realXchips = 2, Xchips = '¡Eres el chivo, mi amigo!'}},

	calculate = function(self, card, context)
		-- Tests if context.joker_main == true.
		-- joker_main is a SMODS specific thing, and is where the effects of jokers that just give +stuff in the joker area area triggered, like Joker giving +Mult, Cavendish giving XMult, and Bull giving +Chips.
		if context.before then
			-- Tells the joker what to do. In this case, it pulls the value of mult from the config, and tells the joker to use that variable as the "mult_mod".
            return{
                level_up = 6,
                message = card.ability.extra.Xchips
            }
		end
	end
}





-- From here on out, all jokers are back to ENGLISH

SMODS.Joker {
	key = 'mobilegameads',
	loc_txt = {
		name = 'Mobile Game Ads',
		text = {
            'Every hand plays a {V:1}short',
            '{V:1}unskippable video{} that grants {V:2}+#1#',
            'Mult to the joker',
            '{V:3}(Currently: {V:2}+#2#{} {V:3}Mult){}'
		}
	},
	config = { extra = { currentvideo = 1, mult = 0, multgain = 3, msg = 'Reward obtained!' } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.multgain, card.ability.extra.mult, colours = { G.C.FILTER, G.C.MULT, G.C.UI.TEXT_INACTIVE} } }
	end,
	rarity = 2,
	atlas = 'atlas2',
	pos = { x = 0, y = 0 },
	cost = 0,
    pools = {["BalatrezAddition"] = true},
	calculate = function(self, card, context)
		if context.joker_main then
            card.ability.extra.currentvideo = pseudorandom("mobilegameadsvideo",1,5)
            if card.ability.extra.currentvideo == 1 then
                G.FUNCS.overlay_menu{
                    definition = Create_UIBox_custom_video1("tiktok1","Please watch this video in order to finance the scored hand.", 15),
                    config = {no_esc = true},
                    pause = false
                }
            elseif card.ability.extra.currentvideo == 2 then
                G.FUNCS.overlay_menu{
                    definition = Create_UIBox_custom_video1("tiktok2","Please watch this video in order to donate to a randomly-chosen Make-A-Wish child.", 15),
                    config = {no_esc = true},
                    pause = false
                }
            elseif card.ability.extra.currentvideo == 3 then
                G.FUNCS.overlay_menu{
                    definition = Create_UIBox_custom_video1("tiktok3","Please watch this video in order to keep Mr. Bones in his slumber.", 15),
                    config = {no_esc = true},
                    pause = false
                }
            elseif card.ability.extra.currentvideo == 4 then
                G.FUNCS.overlay_menu{
                    definition = Create_UIBox_custom_video1("tiktok4","Please watch this video in order to win.", 15),
                    config = {no_esc = true},
                    pause = false

                }
            elseif card.ability.extra.currentvideo == 5 then
                G.FUNCS.overlay_menu{
                    definition = Create_UIBox_custom_video1("tiktok5","just watch the fucking video", 15),
                    config = {no_esc = true},
                    pause = false

                }
            end
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multgain
            return {
                mult = card.ability.extra.mult,
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.Xmsg } }
            }
		end
	end
}


SMODS.Joker {
	key = 'mobilegameads2',
	loc_txt = {
		name = 'Mobile Game Ads 2: The Freemium Upgrade',
		text = {
            'Grants {X:mult,V:4}X#1#{} Mult',
            'to every {V:1}hand played{}',
            'Plays an {V:1}unskippable ad{} every',
            '{V:1}#4#{} hands played',
            '{V:3}(#3#){}'
		}
	},
	config = { extra = { currentvideo = 1, Xmult = 2.5, activemsg = 'inactive', handsremaining = 2, every = 2, Xmsg = 'Thank you for using our Joker.'} },
	loc_vars = function(self, info_queue, card)
		return { vars = { 
            card.ability.extra.Xmult,
            card.ability.extra.activemsg,
            localize { type = 'variable', key = (card.ability.extra.handsremaining == 0 and 'loyalty_active' or 'loyalty_inactive'), vars = { card.ability.extra.handsremaining } }, 
            card.ability.extra.every + 1,
            colours = { G.C.FILTER, G.C.MULT, G.C.UI.TEXT_INACTIVE, G.C.WHITE} } }
	end,
	rarity = 3,
	atlas = 'atlas2',
	pos = { x = 1, y = 0 },
	cost = 0,
    pools = {["BalatrezAddition"] = true},

	calculate = function(self, card, context)

		if context.joker_main then

            card.ability.extra.handsremaining = (card.ability.extra.every - 1 - (G.GAME.hands_played - card.ability.hands_played_at_create)) % (card.ability.extra.every + 1)

            if not context.blueprint then

                if card.ability.extra.loyalty_remaining == 0 then

                    local eval = function(card) return card.ability.extra.handsremaining == 0 and not G.RESET_JIGGLES end
                    juice_card_until(card, eval, true)

                end
            end
            if card.ability.extra.handsremaining == card.ability.extra.every then

                card.ability.extra.currentvideo = pseudorandom("mobilegameads2video",1,6)

                if card.ability.extra.currentvideo == 1 then
                    G.FUNCS.overlay_menu{
                        definition = Create_UIBox_custom_video1("ad1",'As a part of our Freemium program, please watch the video to continue gaining the "free" multiplier.', 15),
                        config = {no_esc = true},
                        pause = true

                    }

                elseif card.ability.extra.currentvideo == 2 then
                    G.FUNCS.overlay_menu{
                        definition = Create_UIBox_custom_video1("ad2",'As a part of our Freemium program, please watch the video to continue getting carried by our Joker.', 15),
                        config = {no_esc = true},
                        pause = true

                    }

                elseif card.ability.extra.currentvideo == 3 then
                    G.FUNCS.overlay_menu{
                        definition = Create_UIBox_custom_video1("ad3",'As a part of our Freemium program, please watch the video to not suck at the game.', 15),
                        config = {no_esc = true},
                        pause = true

                    }

                elseif card.ability.extra.currentvideo == 4 then
                    G.FUNCS.overlay_menu{
                        definition = Create_UIBox_custom_video1("ad4",'As a part of our Freemium program, please watch :3', 15),
                        config = {no_esc = true},
                        pause = true

                    }

                elseif card.ability.extra.currentvideo == 5 then
                    G.FUNCS.overlay_menu{
                        definition = Create_UIBox_custom_video1("ad5",'As a part of our Freemium program, please watch the video to keep on using the Joker.', 15),
                        config = {no_esc = true},
                        pause = true

                    }

                elseif card.ability.extra.currentvideo == 6 then
                    G.FUNCS.overlay_menu{
                        definition = Create_UIBox_custom_video1("ad6",'As a part of our Freemium program, please wait until the video finishes to continue playing.', 15),
                        config = {no_esc = true},
                        pause = true
                    }

                end
            end
            return {
                Xmult_mod = card.ability.extra.Xmult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.Xmsg } }
            }
        end
    end
}


SMODS.Joker{
    key = "heavysimpson",
    loc_txt = {
        name = "Heavy Simpson",
        text = {
            'All {V:2}rerolls{} cost between',
            '{V:1}-5${} and {V:1}12${}',
            '{V:3}(Reroll price scaling is still active)',
            '{V:2}+1{} card slot available in shop'
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.realXchips,
                colours = {
                    G.C.MONEY,
                    G.C.FILTER,
                    G.C.UI.TEXT_INACTIVE
                }
            }
        } end,
    atlas = 'atlas2', pos = {x = 2, y = 0},
    rarity = 2,
    cost = 7,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    config = { extra = { shopsize = 3 }},

    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.oldshopsize = G.GAME.shop.joker_max
        card.ability.extra.oldrerollprice = G.GAME.round_resets.reroll_cost
        G.GAME.shop.joker_max = card.ability.extra.oldshopsize + 1
    end,

    remove_from_deck = function(self, card, from_debuff)
		G.GAME.shop.joker_max = card.ability.extra.oldshopsize
        G.GAME.round_resets.reroll_cost = card.ability.extra.oldrerollprice
	end,
    
    calculate = function(self, card, context)
        

        if context.starting_shop then
            G.GAME.round_resets.reroll_cost = pseudorandom("heavysimpsonstart",-5,15)
            G.GAME.shop.joker_max = card.ability.extra.oldshopsize + 1
        end

        if context.reroll_shop then
            G.GAME.round_resets.reroll_cost = pseudorandom("heavysimpsonreroll",-5,15)
        end
    end,
}



SMODS.Joker{
    key = "sigmundfreud",
    loc_vars = function(self, info_queue, card)
        return {
            key = G.SigmundActivated == true and "j_mucho_sigmundfreud2" or "j_mucho_sigmundfreud1",
            vars = {
                card.ability.extra.xmult_per,
                card.ability.extra.totalxmult + 1,
                colours = {
                    HEX('ff0000'),
                    HEX('ff8000'),
                    HEX('ffff00'),
                    HEX('80ff00'),
                    HEX('00ff80'),
                    HEX('0080ff'),
                    HEX('0000ff'),
                    G.C.UI.TEXT_INACTIVE,
                    G.C.MULT,
                    G.C.RARITY.Common
                }
            }
        } end,
    atlas = 'atlas2', pos = {x = 3, y = 0}, soul_pos = {x = 4, y = 0},
    rarity = 3,
    cost = 9,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = {xmult_per = 0.1, totalxmult = 1, quip = math.random(1,2), msg = "Sigmund!", backupfreudactivations = 0}},

    update = function(self, card, dt)
        if next(SMODS.find_card("j_mucho_sigmundfreud")) then
            if G.FreudActivations == 0 then
                G.FreudActivations = card.ability.extra.backupfreudactivations
            end
            card.ability.extra.backupfreudactivations = G.FreudActivations
            card.ability.extra.totalxmult = G.FreudActivations * card.ability.extra.xmult_per
        end
        -- print("total mult "..card.ability.extra.totalxmult, "mult per ".. card.ability.extra.xmult_per, "freudactivations " ..G.FreudActivations, "backupfreud "..card.ability.extra.backupfreudactivations)
    end,


    calculate = function(self, card, context)
        if context.joker_main then
            if G.SigmundActivated == true then
                card.ability.extra.quip = math.random(1,2)
                if card.ability.extra.quip == 1 then
                    card.ability.extra.msg = "Sigmund!"
                elseif card.ability.extra.quip == 2 then
                    card.ability.extra.msg = "Freud!"
                end
                return {
                    xmult = card.ability.extra.totalxmult,
                    message = card.ability.extra.msg
                }
            end
        end
    end

}

SMODS.Atlas{
    key = 'chudanim',
    path = 'chudanim.png',
    px = 204,
    py = 116.5,
}

SMODS.Joker{
    key = 'thechuds',
    loc_txt = {
        name = "The Chuds",
        text = { "Has a {C:green,E:1}#1# in #2#{} chance to",
            "grant {X:mult,C:white}X#3#{} Mult{}",
            "Has a {C:green,E:1}#4# in #2#{} chance to",
            "do {V:1}something else{}",}
    },
    config = { extra = {prob = 5, xmult = 3.7, rerolls = 0, xmsg = "chud life! dōmo arigatō!! x3", dolmsg = "Okane! Okane! Okane! Anata dake no tame ni! Eien ni jinsei o tanoshinde!", employmentmsg = "get a fucking life", swapmsg = "`Mult' to `chippusu' o irekaemashita! Anata dake no tame ni! Chadoraifu yo eien ni!", lvlupmsg = "Reberuappu! Anata dake no tame ni! Chadoraifu wa eien ni!"}},

    loc_vars = function(self, info_queue, center)
		return { vars = { G.GAME.probabilities.normal, center.ability.extra.prob, center.ability.extra.xmult, center.ability.extra.prob - G.GAME.probabilities.normal, colours = {G.C.FILTER} }  }
	end,

    atlas = 'chudanim',
    rarity = 3,
    cost = 9,
    pools = {["BalatrezAddition"] = true},

    pixel_size = { w = 71 , h = 95 },
    frame = 0,

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},

    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('seed') < G.GAME.probabilities.normal / card.ability.extra.prob then
                return {
                    Xmult_mod = card.ability.extra.xmult,
                    message = card.ability.extra.xmsg
                }
            else
                local whatshallwedo = pseudorandom("thechuds",1, 7)
                if whatshallwedo == 1 then
                    G.FUNCS.overlay_menu{
                            definition = Create_UIBox_custom_video1("chud",'Taihen mōshiwakegozaimasen ga, XMult ga mitsukarimasendeshita. Kawarini kono bideo o goran kudasai.', 8),
                            config = {no_esc = true},
                            pause = true
                        }
                    card.ability.extra.rerolls = card.ability.extra.rerolls + 1
                    SMODS.change_free_rerolls(card.ability.extra.rerolls)
                elseif whatshallwedo == 2 then
                    return {
                        dollars = 8,
                        message = card.ability.extra.dolmsg
                    }
                elseif whatshallwedo == 3 then
                    return {
                        level_up = 1,
                        message = card.ability.extra.lvlupmsg
                    }
                elseif whatshallwedo == 4 then
                    return {
                        swap = true,
                        message = card.ability.extra.lvlupmsg
                    }
                elseif whatshallwedo == 5 and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    SMODS.add_card{key = "c_mucho_employment"}
                    return {
                        message = card.ability.extra.employmentmsg
                    }
                elseif whatshallwedo == 6 then
                    SMODS.add_card {
                        set = "Tarot",
                        area = G.consumeables,
                        skip_materialize = true,
                        edition = "e_negative"
                    }
                    return {
                        message = "Muryō de `negatibutarottokādo' purezento! Chadoraifufōebā!"
                    }
                elseif whatshallwedo == 7 and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                    local postnegativechance = pseudorandom("thechudsnegative",1, 3)
                    if postnegativechance == 1 then
                        SMODS.add_card {
                            set = "Joker",
                            area = G.jokers,
                            skip_materialize = true,
                            key = "j_mucho_thechuds",
                            edition = "e_negative"
                        }
                    else
                        SMODS.add_card {
                            set = "Joker",
                            area = G.jokers,
                            skip_materialize = true,
                            key = "j_mucho_thechuds",
                            no_edition = true
                        }
                    return {
                        message = "Jakkupotto! Chado ga futatabi tōjō! Chadoraifu ni eikōare!"
                    }
                    end
                end
            end
        end
        if context.reroll_shop and card.ability.extra.rerolls > 0 then
            card.ability.extra.rerolls = card.ability.extra.rerolls - 1
        end
    end

}


SMODS.Atlas{
    key = 'mustardanim',
    path = 'mustardanim.png',
    px = 254,
    py = 254,
}

SMODS.Joker{
    key = 'mustardshocked',
    loc_txt = {
        name = "MUSTARD?!",
        text = { "Each {V:1}game tick{} has a {C:green,E:1}#1# in #2#{} chance",
            "to create a {V:2}Mostaza{} tarot card",
            "{V:3}(Must have room){}"}
    },
    config = { extra = {prob = 20000}},

    loc_vars = function(self, info_queue, center)
		return { vars = { G.GAME.probabilities.normal, center.ability.extra.prob, colours = {G.C.FILTER, G.C.SECONDARY_SET.Tarot, G.C.UI.TEXT_INACTIVE} }  }
	end,

    atlas = 'mustardanim',
    rarity = 2,
    cost = 5,
    pools = {["BalatrezAddition"] = true},

    pixel_size = { w = 71 , h = 95 },
    frame = 0,

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},

    update = function(self, card, dt)
        if next(SMODS.find_card("j_mucho_mustardshocked")) then
            if pseudorandom("mustardgeneration") < G.GAME.probabilities.normal / card.ability.extra.prob and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                SMODS.add_card{key = "c_mucho_mostaza"}
            end
        end
    end,
}

SMODS.Joker{
    key = "salebalatrito2",
    loc_txt = {
        name = "Sale balatrito!",
        text = {
            'Has a {V:2}randomly-chosen effect{} for',
            'every {V:2}hand played{}',
            '{V:1}(Four different effects are possible){}'
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                colours = {
                    G.C.UI.TEXT_INACTIVE,
                    G.C.FILTER
                }
            }
        } end,
    atlas = 'atlas2', pos = {x = 0, y = 1},
    rarity = 3,
    cost = 8,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = {msg = 'Sale balatrito?', random_effect = 4}},

    calculate = function(self, card, context)
        card.ability.extra.random_effect = pseudorandom("salebalatrito2effect",1, 19)
        if card.ability.extra.random_effect <= 6 then
            if context.joker_main then
                return {
                    chips = pseudorandom("salebalatrito2chips",0,50),
                    message = card.ability.extra.msg,
                    play_sound('mucho_salebalatritosound', pseudorandom("salebalatrito2pitch",1500,4000)/2000, 1)
                }
            end

        elseif card.ability.extra.random_effect > 6 and card.ability.extra.random_effect <= 12 then
            if context.joker_main then
                return {
                    G.FUNCS.overlay_menu{
                        definition = Create_UIBox_custom_video1("salebalatrito",'Sale balatrito!', 7.5),
                        config = {no_esc = true},
                        pause = true
                    },
                    dollars = 10
                }
            end

        elseif card.ability.extra.random_effect > 12 and card.ability.extra.random_effect <= 18 then

            G.showsomething = 12
            if context.joker_main then
                return {
                    x_mult = 1.9,
                    mult = 25
                }
            end

        elseif card.ability.extra.random_effect == 19 then
            if context.before then
                G.SETTINGS.GAMESPEED = 256
                for i=0, 10, 1 do
                    card_eval_status_text(card,'jokers',nil,nil,nil,{message = "watch this"})
                end
                for i=0, 10, 1 do
                    SMODS.add_card({key = "j_mucho_verdadero_chicot", edition = "e_mucho_ebalatritic"})
                end
            end
            if (context.final_scoring_step and context.cardarea == G.play) or context.end_of_round then
                local chicots = SMODS.find_card('j_mucho_verdadero_chicot', true)
                if #chicots > 0 then
                    SMODS.destroy_cards(chicots)
                end
                G.SETTINGS.GAMESPEED = 4

            end
        end
    end
}

SMODS.Joker{
    key = "myairpods",
    loc_txt = {
        name = "NOOO! MY AIRPODS!",
        text = {
            'This joker {V:1}recreates itself{} with',
            'a different {C:dark_edition,E:1}edition{} after:',
            '- {V:1}each hand drawn{}',
            '- {V:1}using a consumable{}',
            '- {V:1}skipping a blind{}',
            '- {V:1}adding a card to the deck{}',
            '- {V:1}rerolling the shop{}',
            '- {V:1}selling a card{}',
            '- {V:1}buying a card{}',
            '- {V:1}opening a booster pack{}',
            '',
            'Edition rates are {C:attention}multiplied{} by x40',
            'when this card is owned'
            }
    },
    atlas = 'atlas2', pos = {x = 1, y = 1},
    rarity = 1,
    cost = 3,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                colours = {
                    G.C.FILTER
                }
            }
        } end,
    
    add_to_deck = function(self, card, from_debuff)
        G.GAME.edition_rate = G.GAME.edition_rate * 40
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.edition_rate = G.GAME.edition_rate / 40
    end,
    calculate = function(self, card, context)
        if context.hand_drawn or context.using_consumeable or context.skip_blind or context.playing_card_added or context.reroll_shop or context.selling_card or context.buying_card or context.open_booster or context.pre_discard then
            local currentairpods = SMODS.find_card('j_mucho_myairpods', true)
            card:set_edition(poll_edition('haha', nil, nil, true))
        end
    end
}

SMODS.Atlas{
    key = 'translatlas',
    path = 'translator.png',
    px = 667,
    py = 268,
}

SMODS.Joker{
    key = "translator",
    loc_txt = {
        name = "Translator",
        text = {"{V:1}Translates{} most non-english",
                "items {V:1}in english{}"}
    },

    loc_vars = function(self, info_queue, card)
    return {
        vars = {
            colours = {
                G.C.FILTER
            }
        }
    } end,
    
    atlas = 'translatlas',
    rarity = 2,
    cost = 5.5,
    pools = {["BalatrezAddition"] = true}, 

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    display_size = { w = 0.99 * 71, h = 0.7 * 95 },
}

SMODS.Joker{
    key = "dummyjoker",
    loc_txt = {
        name = "Dummy Joker",
        text = {
            "Does nothing except",
            "take up a {V:1}Joker slot{}",
            "{V:2}(I'm here because of another joker. Find which one!){}"
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                colours = {
                    G.C.FILTER,
                    G.C.UI.TEXT_INACTIVE
                }
            }
        } 
    end,
    atlas = 'atlas2',
    pos = {x=3, y= 1},
    unlocked = true,
    rarity = "mucho_unobtainable",
    discovered = true,
    display_size = { w = 0.0001 * 71, h = 0.0001 * 95 },

    add_to_deck = function(self, Card, from_debuff)
        local oldcansellcard = Card.can_sell_card
        function Card:can_sell_card(context)
            local g = oldcansellcard(self, context)
            if (G.play and #G.play.cards > 0) or
                (G.CONTROLLER.locked) or 
                (G.GAME.STOP_USE and G.GAME.STOP_USE > 0)
            then return false end
            if self.config.center.key == "j_mucho_dummyjoker" then return false end
            return g
        end
    end
}

SMODS.Sound{
    key = 'hugebell',
    path = 'hugebell.ogg'
}
SMODS.Sound{
    key = 'mysterygo',
    path = 'snd_mysterygo.ogg'
}



SMODS.Joker{
    key = "bigassjoker",
    loc_txt = {
        name = "{f:mucho_impact}Gargantuan Joker",
        text = {"{X:mult,V:4,f:mucho_impact}X#1#{}{} {C:mult,f:mucho_impact}Mult{}",
                "{f:mucho_impact}if played hand contains a {V:1,f:mucho_impact}Pair",
                "{f:mucho_impact}This Joker takes up {V:2,f:mucho_impact}#2#{} {V:1,f:mucho_impact}Joker slots{}",
                "{s:0.5,V:3,f:mucho_impact}(by creating an unsellable Dummy Joker){}"}
    },

    loc_vars = function(self, info_queue, card)
    return {
        vars = {
            card.ability.extra.xmult,
            card.ability.extra.slotstaken,
            colours = {
                G.C.FILTER,
                G.C.DARK_EDITION,
                G.C.UI.TEXT_INACTIVE,
                G.C.WHITE
            }
        }
    } end,
    
    atlas = 'atlas2',
    rarity = 2,
    cost = 5.5,
    pools = {["BalatrezAddition"] = true}, 
    config = { extra = { xmult = 6, slotstaken = 2 } },

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=2, y= 1},
    display_size = { w = 2 * 71, h = 1 * 95 },

    add_to_deck = function(self, card, from_debuff)
        if #G.jokers.cards + G.GAME.joker_buffer >= G.jokers.config.card_limit - 1 then
            card:start_dissolve()
        else
            SMODS.add_card {
            set = "Joker",
            area = G.jokers,
            skip_materialize = true,
            key = "j_mucho_dummyjoker",
        }
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if SMODS.find_card("j_mucho_dummyjoker")[1] == nil then
            print('no dummy joker found; nothing ever happens in detroit')
            card_eval_status_text(card,'jokers',nil,nil,nil,{message = "you got no room bro READ THE JOKER DESCRIPTION"})
        else
            SMODS.destroy_cards(SMODS.find_card("j_mucho_dummyjoker")[1])
        end
    end,

	calculate = function(self, card, context)
		
		if context.joker_main and next(context.poker_hands['Pair']) then
			return {
                message = "X6 Mult",
				Xmult_mod = card.ability.extra.xmult,
                sound= "mucho_hugebell",
			}
		end
	end
}

SMODS.Joker {
    key = "ps3",
    loc_txt = {
        name = "PlayStation 3 Ultra Slim 500 Go (Black) + Grand Theft Auto V",
        text = {
            "Grants {X:mult,V:3}X#1#{} {C:mult}Mult{}",
            'Calculations are based on a {V:2}complicated formula{}',
            "{s:0.5,V:1}The formula: ((((1/300th of current blind requirement / amount of cards in deck) * (current round * (1 + amount of vouchers used)) - (amount of jokers owned * amount of consumables owned)) / (current money owned * current probabilities)) * (amount of hands left + (amount of discards left / 2)) - 0.9{}"
        }
    },
    config = { extra = { xmult = 1 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                colours = {
                    G.C.UI.TEXT_INACTIVE,
                    G.C.FILTER,
                    G.C.WHITE
                }
            }
        } end,
    atlas = 'atlas2',
    pos = {x = 4, y = 1},
    rarity = 3,
    cost = 8,
    pools = {["BalatrezAddition"] = true}, 

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    update = function(self, card, dt)
        if next(SMODS.find_card("j_mucho_ps3")) and G.GAME.blind.chips ~= nil and #G.playing_cards ~= nil and G.GAME.round ~= nil and #G.GAME.used_vouchers ~= nil and #G.jokers.cards ~= nil and #G.consumeables.cards ~= nil and G.GAME.dollars ~= nil and G.GAME.probabilities.normal ~= nil and G.GAME.current_round.hands_left ~= nil and G.GAME.current_round.discards_left ~= nil then
            card.ability.extra.xmult = ((((G.GAME.blind.chips / 300) / #G.playing_cards) * (G.GAME.round * (1 + #G.GAME.used_vouchers)) - (#G.jokers.cards * #G.consumeables.cards)) / (G.GAME.dollars * G.GAME.probabilities.normal)) * (G.GAME.current_round.hands_left + (G.GAME.current_round.discards_left / 2)) - 0.9
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.xmult = ((((G.GAME.blind.chips / 300) / #G.playing_cards) * (G.GAME.round * (1 + #G.GAME.used_vouchers)) - (#G.jokers.cards * #G.consumeables.cards)) / (G.GAME.dollars * G.GAME.probabilities.normal)) * (G.GAME.current_round.hands_left + (G.GAME.current_round.discards_left / 2)) - 0.9
            if next(SMODS.find_mod('Talisman')) then
                if lenient_bignum(card.ability.extra.xmult) < lenient_bignum(0) then
                    return {
                        Xmult_mod = lenient_bignum(0),
                        message = "The PS3 crashed!"
                    }
                else
                    return {
                        Xmult_mod = lenient_bignum(card.ability.extra.xmult),
                        message = "Grand Theft Auto V successfully launched!"
                    }
                end
            else
                if card.ability.extra.xmult < 0 then
                    return {
                        Xmult_mod = 0,
                        message = "The PS3 crashed!"
                    }
                else
                    return {
                        Xmult_mod = card.ability.extra.xmult,
                        message = "Grand Theft Auto V successfully launched!"
                    }
                end
            end
        end
    end
}

SMODS.Joker{ --Bluff Time, created with JokerForge (wanted to try it out)
    name = "Bluff Time",
    key = "blufftime",
    config = {
        extra = {
            mult = 2,
            chips = 7
        }
    },
    loc_txt = {
        ['name'] = 'Bluff Time',
        ['text'] = {
            [1] = 'Creates a wild {C:attention}7{} and a wild {C:attention}2{}',
            [2] = 'upon {C:attention}rerolling the shop{}',
            [3] = 'Scored {C:attention}7{}s give {C:blue}7{} {C:blue}Chips{}',
            [4] = 'Scored {C:attention}2{}s give {C:red}2{} {C:red}Mult{}'
        }
    },
    cost = 4,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    pools = {["BalatrezAddition"] = true},
    discovered = true,
    atlas = 'atlas3',
    pos = {x = 0, y = 1},

    loc_vars = function(self, info_queue, card)
        return {vars = {}}
    end,

    calculate = function(self, card, context)
        -- When shop is rerolled
        if context.reroll_shop and not context.blueprint then
            -- Add a 7 card
            local card_front_7 = pseudorandom_element({G.P_CARDS.S_7, G.P_CARDS.H_7, G.P_CARDS.D_7, G.P_CARDS.C_7}, pseudoseed('add_card_suit'))
            local new_card_7 = create_playing_card({
                front = card_front_7,
                center = G.P_CENTERS.m_wild
            }, G.discard, true, false, nil, true)
            
            G.E_MANAGER:add_event(Event({
                func = function()
                    new_card_7:start_materialize()
                    G.play:emplace(new_card_7)
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    return true
                end
            }))
            draw_card(G.play, G.deck, 90, 'up')
            if SMODS and SMODS.calculate_context then
                SMODS.calculate_context({ playing_card_added = true, cards = { new_card_7 } })
            end

            -- Add a 2 card
            local card_front_2 = pseudorandom_element({G.P_CARDS.S_2, G.P_CARDS.H_2, G.P_CARDS.D_2, G.P_CARDS.C_2}, pseudoseed('add_card_suit'))
            local new_card_2 = create_playing_card({
                front = card_front_2,
                center = G.P_CENTERS.m_wild
            }, G.discard, true, false, nil, true)
            
            G.E_MANAGER:add_event(Event({
                func = function()
                    new_card_2:start_materialize()
                    G.play:emplace(new_card_2)
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    return true
                end
            }))
            draw_card(G.play, G.deck, 90, 'up')
            if SMODS and SMODS.calculate_context then
                SMODS.calculate_context({ playing_card_added = true, cards = { new_card_2 } })
            end

            return {
                message = "Seven Deuce!"
            }
        end
        -- Individual card scoring
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if context.other_card:get_id() == 2 then
                return {
                    mult = card.ability.extra.mult
                }
            elseif context.other_card:get_id() == 7 then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}


SMODS.Joker{ --You Will Never Want To Take This Joker Ever, made with JokerForge purely to fill up a joker slot (for collection)
    name = "You Will Never Want To Take This Joker Ever",
    key = "youwillneverwanttotakethisjokerever",
    config = {
        extra = {
            odds = 2048,
            odds2 = 2,
            jokerneeded = 4,
            maxcards = 20
        }
    },
    pos = {
        x = 1,
        y = 1
    },
    cost = 4,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    pools = {["BalatrezAddition"] = true},
    atlas = 'atlas3',

    loc_vars = function(self, info_queue, card)
        key = "j_mucho_youwillneverwanttotakethisjokerever"
        return {vars = {G.GAME.probabilities.normal, card.ability.extra.odds, card.ability.extra.odds2, card.ability.extra.jokerneeded, card.ability.extra.maxcards}}
    end,

    calculate = function(self, card, context)
        -- When shop is rerolled
        if context.reroll_shop and not context.blueprint then
                if pseudorandom('effect_0_create_spectral_card') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    func = function()local created_spectral = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local spectral_card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_black_hole')
                        spectral_card:set_edition("e_negative", true)
                        spectral_card:add_to_deck()
                        G.consumeables:emplace(spectral_card)
                        return true
                    end
                }))
                    if created_spectral then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                    end
                    return true
                end
                }
            end
        end
        -- At the end of the round
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if (#G.jokers.cards == card.ability.extra.jokerneeded and #G.playing_cards < card.ability.extra.maxcards and (function()
    local count = 0
    for _, playing_card in pairs(G.playing_cards or {}) do
        if SMODS.get_enhancements(playing_card)["m_stone"] == true then
            count = count + 1
        end
    end
    return count > card.ability.extra.jokerneeded
end)()) then
                if pseudorandom('effect_0_copy_consumable') < G.GAME.probabilities.normal / G.GAME.probabilities.normal then
                return {
                    func = function()
            local target_cards = {}
            for i, consumable in ipairs(G.consumeables.cards) do
                table.insert(target_cards, consumable)
            end
            if #target_cards > 0  then
                local card_to_copy = pseudorandom_element(target_cards, pseudoseed('copy_consumable'))
                
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local copied_card = copy_card(card_to_copy)
                        copied_card:set_edition("e_negative", true)
                        copied_card:add_to_deck()
                        G.consumeables:emplace(copied_card)
                        
                        return true
                    end
                }))
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Copied Consumable!", colour = G.C.GREEN})
                if pseudorandom('dissolve') < G.GAME.probabilities.normal / card.ability.extra.odds2 then
                    card:start_dissolve()
                end
            end
                    return true
                end
                }
            end
            end
        end
    end
}






SMODS.Joker {
    key = "oopsall1s",
    loc_txt = {
        name = "Oops! All 1s",
        text = {
            "Halves all {C:attention}listed {C:green,E:1}probabilities",
            "{C:inactive}(ex: {C:green}1 in 3 {C:inactive}-> {C:green}0.5 in 3{C:inactive})"
        }
    },
    blueprint_compat = false,
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = true,
    pools = {["BalatrezAddition"] = true}, 
    atlas = "atlas3",
    pos = { x = 0, y = 0 },
    add_to_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v / 2
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v * 2
        end
    end,
}

SMODS.Joker {
    key = "oopsall12s",
    loc_txt = {
        name = "Oops! All 12s..?",
        text = {
            "Quadruples all {C:attention}listed {C:green,E:1}probabilities",
            "{C:inactive}(ex: {C:green}1 in 3 {C:inactive}-> {C:green}4 in 3{C:inactive})"
        }
    },
    blueprint_compat = false,
    rarity = 3,
    cost = 9,
    unlocked = true,
    discovered = true,
    pools = {["BalatrezAddition"] = true}, 
    atlas = "atlas3",
    pos = { x = 1, y = 0 },
    add_to_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v * 4
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v / 4
        end
    end,
}

SMODS.Joker {
    key = "oopsall?s",
    loc_txt = {
        name = "Oops! All blank",
        text = {
            "All {C:attention}listed{C:green,E:1} probabilities",
            "Have a {C:green}#1# in #2#{} chance of being {C:attention}permanently doubled",
            "after each {C:attention}hand played",
            "Probability {C:dark_edition}scales{} after each successful trigger"
        }
    },
    config = { extra = { odds = 128 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.GAME.probabilities.normal,
                card.ability.extra.odds,
            }
        } end,
    blueprint_compat = false,
    rarity = 'mucho_rarerthanrare',
    cost = 13,
    unlocked = true,
    discovered = true,
    pools = {["BalatrezAddition"] = true}, 
    atlas = "atlas3",
    pos = { x = 2, y = 0 },
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom("upgradeprob") < G.GAME.probabilities.normal / card.ability.extra.odds then
                for k, v in pairs(G.GAME.probabilities) do
                    G.GAME.probabilities[k] = v * 2
                end
                card.ability.extra.odds = card.ability.extra.odds * 4
                card_eval_status_text(card,'jokers',nil,nil,nil,{message = "All probabilities doubled!"})
            end
        end
    end
}

SMODS.Joker {
    key = "oopsallgone",
    loc_txt = {
        name = "Oops! All gone",
        text = {
            "All {C:attention}listed {C:green,E:1}probabilities{} are set to {C:attention}zero{}",
            "{C:inactive}(ex: {C:green}1 in 3 {C:inactive}-> {C:green}0 in 3{C:inactive})"
        }
    },
    blueprint_compat = false,
    rarity = 3,
    cost = 12,
    unlocked = true,
    discovered = true,
    pools = {["BalatrezAddition"] = true}, 
    atlas = "atlas3",
    pos = { x = 3, y = 0 },
    config = {extra = {old_prob = 0 }},

    add_to_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            card.ability.extra.old_prob = G.GAME.probabilities[k]
            G.GAME.probabilities[k] = 0
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = card.ability.extra.old_prob
        end
    end,
}

SMODS.Joker {
    key = "oopsd100",
    loc_txt = {
        name = "Oops! The humble D100",
        text = {
            "All {C:attention}listed {C:green,E:1}probabilities{} are multiplied by",
            "a {C:attention}random number{} between #1# and #2#",
            "Number {C:attention}changes after every discard",
            "{C:inactive}(Currently: {X:green,C:white}X#3#{C:inactive})"
        }
    },
    blueprint_compat = false,
    rarity = 3,
    cost = 12,
    unlocked = true,
    discovered = true,
    pools = {["BalatrezAddition"] = true}, 
    atlas = "atlas3",
    pos = { x = 4, y = 0 },
    config = {extra = {min = 0, max = 2, current = 1}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.min,
                card.ability.extra.max,
                card.ability.extra.current,
                colours = {
                    G.C.WHITE
                }
            }
        } end,
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.current = 1
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v * card.ability.extra.current
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v / card.ability.extra.current
        end
    end,

    calculate = function(self, card, context)
        if context.pre_discard then
            for k, v in pairs(G.GAME.probabilities) do
                G.GAME.probabilities[k] = v / card.ability.extra.current
            end
            card.ability.extra.current = pseudorandom("oopsd100",card.ability.extra.min*100, card.ability.extra.max*100) / 100
            for k, v in pairs(G.GAME.probabilities) do
                G.GAME.probabilities[k] = v * card.ability.extra.current
            end
        end
    end
}

SMODS.Joker {
    key = "ttbprint",
    loc_txt = {
        name = 'Blue "Ticking Time Bomb" Print',
        text = {
            "Copies ability of {C:attention}Joker{} to the right",
            "Each action in-game has a {C:green,E:1}#1# in #2#{}",
            "chance for this card to {C:red,E:2}self destruct{}"
        }
    },
    atlas = "atlas2", pos = {x=0, y=2},
    rarity = 2,
    pools = {["BalatrezAddition"] = true}, 
    cost = 6,
    blueprint_compat = true,
    config = {extra = {remaining_uses = 2, odds = 3000}},
    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
            end
            local compatible = other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            return { vars = {
                G.GAME.probabilities.normal or 1,
                card.ability.extra.odds or 1200
            }, main_end = main_end }
        end
    end,
    calculate = function(self, card, context)
        if card.ability.extra.remaining_uses <= G.GAME.probabilities.normal then
            card:start_dissolve()
        else
            local other_joker = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
            end
            card.ability.extra.remaining_uses = pseudorandom("ttbprint", card.ability.extra.odds)
            return SMODS.blueprint_effect(card, other_joker, context)
        end
    end
}

SMODS.Joker {
    key = "twoprint",
    loc_txt = {
        name = 'Twoprint',
        text = {
            "Copies ability of {C:attention}Joker{} to the right {C:attention}twice{}",
            "...as in, the one {C:attention}after the one to the right{}"
        }
    },
    atlas = "atlas2", pos = {x=1, y=2},
    pools = {["BalatrezAddition"] = true}, 
    rarity = 3,
    cost = 9,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
            end
            local compatible = other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            return { main_end = main_end }
        end
    end,
    calculate = function(self, card, context)
        if true then
            local other_joker = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 2] end
            end
            return SMODS.blueprint_effect(card, other_joker, context)
        end
    end
}

SMODS.Joker {
    key = "sigmundprint",
    loc_txt = {
        name = 'Sigmund "Blueprint" Freud',
        text = {
            "Copies ability of {C:attention}Joker{} to the right {C:attention}for{}",
            "every {C:attention}#1# activations{} of {C:chips}Señor Freud{}",
            "{C:inactive}(Currently: {C:attention}#2#{} {C:inactive}copies){}"
        }
    },
    atlas = "atlas2", pos = {x=2, y=2},
    pools = {["BalatrezAddition"] = true}, 
    rarity = "mucho_rarerthanrare",
    cost = 16,
    blueprint_compat = true,
    config = { extra = {retriggersneeded = 15, retriggers = 2}},
    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
            end
            local compatible = other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            return { vars = {
                card.ability.extra.retriggersneeded or 15,
                card.ability.extra.retriggers or 0,
            }, 
            main_end = main_end 
        }
        end
    end,
    update = function(self, card, dt)
        card.ability.extra.retriggers = math.floor(G.FreudActivations / card.ability.extra.retriggersneeded)
    end,
    calculate = function(self, card, context)
        if true then
            local other_joker = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
            end
            local merge = {}
            for i = 1, card.ability.extra.retriggers do
                local ret = SMODS.blueprint_effect(card, other_joker, context)
                if ret and next(ret) then
                    merge[#merge+1] = ret
            end
        end
            -- print(merge)
        if next(merge) then
            return SMODS.merge_effects(merge)
        end
        
    end
end
}

SMODS.Joker {
    key = "perkeoprint",
    loc_txt = {
        name = 'Perkeoprint',
        text = {
            "Copies ability of {C:attention}Joker{} to the right",
            "Has a {C:green,E:1}#1# in #2#{} chance to create",
            "a {C:dark_edition}negative{} copy of {C:attention}1{} random",
            "{C:attention}consumable{} card in your possession at the",
            "end of the {C:attention}shop{}"
        }
    },
    unlocked = false,
    blueprint_compat = true,
    rarity = 4,
    cost = 25,
    atlas = "atlas2",
    pools = {["BalatrezAddition"] = true},
    pos = { x = 3, y = 2 }, soul_pos = {x = 4, y = 2},
    config = {extra = {odds = 2}},
    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
            end
            local compatible = other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            return { vars = {G.GAME.probabilities.normal, card.ability.extra.odds}, main_end = main_end }
        end
    end,
    calculate = function(self, card, context)
        if context.ending_shop and G.consumeables.cards[1] then
            if pseudorandom('copy?') < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local card_to_copy, _ = pseudorandom_element(G.consumeables.cards, 'j_mucho_perkeoprint')
                        local copied_card = copy_card(card_to_copy)
                        copied_card:set_edition("e_negative", true)
                        copied_card:add_to_deck()
                        G.consumeables:emplace(copied_card)
                        return true
                    end
                }))
                return { message = localize('k_duplicated_ex') }
                end
        end
        local other_joker = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
        end
        return SMODS.blueprint_effect(card, other_joker, context)
    end,
}

SMODS.Atlas{
    key = "asblueprint",
    path = "allseeingblueprint.png",
    px = 355,
    py = 475
}


SMODS.Joker {
    key = "allseeingblueprint",
    loc_txt = {
        name = "The all-seeing Blueprint",
        text = {"Copies ability of a random {C:attention}Joker{}",
                'Has a {C:green}#1# in #2#{} chance to gain',
                'a "{C:purple}Rarer than Rare{}" tag at the {C:attention}end of the round',
                "Has a {C:green}#1# in #3#{} chance to lose {C:money}#4#${} per hand played"}

    },
    unlocked = true,
    blueprint_compat = true,
    rarity = 3,
    cost = 10,
    pools = {["BalatrezAddition"] = true},
    config = { extra = { tagodds = 6, moneyodds = 3, moneylost = 20}},
    atlas = "asblueprint",
    pos = { x = 0, y = 0 }, soul_pos = { x = 1, y = 0 },
    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local compatible = G.jokers.cards[1] and G.jokers.cards[1] ~= card and
                G.jokers.cards[1].config.center.blueprint_compat
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            return { vars = {
            G.GAME.probabilities.normal,
            card.ability.extra.tagodds,
            card.ability.extra.moneyodds,
            card.ability.extra.moneylost, colours = {HEX("a83283")}}, main_end = main_end }
        end
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers then
            if pseudorandom("tagroll") < G.GAME.probabilities.normal / card.ability.extra.tagodds then
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        add_tag(Tag('tag_mucho_rarerthanraretag'))
                        play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                        return true
                    end)
                }))
            end
        end
        if context.joker_main then
            if pseudorandom("tagroll") < G.GAME.probabilities.normal / card.ability.extra.moneyodds then
                return {dollars = -card.ability.extra.moneylost}
            end
        end
        local ret = SMODS.blueprint_effect(card, G.jokers.cards[pseudorandom("asblueprint",1, #G.jokers.cards)], context)
        if ret then
            ret.colour = G.C.RED
        end
        return ret
    end
}


SMODS.Joker{
    key = "quandingleV",
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_quandingleV",
            vars = {
                G.GAME.probabilities.normal,
                card.ability.extra.odds,
                colours = {
                    G.C.WHITE
                }
            }
        } end,
    atlas = 'atlas3', pos = {x = 2, y = 1},
    rarity = 3,
    cost = 8,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    config = { extra = { odds = 16}},

	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if pseudorandom("slowdown?") < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.SETTINGS.GAMESPEED = 0.5
            end
            if #context.scoring_hand > 1 then
                return {
                    mult_mod = mult ^ 1.03 - mult,
                    extra = { message = '^1.03 Mult', colour = G.C.DARK_EDITION }
                }
            end
        end
        if context.other_joker then
            if pseudorandom("slowdown?") < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.SETTINGS.GAMESPEED = 0.5
            end
            if #context.scoring_hand > 1 and #context.scoring_hand < 6 then
                return {
                    mult_mod = mult ^ 0.97 - mult,
                    extra = { message = '^0.97 Mult', colour = G.C.DARK_EDITION }
                }
            end
        end
	end

}

SMODS.Joker{
    key = "jeff",
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_jeff",
            vars = {
                G.GAME.probabilities.normal,
                card.ability.extra.odds,
                colours = {
                    G.C.WHITE
                }
            }
        } end,
    atlas = 'atlas3', pos = {x = 3, y = 1},
    rarity = 3,
    cost = 8,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    config = { extra = { odds = 8}},
    calculate = function(self, card, context)
        if context.joker_main and #context.scoring_hand == 3 and #G.play.cards == 3 and #G.jokers.cards == 3 and #G.consumeables.cards == 3 then
            return {
                    mult_mod = mult ^ 2 - mult,
                    extra = { message = '^3 Mult', colour = G.C.DARK_EDITION },
                    card:start_dissolve()
                }
        end
        if context.end_of_round and context.cardarea == G.jokers then
            if pseudorandom('jefftheguyoutprematurely') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    card_eval_status_text(card,'jokers',nil,nil,nil,{message = "Jeff the Guy Out"}),
                    card:start_dissolve()
                }
            end
        end
    end
}

SMODS.Atlas{
    key = 'twerkwdg',
    path = 'gastersprite.png',
    px = 106.5,
    py = 142.5,
}

SMODS.Sound{
    key = "music_gastertheme",
    path = "gasterfunkoverdrive.ogg",
    pitch = 0.7,
    volume = 0.5,
    select_music_track = function()
        if jokerExistsmucho("j_mucho_twerkwdg") and G.GAME.blind then
		    return true end
	end,
}

SMODS.Joker{
    key = "twerkwdg",
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_twerkwdg",
            vars = {
                G.GAME.probabilities.normal,
                colours = {
                }
            }
        } end,
    atlas = 'twerkwdg',
    rarity = 2,
    cost = 6,
    pools = {["BalatrezAddition"] = true},

    pixel_size = { w = 71 , h = 95 },
    frame = 0,

    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { odds = 3 }},

    calculate = function(self, card, context)
        if #G.hand.highlighted > 0 then
            explodeCard(card)
        end
    end
}

SMODS.Atlas{
    key = 'undyne',
    path = 'undyne.png',
    px = 173,
    py = 239,
}

SMODS.Sound{
    key = "music_undyne",
    path = "undyne_unused.ogg",
    pitch = 1,
    volume = 0.5,
    select_music_track = function()
        if jokerExistsmucho("j_mucho_undyne") and G.GAME.blind and G.GAME.blind:get_type() == 'Boss' then
		    return true end
	end,
}

SMODS.Sound{
    key = "snd_spear",
    path = "spearsound.ogg",
    pitch = 1,
    volume = 0.5,
}

SMODS.Joker{
    key = "undyne",
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_undyne",
            vars = {
                G.GAME.probabilities.normal,
                card.ability.extra.odds,
                colours = {
                }
            }
        } end,
    atlas = 'undyne',
    rarity = 2,
    cost = 5,
    pools = {["BalatrezAddition"] = true},

    pixel_size = { w = 71 , h = 95 },
    frame = 0,

    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { odds = 3 }},

    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom("spearofjustice") < G.GAME.probabilities.normal / card.ability.extra.odds and G.consumeables.config.card_limit > #G.consumeables.cards then
                G.E_MANAGER:add_event(Event({
                    delay = 0.1,
                    func = function()
                        SMODS.calculate_effect({message = "NGAHHH!!"}, card)
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    local card = create_card('Tarot', G.Consumeables, nil, nil, nil, nil, 'c_mucho_spear')
                    card.sell_cost = 0
                    play_sound('mucho_snd_spear', 1, 0.8)
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                end
            end
        end
    end
}

SMODS.Joker{
    key = "winggaster",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = "mucho_thecore", set = "Other"}
        return {
            key = "j_mucho_winggaster",
            vars = {
                card.ability.extra.status,
                colours = {
                }
            }
        } end,
    atlas = 'atlas3', pos = {x = 4, y = 1},
    rarity = "mucho_rarerthanrare",
    cost = 13,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { cancreate = true, status = "active" }},

    calculate = function(self, card, context)
        if context.joker_main then
            if #G.play.cards ~= #context.scoring_hand then
                card.ability.extra.cancreate = false
                card.ability.extra.status = "inactive"
            end
        end
        if context.end_of_round then
            if card.ability.extra.cancreate == true and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                local corechoice = pseudorandom("corechoice!", 1, 4)
                local counter = 0
                if corechoice == 1 then
                    SMODS.add_card { set = "Joker", area = G.jokers, skip_materialize = true, key = "j_mucho_core1", no_edition = true}
                    card.ability.extra.cancreate = false
                    counter = counter + 1
                    print("created core1, count: "..counter)
                elseif corechoice == 2 then
                    SMODS.add_card { set = "Joker", area = G.jokers, skip_materialize = true, key = "j_mucho_core2", no_edition = true}
                    card.ability.extra.cancreate = false
                    counter = counter + 1
                    print("created core2, count: "..counter)
                elseif corechoice == 3 then
                    SMODS.add_card { set = "Joker", area = G.jokers, skip_materialize = true, key = "j_mucho_core3", no_edition = true}
                    card.ability.extra.cancreate = false
                    counter = counter + 1
                    print("created core3, count: "..counter)
                elseif corechoice == 4 then
                    SMODS.add_card { set = "Joker", area = G.jokers, skip_materialize = true, key = "j_mucho_core4", no_edition = true}
                    card.ability.extra.cancreate = false
                    counter = counter + 1
                    print("created core4, count: "..counter)
                end
            end
        end
        if context.setting_blind then
            card.ability.extra.cancreate = true
            card.ability.extra.status = "active"
            local core1, core2, core3, core4 = next(SMODS.find_card("j_mucho_core1")), next(SMODS.find_card("j_mucho_core2")), next(SMODS.find_card("j_mucho_core3")), next(SMODS.find_card("j_mucho_core4"))
            if core1 then
                if core2 then
                    if core3 then
                        if core4 then
                            G.E_MANAGER:add_event(Event({
                                delay = 0.1,
                                func = function()
                                    card.children.center:set_sprite_pos({x = 4, y = 2})
                                    play_sound('mucho_mysterygo', 1, 0.8)
                                    card:juice_up(0.3, 0.5)
                                    return true
                                end
                            }))
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 3,
                                func = function()
                                    explodeCard(card)
                                    return true
                                end
                            }))
                        end
                    end
                end
            end
        end
    end
}


-- The CORE


SMODS.Joker{
    key = "core1",
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_core1",
            vars = {
                card.ability.extra.xxmult,
                colours = {
                }
            }
        } end,
    atlas = 'coreatlas', pos = {x = 0, y = 0},
    rarity = 3,
    cost = 9,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { chips = 100, xchips = 3 }},

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = 100
            }
        end
        if context.individual and context.cardarea == G.play then
            local core2, core3, core4 = next(SMODS.find_card("j_mucho_core2")), next(SMODS.find_card("j_mucho_core3")), next(SMODS.find_card("j_mucho_core4"))
            if core2 then
                if core3 then
                    if core4 then
                        return {
                            xchips = 3,
                        }
                    end
                end
            end
        end
    end
}

SMODS.Joker{
    key = "core2",
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_core2",
            vars = {
                card.ability.extra.xxmult,
                colours = {
                }
            }
        } end,
    atlas = 'coreatlas', pos = {x = 1, y = 0},
    rarity = 3,
    cost = 9,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = {  }},

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = 10
            }
        end
        if context.individual and context.cardarea == G.play then
            local core1, core3, core4 = next(SMODS.find_card("j_mucho_core1")), next(SMODS.find_card("j_mucho_core3")), next(SMODS.find_card("j_mucho_core4"))
            if core1 then
                if core3 then
                    if core4 then
                        return {
                            xmult = 2.5,
                        }
                    end
                end
            end
        end
    end
}

SMODS.Joker{
    key = "core3",
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_core3",
            vars = {
                card.ability.extra.xxmult,
                colours = {
                }
            }
        } end,
    atlas = 'coreatlas', pos = {x = 2, y = 0},
    rarity = 3,
    cost = 9,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { }},

    calc_dollar_bonus = function(self, card)
        return 6
    end,

    calculate = function(self, card, context)
        if context.joker_main or context.pre_discard then
            local core1, core2, core4 = next(SMODS.find_card("j_mucho_core1")), next(SMODS.find_card("j_mucho_core2")), next(SMODS.find_card("j_mucho_core4"))
            if core1 then
                if core2 then
                    if core4 then
                        G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + 10
                        return {
                            dollars = 10
                        }
                    end
                end
            end
        end
    end
}

SMODS.Joker{
    key = "core4",
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_core4",
            vars = {
                G.GAME.probabilities.normal,
                card.ability.extra.odds,
                colours = {
                }
            }
        } end,
    atlas = 'coreatlas', pos = {x = 3, y = 0},
    rarity = 3,
    cost = 9,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { odds = 3 }},

        calculate = function(self, card, context)
        if context.before then
            local core1, core2, core3 = next(SMODS.find_card("j_mucho_core1")), next(SMODS.find_card("j_mucho_core2")), next(SMODS.find_card("j_mucho_core3"))
            if core1 then
                if core2 then
                    if core3 then
                        return {
                            level_up = 3,
                            print("shouldve level'd up?")
                        }
                    end
                end
            end
        end
        if context.before then
            if pseudorandom("core4upgrade?") < G.GAME.probabilities.normal / card.ability.extra.odds then
                return { level_up = 1, print("shouldve level'd up (no full core ver.)") }
            end
        end
    end
}

SMODS.Joker{
    key = "perkeobudget",
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_perkeobudget",
            vars = {
                card.ability.extra.baseodds,
                card.ability.extra.odds,
                card.ability.extra.cost,
                colours = {
                }
            }
        } end,
    atlas = 'atlas3', pos = {x = 0, y = 2},
    rarity = 2,
    cost = 7,
    pools = {["BalatrezAddition"] = true},


    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { baseodds = 1, odds = 5, cost = 2, increase = 2 }},

    calc_dollar_bonus = function(self, card)
        return -card.ability.extra.cost
    end,

    calculate = function(self, card, context)
        if context.ending_shop and G.consumeables.cards[1] and pseudorandom("copy perkeobudget?") < card.ability.extra.baseodds / card.ability.extra.odds then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local card_to_copy, _ = pseudorandom_element(G.consumeables.cards, 'mucho_perkeobudget')
                    local copied_card = copy_card(card_to_copy)
                    copied_card:set_edition("e_negative", true)
                    copied_card:add_to_deck()
                    G.consumeables:emplace(copied_card)
                    return true
                end
            }))
            return { message = localize('k_duplicated_ex') }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and G.GAME.blind.boss then
            card.ability.extra.cost = card.ability.extra.cost + card.ability.extra.increase
            return {
                message = "Maintenance cost increased!"
            }
        end
    end
}

SMODS.Joker{
    key = "onemore",
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_onemore",
            vars = {
                G.GAME.probabilities.normal,
                card.ability.extra.odds,
                colours = {
                    HEX("5e5e5e")
                }
            }
        } end,
    atlas = 'atlas3', pos = {x = 1, y = 2},
    rarity = 2,
    cost = 2,
    pools = {["BalatrezAddition"] = true},


    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { cost = 999.99, odds = 3, homeless = false }},
    
    calc_dollar_bonus = function(self, card)
        if card.ability.extra.homeless == true then
            card.children.center:set_sprite_pos({x = 2, y = 2})
            return -card.ability.extra.cost
        end
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = 2
            }
        end
        if context.end_of_round and context.cardarea == G.jokers then
            if pseudorandom("homeless") < G.GAME.probabilities.normal / card.ability.extra.odds then
                card.ability.extra.homeless = true
            end
        end
    end
}

SMODS.Sound{
    key = "music_spamton",
    path = "spamton_battle.ogg",
    pitch = 1,
    volume = 0.5,
    select_music_track = function()
        if jokerExistsmucho("j_mucho_spamton") and G.GAME.blind then
		    return true end
	end,
}

SMODS.Joker{
    key = "spamton",
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_spamton",
            vars = {
                G.GAME.probabilities.normal,
                card.ability.extra.odds,
                colours = {
                    G.C.FILTER
                }
            }
        } end,
    atlas = 'atlas3', pos = {x = 3, y = 2},
    rarity = 2,
    cost = 2,
    pools = {["BalatrezAddition"] = true},


    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { odds = 10 }},

    calculate = function(self, card, context)
        if context.joker_main and pseudorandom("[[Hyperlink Blocked]]") < G.GAME.probabilities.normal / card.ability.extra.odds then
            SMODS.add_card{key = "c_mucho_thecure"}
        end
    end
}

SMODS.Joker{
    key = "spamton",
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_spamton",
            vars = {
                G.GAME.probabilities.normal,
                card.ability.extra.odds,
                colours = {
                    G.C.FILTER
                }
            }
        } end,
    atlas = 'atlas3', pos = {x = 3, y = 2},
    rarity = 2,
    cost = 2,
    pools = {["BalatrezAddition"] = true},


    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { odds = 10 }},

    calculate = function(self, card, context)
        if context.joker_main and pseudorandom("[[Hyperlink Blocked]]") < G.GAME.probabilities.normal / card.ability.extra.odds then
            SMODS.add_card{key = "c_mucho_thecure"}
        end
    end
}

SMODS.Joker{
    key = "weirdgamblerhead",
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_weirdgamblerhead",
            vars = {
                card.ability.extra.extraselect,
                G.GAME.probabilities.normal,
                card.ability.extra.odds,
                colours = {
                }
            }
        } end,
    atlas = 'atlas4', pos = {x = 0, y = 0},
    rarity = 2,
    cost = 8,
    pools = {["BalatrezAddition"] = true},


    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { extraselect = 1, odds = 10 }},
    
    add_to_deck = function(self, card, from_debuff)
        SMODS.change_play_limit(card.ability.extra.extraselect or self.config.extra.extraselect)
        SMODS.change_discard_limit(card.ability.extra.extraselect or self.config.extra.extraselect)
    end,

    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_play_limit(-card.ability.extra.extraselect or -self.config.extra.extraselect)
        SMODS.change_discard_limit(-card.ability.extra.extraselect or -self.config.extra.extraselect)
    end,

    calculate = function(self, card, context)
        if context.reroll_shop and pseudorandom("loseselection") < G.GAME.probabilities.normal / card.ability.extra.odds then
            SMODS.change_play_limit(-card.ability.extra.extraselect or -self.config.extra.extraselect)
            SMODS.change_discard_limit(-card.ability.extra.extraselect or -self.config.extra.extraselect)
            play_sound("mucho_glassbreak")
            card_eval_status_text(card,'jokers',nil,nil,nil,{message = "-1 card selection limit", colour = G.C.PURPLE})

        end
    end

}

SMODS.Joker{
    key = "fiveleg",
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_fiveleg",
            vars = {
                card.ability.extra.extraselect,
                card.ability.extra.cost,
                card.ability.extra.increase,
                colours = {
                }
            }
        } end,
    atlas = 'atlas4', pos = {x = 1, y = 0},
    rarity = 3,
    cost = 8,
    pools = {["BalatrezAddition"] = true},


    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { extraselect = 1, cost = 2, increase = 3 }},
    
    add_to_deck = function(self, card, from_debuff)
        SMODS.change_play_limit(card.ability.extra.extraselect or self.config.extra.extraselect)
        SMODS.change_discard_limit(card.ability.extra.extraselect or self.config.extra.extraselect)
    end,

    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_play_limit(-card.ability.extra.extraselect or -self.config.extra.extraselect)
        SMODS.change_discard_limit(-card.ability.extra.extraselect or -self.config.extra.extraselect)
    end,

    calc_dollar_bonus = function(self, card)
        return -card.ability.extra.cost
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and G.GAME.blind.boss then
            card.ability.extra.cost = card.ability.extra.cost + card.ability.extra.increase
            return {
                message = "Maintenance cost increased!"
            }
        end
    end
}

SMODS.Sound {
    key = "levelup", path = "levelup.ogg"
}

SMODS.Sound {
    key = "soulhurt", path = "soulhurt.ogg"
}


SMODS.Joker{
    key = "dumbassjoker",
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_dumbassjoker",
            vars = {
                card.ability.extra.odds1,
                card.ability.extra.odds2,
                card.ability.extra.extraselect,
                colours = {
                }
            }
        } end,
    atlas = 'atlas4', pos = {x = 2, y = 0},
    rarity = 3,
    cost = 9,
    pools = {["BalatrezAddition"] = true},


    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { extraselect = 1, odds1 = 1, odds2 = 4 }},

    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands['Straight Flush']) then
            if pseudorandom("royalflushcsl+1?") < card.ability.extra.odds1 / card.ability.extra.odds2 then
                SMODS.change_play_limit(card.ability.extra.extraselect or self.config.extra.extraselect)
                SMODS.change_discard_limit(card.ability.extra.extraselect or self.config.extra.extraselect)
                play_sound("mucho_levelup")
                card_eval_status_text(card,'jokers',nil,nil,nil,{message = "+1 card selection limit", colour = G.C.PURPLE})
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 3,
                    func = function()
                        explodeCard(card)
                        return true
                    end
                }))
            else
                play_sound("mucho_soulhurt")
                card_eval_status_text(card,'jokers',nil,nil,nil,{message = "...Nothing happened!", colour = G.C.PURPLE})
            end
        end
    end
}

SMODS.Joker{
    key = "investor",
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_investor",
            vars = {
                card.ability.extra.stockpiled
            }
        } end,
    atlas = 'atlas4', pos = {x = 3, y = 0},
    rarity = 3,
    cost = 9,
    pools = {["BalatrezAddition"] = true},


    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { stockpiled = 0 }},

    calculate = function(self, card, context)
        if next(SMODS.find_mod('Talisman')) then
            if context.final_scoring_step and G.GAME.current_round.hands_left > 0 then
                local pre_stockpile = hand_chips
                card.ability.extra.stockpiled = card.ability.extra.stockpiled + (hand_chips / 20)
                hand_chips = lenient_bignum(hand_chips/50)
                print("current hand chips: "..hand_chips)
                card_eval_status_text(card,'jokers',nil,nil,nil,{message = "Divided chips by 50", colour = G.C.CHIPS})
                return {
                    message = "Stockpiled "..pre_stockpile.." Chips!"
                }
            end
            if context.final_scoring_step and G.GAME.current_round.hands_left == 0 then
                return {
                    chips = lenient_bignum(hand_chips) * lenient_bignum(card.ability.extra.stockpiled) - lenient_bignum(hand_chips),
                    message = "X "..number_format(lenient_bignum(card.ability.extra.stockpiled)).." Chips"
                }
            end
            if context.end_of_round and context.cardarea == G.jokers or context.setting_blind then
                card.ability.extra.stockpiled = 0
            end
        else
            if context.final_scoring_step and G.GAME.current_round.hands_left > 0 then
               local pre_stockpile = hand_chips
                card.ability.extra.stockpiled = card.ability.extra.stockpiled + (hand_chips / 20)
                hand_chips = hand_chips/50
                print("current hand chips: "..hand_chips)
                card_eval_status_text(card,'jokers',nil,nil,nil,{message = "Divided chips by 50", colour = G.C.CHIPS})
                return {
                    message = "Stockpiled "..pre_stockpile.." Chips!"
                }
            end
            if context.final_scoring_step and G.GAME.current_round.hands_left == 0 then
                return {
                    chips = hand_chips * card.ability.extra.stockpiled - hand_chips,
                    message = "X "..card.ability.extra.stockpiled.." Chips"
                }
            end
            if context.end_of_round and context.cardarea == G.jokers or context.setting_blind then
                card.ability.extra.stockpiled = 0
            end
        end
    end
}

SMODS.Joker{
    key = "xchipsjoker",
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_xchipsjoker",
            vars = {
            }
        } end,
    atlas = 'atlas4', pos = {x = 4, y = 0},
    rarity = 1,
    cost = 3,
    pools = {["BalatrezAddition"] = true},


    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { stockpiled = 0 }},

    calculate = function(self, card, context)
        if next(SMODS.find_mod('Talisman')) then
            if context.joker_main then
                return {
                    chips = lenient_bignum(hand_chips * 2) - lenient_bignum(hand_chips)
                }
            end
        else
            if context.joker_main then
                return {
                    chips = hand_chips * 2 - hand_chips
                }
            end
        end
    end
}

SMODS.Joker{
    key = "boosted_xchipsjoker",
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_boosted_xchipsjoker",
            vars = {
                card.ability.extra.xchipsgain,
                card.ability.extra.xchips
            }
        } end,
    atlas = 'atlas4', pos = {x = 0, y = 1},
    rarity = 2,
    cost = 6,
    pools = {["BalatrezAddition"] = true},


    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { xchipsgain = 0.25, xchips = 1 }},

    calculate = function(self, card, context)
        if next(SMODS.find_mod('Talisman')) then
            if context.joker_main then
                return {
                    chips = lenient_bignum(hand_chips * card.ability.extra.xchips) - lenient_bignum(hand_chips)
                }
            end
            if context.remove_playing_cards then
                card.ability.extra.xchips = lenient_bignum(card.ability.extra.xchips + (#context.removed * card.ability.extra.xchipsgain))
                return {message = "X"..number_format(lenient_bignum(card.ability.extra.xchips)).." Chips"}
            end
        else
            if context.joker_main then
                return {
                    chips = hand_chips * card.ability.extra.xchips - hand_chips
                }
            end
            if context.remove_playing_cards then
                card.ability.extra.xchips = card.ability.extra.xchips + (#context.removed * card.ability.extra.xchipsgain)
                return {message = "X"..card.ability.extra.xchips.." Chips"}
            end
        end
    end
}




SMODS.Joker {
    key = "scroll",
    config = { extra = {xmult = 0.25, suit = 'Spades'}, },
    blueprint_compat = true,
    pos = { x = 1, y = 1 },
    atlas = "atlas4",
    rarity = 3,
    pools = {["BalatrezAddition"] = true},
    cost = 14,
    loc_vars = function(self, info_queue, card)
        local suit = card.ability.extra.suit or 'Spades'
        return { vars = { card.ability.extra.xmult, localize(suit, 'suits_singular'), colours = { G.C.SUITS[suit] } } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then
            context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult or 0
            context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult + card.ability.extra.xmult
            return {
                extra = { message = '+X0.5 Mult', colour = G.C.MULT },
                card = card
            }
        end
        if context.end_of_round and context.cardarea == G.jokers then
            card.ability.extra.suit = card.ability.extra.suit or 'Spades'
            local ancient_suits = {}
            if BalatrezModConfig.bltrz_x_freaky then
                if next(SMODS.find_mod('freakylatro')) then
                    for k, v in ipairs({ 'Spades', 'Hearts', 'Clubs', 'Diamonds', 'mucho_leaves', 'freaky_mustards' }) do
                        if v ~= card.ability.extra.suit then ancient_suits[#ancient_suits + 1] = v end
                    end
                end
            else
                for k, v in ipairs({ 'Spades', 'Hearts', 'Clubs', 'Diamonds', 'mucho_leaves' }) do
                    if v ~= card.ability.extra.suit then ancient_suits[#ancient_suits + 1] = v end
                end
            end
            local ancient_card = pseudorandom_element(ancient_suits, 'mucho_ancient' .. G.GAME.round_resets.ante)
            card.ability.extra.suit = ancient_card
        end
    end
}

SMODS.Joker{
    key = "tagmaster",

    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_tagmaster",
            vars = { G.GAME.probabilities.normal, card.ability.extra.odds }
        }
    end,

    atlas = 'atlas4', pos = {x = 2, y = 2},
    rarity = 2,
    cost = 7,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { odds = 6 }},

    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + 1
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost - 1
    end,


    calculate = function(self, card, context)
        if context.reroll_shop and pseudorandom("randomtag?") < G.GAME.probabilities.normal / card.ability.extra.odds then
            G.E_MANAGER:add_event(Event({
                func = function()
                    Mucho.add_random_tag()
                    return true
                end
            }))
            return {
                extra = { message = "Tag created!", colour = G.C.FILTER}
            }
        end
    end
}


--[[MuchoNumberRank = 7
MuchoFaceRank = 13

 SMODS.Joker {
    key = 'equality',
    config = { extra = { chips = 0, chip_gain = 10 } },
    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_crypticjoker",
            vars = {
                localize("mucho_"..MuchoNumberRank, 'ranks'),
                localize("mucho_"..MuchoFaceRank, 'ranks'),
            }
        } end,
    rarity = 3,
    atlas = 'atlas4',
    pos = { x = 2, y = 1 },
    cost = 12,
  
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      

    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers then
            MuchoNumberRank = math.floor(pseudorandom("number_rank", 2, 13))
            MuchoFaceRank = math.floor(pseudorandom("number_rank", 2, 13))
        end
    end
}]]--

SMODS.Joker{
    key = "tutorialvideo",

    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_tutorialvideo",
            vars = { card.ability.extra.multper, card.ability.extra.multper * (G.jokers and #G.jokers.cards or 0) }
        }
    end,

    atlas = 'atlas4', pos = {x = 3, y = 1}, soul_pos = {x = 5, y = 2},
    rarity = "mucho_exceptional",
    cost = 25,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { multper = 0.6}},

    calculate = function(self, card, context)
        if next(SMODS.find_mod("Talisman")) then
            if context.joker_main then
                print (mult, card.ability.extra.multper, #G.jokers.cards, mult ^ lenient_bignum(((card.ability.extra.multper-1) * #G.jokers.cards)))
                card_eval_status_text(card,'jokers',nil,nil,nil,{message = "Balatro Beginner's Guide"})
                love.system.openURL("https://www.youtube.com/watch?v=cqtsUX38HmE&ab_channel=GothicLordUK")
                return {
                    xmult = lenient_bignum(mult ^ ((card.ability.extra.multper) * #G.jokers.cards-1))
                }
                
            end
        else
            if context.joker_main then
                print (mult, card.ability.extra.multper, #G.jokers.cards, mult ^ ((card.ability.extra.multper-1) * #G.jokers.cards))
                card_eval_status_text(card,'jokers',nil,nil,nil,{message = "Balatro Beginner's Guide"})
                love.system.openURL("https://www.youtube.com/watch?v=cqtsUX38HmE&ab_channel=GothicLordUK")
                return {
                    xmult = mult ^ ((card.ability.extra.multper) * #G.jokers.cards-1)
                }
                
            end
        end
    end
}

SMODS.Joker{
    key = "multspread",

    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_multspread",
            vars = { card.ability.extra.multper, card.ability.extra.exmult, colours = {HEX("a83283")} }
        }
    end,

    atlas = 'atlas4', pos = {x = 4, y = 1}, soul_pos = {x = 5, y = 2},
    rarity = "mucho_exceptional",
    cost = 25,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { multper = 0.15, exmult = 1}},

    calculate = function(self, card, context)
        if next(SMODS.find_mod("Talisman")) then
            if context.other_joker and (context.other_joker.config.center.rarity == "mucho_rarerthanrare" or context.other_joker.config.center.rarity == "Rarer than Rare") then
               card.ability.extra.exmult = card.ability.extra.exmult + card.ability.extra.multper
               card_eval_status_text(card,'jokers',nil,nil,nil,{message = "Upgrade!", colour = G.C.GREEN})
            end
            if context.joker_main and lenient_bignum(card.ability.extra.exmult) > lenient_bignum(1) then
                return {
                    Xmult_mod = lenient_bignum(mult ^ (card.ability.extra.exmult-1)),
				    extra = { message = "^"..card.ability.extra.exmult.." Mult", colour = G.C.DARK_EDITION}
                }
            end
        else
            if context.other_joker and (context.other_joker.config.center.rarity == "mucho_rarerthanrare" or context.other_joker.config.center.rarity == "Rarer than Rare") then
               card.ability.extra.exmult = card.ability.extra.exmult + card.ability.extra.multper
               card_eval_status_text(card,'jokers',nil,nil,nil,{message = "Upgrade!", colour = G.C.GREEN})
            end
            if context.joker_main and card.ability.extra.exmult > 1 then
                return {
                    Xmult_mod = mult ^ (card.ability.extra.exmult-1),
				    extra = { message = "^"..card.ability.extra.exmult.." Mult", colour = G.C.DARK_EDITION}
                }
            end
        end
    end
}

SMODS.Joker{
    key = "spamtonneo",

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 2] = G.P_CENTERS.c_mucho_pipis
        return {
            key = "j_mucho_spamtonneo",
            vars = { 
                card.ability.extra.multper,
                card.ability.extra.exmult,
                G.GAME.probabilities.normal,
                card.ability.extra.odds,
                colours = {} }
        }
    end,

    atlas = 'atlas4', pos = {x = 4, y = 2}, soul_pos = {x = 5, y = 2},
    rarity = "mucho_exceptional",
    cost = 25,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = {multper = 0.08, exmult = 1, odds = 15}},

    calculate = function(self, card, context)
        if next(SMODS.find_mod("Talisman")) then
            if context.hand_drawn or context.skip_blind or context.playing_card_added or context.reroll_shop or context.selling_card or context.buying_card or context.open_booster or context.pre_discard or context.remove_playing_cards or context.debuffed_hand and context.cardarea == G.play or context.end_of_round and context.cardarea == G.jokers or context.setting_blind or context.buying_card or context.ending_shop or context.hand_drawn or context.skip_blind then
                if pseudorandom("negative pipis?") < G.GAME.probabilities.normal / card.ability.extra.odds then
                    SMODS.add_card{key = "c_mucho_pipis", edition = "e_negative"}
                end
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    SMODS.add_card{key = "c_mucho_pipis"}
                end
            end
            if context.joker_main and card.ability.extra.exmult > 1 then
                return {
                    Xmult_mod = lenient_bignum(mult ^ (card.ability.extra.exmult-1)),
				    extra = { message = "^"..number_format(lenient_bignum(card.ability.extra.exmult)).." Mult", colour = G.C.DARK_EDITION}
                }
            end
            if context.using_consumeable and context.consumeable.config.center.key == 'c_mucho_pipis' then
                card.ability.extra.exmult = number_format(lenient_bignum(card.ability.extra.exmult)) + card.ability.extra.multper
                card_eval_status_text(card,'jokers',nil,nil,nil,{message = "Upgrade!", colour = G.C.GREEN})
            end

        else
            if context.hand_drawn or context.skip_blind or context.playing_card_added or context.reroll_shop or context.selling_card or context.buying_card or context.open_booster or context.pre_discard or context.remove_playing_cards or context.debuffed_hand and context.cardarea == G.play or context.end_of_round and context.cardarea == G.jokers or context.setting_blind or context.buying_card or context.ending_shop or context.hand_drawn or context.skip_blind then
                if pseudorandom("negative pipis?") < G.GAME.probabilities.normal / card.ability.extra.odds then
                    SMODS.add_card{key = "c_mucho_pipis", edition = "e_negative"}
                end
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    SMODS.add_card{key = "c_mucho_pipis"}
                end
            end
            if context.joker_main and card.ability.extra.exmult > 1 then
                return {
                    Xmult_mod = mult ^ (card.ability.extra.exmult-1),
				    extra = { message = "^"..card.ability.extra.exmult.." Mult", colour = G.C.DARK_EDITION}
                }
            end
            if context.using_consumeable and context.consumeable.config.center.key == 'c_mucho_pipis' then
                card.ability.extra.exmult = card.ability.extra.exmult + card.ability.extra.multper
                card_eval_status_text(card,'jokers',nil,nil,nil,{message = "Upgrade!", colour = G.C.GREEN})
            end
        end
    end
}

SMODS.Joker{
    key = "djmustard",

    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_djmustard",
            vars = { 
                card.ability.extra.multper,
                card.ability.extra.odds2,
                card.ability.extra.odds,
                card.ability.extra.exmult,
                colours = {} }
        }
    end,

    atlas = 'atlas4', pos = {x = 0, y = 2}, soul_pos = {x = 5, y = 2},
    rarity = "mucho_exceptional",
    cost = 25,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = {exmult = 1, multper = 0.5, odds2 = 1, odds = 5}},

    calculate = function(self, card, context)
        if next(SMODS.find_mod("Talisman")) then
            if context.other_joker and context.other_joker.config.center.key ~= "j_mucho_djmustard" and context.other_joker.debuff == false and context.other_joker.ability.verifiedmustard ~= true then
                if pseudorandom("debuffdjmustard") < card.ability.extra.odds2 / card.ability.extra.odds then
                    card.ability.extra.exmult = card.ability.extra.exmult + card.ability.extra.multper
                    SMODS.debuff_card(context.other_joker, true, "source")
                    card_eval_status_text(context.other_joker,'jokers',nil,nil,nil,{message = "Mustard!", colour = G.C.RED})
                    card_eval_status_text(card,'jokers',nil,nil,nil,{message = "Upgrade!", colour = G.C.GREEN})
                else
                    card_eval_status_text(context.other_joker,'jokers',nil,nil,nil,{message = "Safe!", colour = G.C.BLUE})
                end
                context.other_joker.ability.verifiedmustard = true
            end
            if context.joker_main and lenient_bignum(card.ability.extra.exmult) > lenient_bignum(1) then
                return {
                    Xmult_mod = lenient_bignum(mult ^ (card.ability.extra.exmult-1)),
				    extra = { message = "^"..number_format(lenient_bignum(card.ability.extra.exmult)).." Mult", colour = G.C.DARK_EDITION }
                }
            end
        else
        end
    end
}

SMODS.Sound {
    key = "snd_jackenstein",
    path = "snd_jackenstein.ogg"
}

SMODS.Joker{
    key = "jackenstein",

    loc_vars = function(self, info_queue, card)
        return {
            key = "j_mucho_jackenstein",
            vars = { G.GAME.probabilities.normal, card.ability.extra.odds, card.ability.extra.multper, card.ability.extra.exmult }
        }
    end,

    atlas = 'atlas4', pos = {x = 1, y = 2}, soul_pos = {x = 5, y = 2},
    rarity = "mucho_exceptional",
    cost = 25,
    pools = {["BalatrezAddition"] = true},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { multper = 0.2, exmult = 1, odds = 160000}},

    update = function(self, card, dt)
        if next(SMODS.find_card("j_mucho_jackenstein")) then
            if pseudorandom("YOUR TAKING TOO LONG") < G.GAME.probabilities.normal / card.ability.extra.odds then
                card_eval_status_text(card,'jokers',nil,nil,nil,{message = "YOUR TAKING TOO LONG", colour = G.C.BLACK})
                card.ability.extra.exmult = lenient_bignum(card.ability.extra.exmult) + lenient_bignum(card.ability.extra.multper)
                play_sound("mucho_snd_jackenstein")
            end
        end
    end,

    calculate = function(self, card, context)
        if next(SMODS.find_mod("Talisman")) then
            if context.joker_main then
                return {
                    xmult = lenient_bignum(mult ^ (card.ability.extra.exmult - 1)),
                    extra = { message = "^"..lenient_bignum(card.ability.extra.exmult).." Mult", colour = G.C.DARK_EDITION }
                }
                
            end
        else
            if context.joker_main then
                return {
                    xmult = mult ^ (card.ability.extra.exmult - 1),
                    extra = { message = "^"..card.ability.extra.exmult.." Mult", colour = G.C.DARK_EDITION }
                }
                
            end
        end
    end
}

-- TODO LIST:




function jokerExistsmucho(abilityname)
    local _check = false
    if G.jokers and G.jokers.cards then
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.name == abilityname then _check = true end
        end
    end
    return _check
end



function decrementingTickEventmucho(type,tick)
    if type == "G.effectmanager" then
        for i = 1, #G.effectmanager do
            if G.effectmanager[i] and G.effectmanager[i][1] then
                if G.effectmanager[i][1].duration ~= nil and G.effectmanager[i][1].duration >= -1 then
                    _eff = G.effectmanager[i][1]

                    _eff.tfps = _eff.tfps + 1
                    _eff.duration = _eff.duration - 1
                    
                    if _eff.tfps > 100/_eff.fps and _eff.fps ~= 0 then
                        _eff.frame = _eff.frame + 1
                        _eff.tfps = 0  
                    end
                    if _eff.frame > _eff.maxframe then
                        _eff.frame = 1
                    end
            
        
                

                elseif G.effectmanager[i][1].duration ~= nil and G.effectmanager[i][1].duration <= 0 then
                    G.effectmanager[i] = nil
                end
            end
        end
    end

    if type == "j_mucho_thechuds" then
        if math.fmod(Mucho.ticks,10) == 0 then
            local _subcardcenter = G.P_CENTERS.j_mucho_thechuds
            _subcardcenter.frame = _subcardcenter.frame + 1
            local _fr = _subcardcenter.frame
            _subcardcenter.pos.x = math.fmod(_fr,6)
            _subcardcenter.pos.y = math.floor(_fr/6)
            if _subcardcenter.frame > 148 then _subcardcenter.frame = 0 end
        end
    end
    if type == "j_mucho_mustardshocked" then
        if math.fmod(Mucho.ticks,4) == 0 then
            local _subcardcenter = G.P_CENTERS.j_mucho_mustardshocked
            _subcardcenter.frame = _subcardcenter.frame + 1
            local _fr = _subcardcenter.frame
            _subcardcenter.pos.x = math.fmod(_fr,5)
            _subcardcenter.pos.y = math.floor(_fr/5)
            if _subcardcenter.frame > 48 then _subcardcenter.frame = 0 end
        end
    end
    if type == "j_mucho_twerkwdg" then
        if math.fmod(Mucho.ticks,2) == 0 then
            local _subcardcenter = G.P_CENTERS.j_mucho_twerkwdg
            _subcardcenter.frame = _subcardcenter.frame + 1
            local _fr = _subcardcenter.frame
            _subcardcenter.pos.x = math.fmod(_fr,13)
            _subcardcenter.pos.y = math.floor(_fr/13)
            if _subcardcenter.frame > 37 then _subcardcenter.frame = 0 end
        end
    end
    if type == "j_mucho_undyne" then
        if math.fmod(Mucho.ticks,4) == 0 then
            local _subcardcenter = G.P_CENTERS.j_mucho_undyne
            _subcardcenter.frame = _subcardcenter.frame + 1
            local _fr = _subcardcenter.frame
            _subcardcenter.pos.x = math.fmod(_fr,29)
            _subcardcenter.pos.y = math.floor(_fr/29)
            if _subcardcenter.frame > 27 then _subcardcenter.frame = 0 end
        end
    end
end

local upd = Game.update
function Game:update(dt)
    upd(self, dt)

    -- tick based events
    if Mucho.ticks == nil then Mucho.ticks = 0 end
    if Mucho.dtcounter == nil then Mucho.dtcounter = 0 end
    Mucho.dtcounter = Mucho.dtcounter+dt
    Mucho.dt = dt

    while Mucho.dtcounter >= 0.010 do
        Mucho.ticks = Mucho.ticks + 1
        Mucho.dtcounter = Mucho.dtcounter - 0.010
        if jokerExistsmucho("j_mucho_thechuds") then decrementingTickEventmucho("j_mucho_thechuds",0) end
        if jokerExistsmucho("j_mucho_mustardshocked") then decrementingTickEventmucho("j_mucho_mustardshocked",0) end
        if jokerExistsmucho("j_mucho_twerkwdg") then decrementingTickEventmucho("j_mucho_twerkwdg",0) end
        if jokerExistsmucho("j_mucho_undyne") then decrementingTickEventmucho("j_mucho_undyne",0) end
    end

    if G.showsomething and G.showsomething > 0 then G.showsomething = G.showsomething - 1 end
    if #G.effectmanager > 0 then decrementingTickEventmucho("G.effectmanager",0) end


    if next(SMODS.find_card("j_mucho_crypticjoker")) then
        local Getid_old = Card.get_id
        function Card:get_id()
            local ret = Getid_old(self)
            if ret >= 2 and ret <= 10 then ret = MuchoNumberRank
            elseif ret >= 11 and ret <= 13 or next(SMODS.find_card("j_pareidolia")) then ret = MuchoFaceRank end
            return ret
        end
    end
    if G.GAME.muchohandgain == nil then
        G.GAME.muchohandgain = 1
    end
end



-- functions to draw elements on the screen (i.e. Yahimod's Cantaloupe) (also thanks yahimod for the code, once again!!)

local drawhook = love.draw
function love.draw()
    drawhook()
    local _xscale = love.graphics.getWidth()/1920
    local _yscale = love.graphics.getHeight()/1080
    

    function loadThatMuchoImage(fn)
        local full_path = (Mucho.path .. "customimages/" .. fn)
        local file_data = assert(NFS.newFileData(full_path),("Epic fail"))
        local tempimagedata = assert(love.image.newImageData(file_data),("Epic fail 2"))
        --print ("LTFNI: Successfully loaded " .. fn)
        return (assert(love.graphics.newImage(tempimagedata),("Epic fail 3")))
    end

    function loadThatMuchoImageSpritesheet(fn,px,py,subimg,orientation)
        local full_path = (Mucho.path 
        .. "customimages/" .. fn)
        local file_data = assert(NFS.newFileData(full_path),("Epic fail"))
        local tempimagedata = assert(love.image.newImageData(file_data),("Epic fail 2"))

        local tempimg = assert(love.graphics.newImage(tempimagedata),("Epic fail 3"))

        local spritesheet = {}
        for i = 1, subimg do
            if orientation == 0 then -- 0 = downwards spritesheet
                table.insert(spritesheet,love.graphics.newQuad(0, (i-1)*py, px, py, tempimg))
            end
            if orientation == 1 then -- 1 = rightwards spritesheet
                table.insert(spritesheet,love.graphics.newQuad((i-1)*px, 0, px, py, tempimg))
            end
        end
        --print ("LTFNIS: Successfully loaded spritesheet " .. fn)

        return (spritesheet)
    end


    if G.showsomething and (G.showsomething > 0) then
        if Mucho.something == nil then Mucho.something = loadThatMuchoImage("something.png") end
        love.graphics.setColor(1, 1, 1, 0.1) 
        love.graphics.draw(Mucho.something, 0*_xscale, 0*_yscale,0,_xscale,_yscale)
    end

    if G.effectmanager then
        
        --print("Effect manager has "..#G.effectmanager)
        for i = 1, #G.effectmanager do
            local _xscale = love.graphics.getWidth()/1920
            local _yscale = love.graphics.getHeight()/1080
            --print("G.effectmanager[i].name".. G.effectmanager[i][1].name)
            if G.effectmanager[i] ~= nil then
                if G.effectmanager[i][1].name == "explosion" then
                    if Mucho.imageexplosion == nil then Mucho.imageexplosion = loadThatMuchoImage("explosiongif.png") end
                    if Mucho.imageexplosionsprite == nil then Mucho.imageexplosionsprite = loadThatMuchoImageSpritesheet("explosiongif.png",200,282,17,0) end
                    imagetodraw = Mucho.imageexplosion
                    quadtodraw = Mucho.imageexplosionsprite
                    _imgindex = G.effectmanager[i][1].frame
                    _xpos = G.effectmanager[i][1].xpos-(200/2)
                    _ypos = G.effectmanager[i][1].ypos-(282/2)
                    --print("_imgindex".. _imgindex)
                    love.graphics.setColor(1, 1, 1, 1)
                end
                love.graphics.draw(imagetodraw, quadtodraw[_imgindex], _xpos, _ypos, 0 ,_xscale,_yscale)
            end
        end
    end
end

SMODS.Sound({key = "glassbreak", path = "glassbreak.ogg",})
SMODS.Sound({key = "snd_explosion", path = "snd_explosion.ogg",})

function explodeCard(card)
    play_sound("mucho_glassbreak")
    playEffect("explosion",card.tilt_var.mx,card.tilt_var.my)
    card:start_dissolve()
    card = nil
end


function playEffect(effect,posx,posy)
    if effect == "explosion" then
        play_sound("mucho_snd_explosion")
        neweffect = 
            {
            name = "explosion",
            duration = 100,

            frame = 1,
            maxframe = 17,
            fps = 20,
            tfps = 0, -- ticks per frame per second


            xpos = posx,
            ypos = posy,
            xvel = 0,
            yvel = 0,
            }end

    if effect == "cardexplosion" then
        neweffect = 
            {
            name = "crack",
            duration = 200,

            frame = 1,
            maxframe = 1,
            fps = 0,
            tfps = 0, -- ticks per frame per second


            xpos = posx,
            ypos = posy,
            xvel = 0,
            yvel = 0,
            }end
    table.insert(G.effectmanager,{neweffect})
end
