// TODO: uncomment out and finish 
// bluff_play script call here
global.hand_is_go = false;
bluff_play();
instance_destroy(instance_position(500, 530, obj_HonestButton));
instance_destroy();