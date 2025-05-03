global.building_honest_hand = false;
global.building_bluffed_hand = false;
global.stack_scale = 0.46; // Scale for cards on stack consistency
global.pile = ds_list_create();
global.supposed_top = -1;

player_hand = ds_list_create();
//p_hand translate: 3, 4, 9, Q,  4,  J,  K,  A,  10,  J,  5,  Q,  K
cards_for_p_hand = [3, 4, 9, 12, 17, 24, 26, 27, 36, 37, 44, 51, 52];
for (i = 0; i < array_length(cards_for_p_hand); i++) {
	ds_list_add(player_hand, cards_for_p_hand[i]);
}
player = instance_create_layer(0, 0, "Instances", obj_Player, { num: 1, hand: player_hand });

op1_hand = ds_list_create();
//op1 hand translate: 2,               5,  6,                      6
cards_for_op1_hand = [2, 5, 6, 11, 16, 18, 19, 21, 25, 33, 34, 43, 45]
for (i = 0; i < array_length(cards_for_op1_hand); i++) {
	ds_list_add(op1_hand, cards_for_op1_hand[i]);
}
op1 = instance_create_layer(5,0, "Instances", obj_Op1Tut, {hand: op1_hand});

op2_hand = ds_list_create();
//op2 hand translate: 7,    2,                      6,  
cards_for_op2_hand = [7, 8, 15, 20, 22, 23, 29, 31, 32, 35, 38, 40, 41];
for (i = 0; i < array_length(cards_for_op2_hand); i++) {
	ds_list_add(op2_hand, cards_for_op2_hand[i]);
}
op2 = instance_create_layer(10,0, "Instances", obj_Op2Tut, {hand: op2_hand});

//dummy pot, first is 1
dummy_pot = [1, 10, 13, 14, 28, 30, 39, 42, 46, 47, 48, 49, 50];
global.pot_cards = ds_list_create();
for (i = 0; i < 13; i++) {
	_card = dummy_pot[i]; // an integer corresponding to the card id
    _card_sprite_width = sprite_get_width(spr_Cards) * 0.25;
    _y_position = 0 + (sprite_get_height(spr_Cards) * 0.45);
	_x_position = (i+1.5) * (_card_sprite_width * 0.8) + 384/2;
	pot_card = instance_create_layer(_x_position, _y_position, "Instances", obj_PotCard, { card_id: _card , rotation: 0, scale: 0.27});
	pot_card.image_index = 0;
	pot_card.face_down = true;
	ds_list_add(global.pot_cards, pot_card);
}
// SCRIPTED ORDER OF TUTORIAL: 
// 0. Intro text explaining game
running_intro_text = 1100;

// CHANGE THIS BACK TO 0
alarm[0] = 1;
global.hand_is_go = false; // REMOVE

first_text = noone; //variables for text display later
second_text = noone;
third_text = noone;
fourth_text = noone;
// 1. Pick base
arrow = noone;
base_picked = false;
fifth_text = noone;
sixth_text = noone;
global.base_card = false;
global.card_being_selected = false;
// 2. Opponents both play small hands – two of cool s; two of fleur
// 3. Play honest hand – 3, 4, 4, 5
post_2_text = 360;
seventh_text = noone;
eighth_text = noone; 
ninth_text = noone;
tenth_text = noone;
nine_ten = false;
need3 = false;
eleventh_text = noone;
twelth_text = noone;
eleven_twelve = true;
need4_1 = false;
thirteenth_text = noone;
fourteenth_text = noone;
thir_four = true;
need4_2 = false;
fifteenth_text = noone;
sixteenth_text = noone;
fif_six = true;
need5 = false;

collected_cards = ds_stack_create();
// 4. two more go around – 5, 6, 6; 6, 7
// 5. Play bluffed hand – some ace, 7, and 9 combo, bluffing one 7 and two 8s
// 6. Player gets warning about bluffing and those win/lose conditions explained to them
// 7. One more pass around – bluffed 8, 8, 9, 9; bluffed 9, 10, J
// 8. They empty their hand and win honestly (play J, J, Q, K, K, A)
// 9. Dump about other rules 

show_debug_message(layer_exists("Assets_1"));