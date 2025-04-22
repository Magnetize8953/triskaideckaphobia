// Destroy card objets in the pot
while (instance_place(room_width / 2, room_height / 2, obj_Card) != noone) {
	instance_destroy(instance_place(room_width / 2, room_height / 2, obj_Card));
}

// Reset the log of card objects associated with this player
for (i = 0; i < ds_list_size(self.my_cards); i++) {
	instance_destroy(ds_list_find_value(self.my_cards, i));
}
ds_list_clear(self.my_cards);

var holder = self; // For the sake of using "self" within structs
if (num == 1) {
    for (i = 0; i < 13; i++) {
        _card = ds_list_find_value(hand, i); // an integer corresponding to the card id
        _card_sprite_width = sprite_get_width(spr_Cards) * 0.25;
        _y_position = room_height - (sprite_get_height / 7);
        _x_position = i * (_card_sprite_width - 35) + (_card_sprite_width);
		// create the card, and add it to the list of card objects
        ds_list_add(my_cards, instance_create_layer(_x_position, _y_position, "Instances", obj_Card, { card_id: _card , rotation: 0, scale: 0.18, associated_player: holder}));
    }
} else if (num == 2) {
	for (i = 0; i < 13; i++) {
        _card = ds_list_find_value(hand, i); // an integer corresponding to the card id
        _card_sprite_width = sprite_get_width(spr_Cards) * 0.25;
		_x_position = 0 + (sprite_get_height / 7);
        _y_position = i * (_card_sprite_width * 0.27) + (_card_sprite_width);
		// create the card, and add it to the list of card objects
        ds_list_add(my_cards, instance_create_layer(_x_position, _y_position, "Instances", obj_Card, { card_id: _card, rotation: 90, scale:0.11, associated_player: holder}));
    }
} else if (num == 3) {
	for (i = 0; i < 13; i++) {
        _card = ds_list_find_value(hand, i); // an integer corresponding to the card id
        _card_sprite_width = sprite_get_width(spr_Cards) * 0.25;
		_x_position = room_width - (sprite_get_height / 7);
        _y_position = i * (_card_sprite_width * 0.27) + (_card_sprite_width);
		// create the card, and add it to the list of card objects
        ds_list_add(my_cards, instance_create_layer(_x_position, _y_position, "Instances", obj_Card, { card_id: _card, rotation: 270, scale:0.11, associated_player: holder}));
    }
} 

