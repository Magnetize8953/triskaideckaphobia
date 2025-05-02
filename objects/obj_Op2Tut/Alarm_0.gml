// First play – 2 of Fleur
var index_of_2 = ds_list_find_index(hand, 15);
var card_2 = ds_list_find_value(my_cards, index_of_2);

card_2.image_index = 2;
card_2.face_down = false;

card_2.new_x = room_width / 2;
card_2.new_y = room_height / 2;
card_2.move_speed = 19;
card_2.move_wait = 1;
card_2.alarm[3] = 1;
		
card_2.image_xscale = global.stack_scale;
card_2.image_yscale = global.stack_scale;
		
randomize();
card_2.new_angle = random_range(0, 180);
card_2.depth = -1 + -ds_list_size(global.pile);
		
ds_list_add(global.pile, card_2);
global.supposed_top = card_2.card_id;