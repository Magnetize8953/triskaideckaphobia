// change player ids to match server
if (ds_list_size(global.player1.my_cards) == 13 and ds_list_size(global.player2.my_cards) == 13 and ds_list_size(global.player3.my_cards) == 13) {
    global.player1.num = global.id_on_server;
    global.player2.num = 1;
    global.player3.num = global.id_on_server == 2 ? 3 : 2;
    alarm[0] = 1;
} else {
    alarm[1] = 5;
}