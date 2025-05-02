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
