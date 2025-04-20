show_debug_message("Creating player " + string(num) + "...");
// TODO: create positions for player 2, 3 on game level
if (num == 1) {
    for (i = 0; i < 13; i++) {
        _card = ds_list_find_value(hand, i); // an integer corresponding to the card id
        _card_sprite_width = sprite_get_width(spr_Cards) * 0.25;
        _y_position = room_height - (room_height / 4);
        _x_position = i * (_card_sprite_width - 35) + (_card_sprite_width);
        instance_create_layer(_x_position, _y_position, "Instances", obj_Card, { card_id: _card });
    }
}