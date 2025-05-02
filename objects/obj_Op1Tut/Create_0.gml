holder = self;
my_cards = ds_list_create();

for (i = 0; i < 13; i++) {
    _card = ds_list_find_value(hand, i); // an integer corresponding to the card id
    _card_sprite_width = sprite_get_width(spr_Cards) * 0.25;
	_x_position = 0 + (sprite_get_height / 7);
    _y_position = i * (_card_sprite_width * 0.27) + (_card_sprite_width);
    // create the card, and add it to the list of card objects
    card_made = instance_create_layer(_x_position, _y_position, "Instances", obj_Card, { card_id: _card, rotation: 90, scale:0.22, associated_player: holder});
    ds_list_add(my_cards, card_made);
	card_made.image_index = 0;
	card_made.face_down = true;
}

//dummy test
alarm[0] = 1;