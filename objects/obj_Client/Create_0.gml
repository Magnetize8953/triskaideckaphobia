event_inherited();

// TODO: move to instance variables
client_socket = network_create_socket(network_socket_tcp);
ip = "127.0.0.1";
port = 50001;
connection = network_connect(client_socket, ip, port);


buffer = buffer_create(16384, buffer_grow, 1);
// associates player ids with nums
elements = ds_map_create();