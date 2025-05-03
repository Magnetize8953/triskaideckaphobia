// TODO: add audio
// audio_play_sound(snd_ButtonPressed, 1, false);

if (option_name != noone && string_count("quit", string_lower(option_name)) > 0) {
    game_end();
}
if (obj != noone) {
    var new_obj = instance_create_layer(room_width / 2, room_height / 2, "Instances", obj);
}
if (other_room != noone) {
    room_goto(other_room);
}