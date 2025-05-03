/// obj_submit – Left Pressed
// grab the single textbox in the room
var tb = instance_find(obj_TextEntry, 0);
if (tb != noone && tb.text_input != "") {
    // send a POST /verify with our key
    global.poll_request = http_request(
        "http://127.0.0.1:5000/verify",
		"POST",0,"key=" + tb.text_input);
    tb.awaiting_response = true;
    show_debug_message("→ sent verify request id=" + string(global.poll_request));
}
