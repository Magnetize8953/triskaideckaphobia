// Used to reshuffle the player hands again
show_debug_message("Starting hand reshuffling (alarm reached) ...");
ds_list_shuffle(global.hand_pool);
for (i = 0; i < 52 - 13; i++) {
	show_debug_message("pool card " + string(i) + ": " + string(ds_list_find_value(global.hand_pool, i)));
}
ds_list_clear(player_1_hand);
ds_list_clear(player_2_hand);
ds_list_clear(player_3_hand);

show_debug_message("Sorting hands...");
for (i = 0; i <= 12; i++) {
    ds_list_add(player_1_hand, ds_list_find_value(global.hand_pool, i));
}
ds_list_sort(player_1_hand, true);

for (i = 13; i <= 25; i++) {
    ds_list_add(player_2_hand, ds_list_find_value(global.hand_pool, i));
}
ds_list_sort(player_2_hand, true);

for (i = 26; i <= 38; i++) {
    ds_list_add(player_3_hand, ds_list_find_value(global.hand_pool, i));
}
ds_list_sort(player_3_hand, true);

global.player1.hand = player_1_hand;
global.player1.update_hand = true;
global.player2.hand = player_2_hand;
global.player2.update_hand = true;
global.player3.hand = player_3_hand;
global.player3.update_hand = true;

