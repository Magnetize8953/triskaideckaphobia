event_inherited();

// associates sockets with players
clients = ds_map_create();
// just a list of sockets
sockets = ds_list_create();

server = network_create_server(network_socket_tcp, port, max_clients);
// 16KB buffer because...
buffer = buffer_create(16384, buffer_grow, 1);

// track number of players in game
num_players = 1;

alarm[0] = 5;
prev_round_winner = 0;