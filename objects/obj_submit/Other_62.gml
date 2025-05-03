/// obj_submit – Async HTTP
var m = async_load;


// only care about our own verify call
if (m[? "id"] != global.poll_request) exit;

// got a response
var code = m[? "http_status"];
show_debug_message("http status: " + string(code));

if (code == 200) {
    var result = m[? "result"];
    show_debug_message("verify result: " + result);

    if (result == "IT WORKED******") {
        global.is_Premium = true;
		show_debug_message(global.is_Premium);
        show_debug_message("*** premium unlocked ***");
        room_goto(rm_MainMenu);
    } else {
		global.not_key = true;
        show_debug_message("invalid code entered");
    }
}

// clear it so we won’t re-process
global.poll_request = -1;

// clear the textbox’s “verifying…” flag
var tb2 = instance_find(obj_TextEntry, 0);
if (tb2 != noone) tb2.awaiting_response = false;
