if (playable) {
    global.hand_is_go = false;
    honest_play();
    with (obj_BluffButton) {
    	instance_destroy();
    }
    instance_destroy();
}