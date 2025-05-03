var card_5 = ds_list_find_value(my_cards, ds_list_find_index(hand, 18));
var card_61 = ds_list_find_value(my_cards, ds_list_find_index(hand, 19));
var card_62 = ds_list_find_value(my_cards, ds_list_find_index(hand, 45));

var cards_to_move = [card_5, card_61, card_62];

for (var i = 0; i < array_length(cards_to_move); i++){
	var next_card = cards_to_move[i];
	next_card.face_down = false;
	next_card.image_index = next_card.card_id;
    next_card.new_x = room_width / 2;
	next_card.new_y = room_height / 2;
	next_card.move_speed = 19 + 1/(i-3);
	next_card.move_wait = i;
	next_card.alarm[3] = 1;
		
	next_card.image_xscale = global.stack_scale;
    next_card.image_yscale = global.stack_scale;
		
	randomize();
	next_card.new_angle = random_range(0, 180);
    next_card.depth = -1 + -ds_list_size(global.pile);
	
	ds_list_add(global.pile, next_card);
	global.supposed_top = next_card.card_id;
}

with (obj_Op2Tut) {
	alarm[1] = 120;
}