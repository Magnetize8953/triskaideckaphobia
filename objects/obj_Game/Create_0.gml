global.current_turn = 1; // Create turn tracker
global.stack_scale = 0.23; // Scale for cards on stack consistency

// create deck
show_debug_message("Creating deck...");
deck = ds_list_create();
for (i = 1; i <= 52; i++) {
    ds_list_add(deck, i);
}
randomize();
ds_list_shuffle(deck);

for (i = 0; i < 52; i++) { show_debug_message(ds_list_find_value(deck, i)) }

global.pot = ds_list_create();
player_1_hand = ds_list_create();
player_2_hand = ds_list_create();
player_3_hand = ds_list_create();


// arrange and sort deck into hands
show_debug_message("Sorting hands...");
for (i = 0; i <= 12; i++) {
    ds_list_add(global.pot, ds_list_find_value(deck, i));
}
ds_list_sort(global.pot, true);

for (i = 13; i <= 25; i++) {
    ds_list_add(player_1_hand, ds_list_find_value(deck, i));
}
ds_list_sort(player_1_hand, true);

for (i = 26; i <= 38; i++) {
    ds_list_add(player_2_hand, ds_list_find_value(deck, i));
}
ds_list_sort(player_2_hand, true);

for (i = 39; i <= 51; i++) {
    ds_list_add(player_3_hand, ds_list_find_value(deck, i));
}
ds_list_sort(player_3_hand, true);

global.hand_pool = ds_list_create();
ds_list_concat(global.hand_pool, player_1_hand);
ds_list_concat(global.hand_pool, player_2_hand);
ds_list_concat(global.hand_pool, player_3_hand);

// create players, give hands
show_debug_message("Creating players...");
global.player1 = instance_create_layer(0, 0, "Instances", obj_Player, { num: 1, hand: player_1_hand });
global.player2 = instance_create_layer(0, 0, "Instances", obj_Player, { num: 2, hand: player_2_hand });
global.player3 = instance_create_layer(0, 0, "Instances", obj_Player, { num: 3, hand: player_3_hand });

show_debug_message("Creating pot tracker...");
global.pot_obj = instance_create_layer(0, 0, "Instances", obj_Pot, { hand: global.pot});


// center pile of cards
global.pile = ds_stack_create();

// Tracks if a base card has been selected
global.base_card = false;

// A global tracker for a stack to be played 
global.staging_cards = ds_stack_create();

// Tracks which hands are being built
global.building_honest_hand = false;
global.building_bluffed_hand = false;

// Tracker for what's entered the stack 
// TODO: implement use of 
global.the_stack = ds_stack_create();