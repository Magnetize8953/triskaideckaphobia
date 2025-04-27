// packet identifiers
enum NETWORK {
    JOINING,                // (u8) server-side id, (u8) hand size, (u8, loop) player's hand, (u8) pot size, (u8, loop) pot
    PLAYER_ADD,             // (u8) player id, (u8, loop) player's hand
    PLAYER_REMOVE,          // (u8) player id
    MAX_PLAYERS_REACHED,    //
    END_GAME,               //
}

enum GAME {
    BASE_SELECT,            // (u8) player id, (u8) base card id
    HONEST_HAND,            // (u8) player id, (u8, loop) cards
    BLUFFED_HAND,           // (u8) player id, (u8, loop) cards
    NEXT_TURN,              // 
    NEXT_ROUND,             // 
    GAME_OVER,              // (u8) winning player id
}

show_debug_message("networking initialised");