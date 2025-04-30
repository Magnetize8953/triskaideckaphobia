// packet identifiers
enum NETWORK {
    JOINING,                // (u8) server-side id, (u8) hand size, (u8, loop 13) player's hand, (u8) hand size, (u8, loop 13) hosts's hand, (u8) hand size, (u8, loop 13) other player's hand, (u8) pot size, (u8, loop) pot
    PLAYER_ADD,             // (u8) player id, (u8, loop 13) player's hand
    PLAYER_REMOVE,          // (u8) player id
    MAX_PLAYERS_REACHED,    //
    END_GAME,               //
    
    BASE_SELECT,            // (u8) player id, (u8) base card id
    HONEST_HAND,            // (u8) player id, (u8, loop 255-terminated) card ids
    BLUFFED_HAND,           // (u8) player id, (u8, loop 255-terminated) card ids
    NEXT_TURN,              // 
    NEXT_ROUND,             // 
    GAME_OVER,              // (u8) winning player id
}

// default, to be used by host
global.id_on_server = 1;

show_debug_message("networking initialised");