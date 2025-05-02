// Destroy card objets in the pot
while (instance_place(room_width / 2, room_height / 2, obj_Card) != noone) {
	instance_destroy(instance_place(room_width / 2, room_height / 2, obj_Card));
}

// Reset the log of card objects associated with this player
for (i = ds_list_size(self.my_cards) - 1; i > -1; i--) {
	instance_destroy(ds_list_find_value(self.my_cards, i));
}
ds_list_clear(self.my_cards);

var holder = self; // For the sake of using "self" within structs
if (num == 1) {
    for (i = 0; i < 13; i++) {
        _card = ds_list_find_value(hand, i); // an integer corresponding to the card id
        _card_sprite_width = sprite_get_width(spr_Cards) * 0.25;
        _y_position = room_height - (sprite_get_height / 7);
        _x_position = (i+1.5) * (_card_sprite_width);
		// create the card, and add it to the list of card objects
        ds_list_add(my_cards, instance_create_layer(_x_position, _y_position, "Instances", obj_Card, { card_id: _card , rotation: 0, scale: 0.3, associated_player: holder}));
    }
} else if (num == 2) {
	for (i = 0; i < 13; i++) {
        _card = ds_list_find_value(hand, i); // an integer corresponding to the card id
        _card_sprite_width = sprite_get_width(spr_Cards) * 0.25;
		_x_position = 0 + (sprite_get_height / 7);
        _y_position = i * (_card_sprite_width * 0.27) + (_card_sprite_width);
		// create the card, and add it to the list of card objects
        var new_card = instance_create_layer(_x_position, _y_position, "Instances", obj_Card, { card_id: _card , rotation: 90, scale: 0.22, associated_player: holder});
        new_card.image_index = 0;
        new_card.face_down = true;
        ds_list_add(my_cards, new_card);
    }
} else if (num == 3) {
	for (i = 0; i < 13; i++) {
        _card = ds_list_find_value(hand, i); // an integer corresponding to the card id
        _card_sprite_width = sprite_get_width(spr_Cards) * 0.25;
		_x_position = room_width - (sprite_get_height / 7);
        _y_position = i * (_card_sprite_width * 0.27) + (_card_sprite_width);
		// create the card, and add it to the list of card objects
        var new_card = instance_create_layer(_x_position, _y_position, "Instances", obj_Card, { card_id: _card , rotation: 270, scale: 0.22, associated_player: holder});
        new_card.image_index = 0;
        new_card.face_down = true;
        ds_list_add(my_cards, new_card);
    }
}