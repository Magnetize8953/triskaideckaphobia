// TODO: uncomment out and finish 
// honest_play script call here
global.hand_is_go = false;
honest_play();
with (obj_BluffButton) {
	instance_destroy();
}
instance_destroy();