SMODS.PokerHand {
    key = "kingandjester",
    chips = 30,
    mult = 2,
    l_chips = 15,
    l_mult = 1.5,
    example = {
        {'mucho_L_K', true},
        {'D_mucho_T', true},
        {'C_mucho_T', true}
    },
    loc_txt = {
        name = "The King and his Jesters",
        description = {
            "A king of any suit and two Troubadours",
            "of any suit. They cannot be played with",
            "any other unscored cards."
        }
    },
    visible = false,

    evaluate = function(parts, hand)
        if #hand == 3 then
            local _hask = false
            local _hast = false
            local _hast2 = false
            local eligible_cards = {}
            local other_hands = next(parts._flush) or next(parts._straight)

            for i, card in ipairs(hand) do
                if card:get_id() == 13 and _hask == false then
                    _hask = true
                    eligible_cards[#eligible_cards + 1] = card
                end
                if card:get_id() == 15 and _hast == false then
                    _hast = true
                    eligible_cards[#eligible_cards + 1] = card

                elseif card:get_id() == 15 and _hast == true then
                    _hast2 = true
                    eligible_cards[#eligible_cards + 1] = card
                end
            end

            if _hask and _hast and _hast2 and not other_hands then
                return { eligible_cards }
            end
        end

    end,

    modify_display_text = function(self, cards, scoring_hand)
        return mucho_pkrhands_KT
        --TODO : implement text change & score the troubadour when playing hand (currently scores the king only)
    end
}