/* obj_textbox – Step
// keep text_input in sync with keyboard_string
if (keyboard_lastkey != vk_backspace) {
    if (string_length(keyboard_string) <= max_length) {
        text_input = keyboard_string;
    } else {
        text_input = string_copy(keyboard_string, 1, max_length);
    }
}
*/

text_input = keyboard_string;

// clamp to your max length, and keep the buffer in sync
if (string_length(text_input) > max_length) {
    text_input       = string_copy(text_input, 1, max_length);
    keyboard_string  = text_input;
}

if (keyboard_check_pressed(vk_enter)) {
    global.ip = text_input;
    if (room == rm_SelectMultiplayer) {
        room_goto(rm_GameRoom);
        instance_create_layer(room_width / 2, room_height / 2, "Instances", obj_Client);
    }
    instance_destroy(self);
}