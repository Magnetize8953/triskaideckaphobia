// ensure our surface exists
if !surface_exists(bg_surface) {
    bg_surface = surface_create(room_width, room_height)
}

// draw into offscreen surface
surface_set_target(bg_surface)
draw_clear_alpha(c_black, 1)

// cell size in pixels
var cw = room_width  / grid_w
var ch = room_height / grid_h

// contrast >1 boosts difference from midgrey
var contrast  = 3
// threshold forces deep blacks
var threshold = 0.25

for (var yy = 0; yy < grid_h; yy++) {
    for (var xx = 0; xx < grid_w; xx++) {
        // fetch old and new values
        var v0 = ds_grid_get(noise_old, xx, yy)
        var v1 = ds_grid_get(noise_new, xx, yy)
        // smooth blend
        var v  = lerp(v0, v1, t)
        // apply contrast curve
        v      = (v - 0.5) * contrast + 0.5
        v      = clamp(v, 0, 1)
        // deepen dark regions
        if (v < threshold) { v = 0 }
        var r = floor(v * red);
        var g = floor(v * green);
        var b = floor(v * blue);
        draw_set_color(make_color_rgb(r, g, b))
        draw_rectangle(
            xx * cw, yy * ch,
            (xx + 1) * cw, (yy + 1) * ch,
            false
        )
    }
}

// back to screen
surface_reset_target()
draw_surface(bg_surface, 0, 0)
