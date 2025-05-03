// TODO: make this work
// only allow selecting honest hand if a honest hand is possible
for (var i = 0; i < ds_list_size(global.player1.my_cards); i++) {
    var card = ds_list_find_value(global.player1.my_cards, i);
    // WARNING: gamemaker is literally just wrong with ds_list_find_index
    if ((ds_list_find_index(global.pile, card) == -1) and (validate_stack(card.card_id, global.supposed_top))) {
        playable = true;
        break;
    }
}