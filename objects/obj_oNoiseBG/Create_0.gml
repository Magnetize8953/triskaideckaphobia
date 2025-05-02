// set draw depth so noise is behind ui
depth = 10

// how many samples across / down
grid_w = 200  
grid_h = 100  

// frames per full morph cycle
anim_interval = 60  

// interpolation factor between noise_old and noise_new (0..1)
// ChatGPT created and used this variable to help with animation in step event
t = 0  

// two grids for smooth transitions
// used ChatGPT here to figure I needed two grids to make animation smoother
noise_old = ds_grid_create(grid_w, grid_h)
noise_new = ds_grid_create(grid_w, grid_h)

// generate initial noise patterns
scr_generate_noise(noise_old, grid_w, grid_h, 4, 4)
scr_generate_noise(noise_new, grid_w, grid_h, 4, 4)

// surface to cache our drawn noise each frame
bg_surface = surface_create(room_width, room_height)
