if (playable) {
    global.hand_is_go = false;
    bluff_play();
    with (obj_HonestButton) {
    	instance_destroy();
    }
    instance_destroy();
}