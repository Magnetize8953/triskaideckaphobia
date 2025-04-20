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


// create players, give hands
show_debug_message("Creating players...");
instance_create_layer(0, 0, "Instances", obj_Player, { num: 1, hand: player_1_hand });
instance_create_layer(0, 0, "Instances", obj_Player, { num: 2, hand: player_2_hand });
instance_create_layer(0, 0, "Instances", obj_Player, { num: 3, hand: player_3_hand });

show_debug_message("Creating pot tracker...");
instance_create_layer(0, 0, "Instances", obj_Pot, { hand: global.pot});