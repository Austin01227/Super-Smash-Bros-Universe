/// @description
clear = true;

offset = 100;

winner = global.win_screen_data_temp;

char = winner[PLAYER_DATA.character];
palette_sprite = winner[PLAYER_DATA.palettespr];
palette = winner[PLAYER_DATA.palette];
color_index = winner[PLAYER_DATA.color];
color = palette_get_color(palette, 0);
render = winner[PLAYER_DATA.render];

//Replays
can_save_replay = global.replay_record;

//Shader uniforms
uni_t = shader_get_uniform(shd_palette, "texel");
uni_c = shader_get_uniform(shd_palette, "current");
uni_uv = shader_get_uniform(shd_palette, "UV");
smp_p = shader_get_sampler_index(shd_palette, "palette");

var _r = color_get_red	(color) / $FF;
var _g = color_get_green(color) / $FF;
var _b = color_get_blue	(color) / $FF;
var _d = 0.2;
Voronoi_Change_Color
	(
	[_r - random(_d), _r + random(_d)], 
	[_g - random(_d), _g + random(_d)], 
	[_b - random(_d), _b + random(_d)],
	);