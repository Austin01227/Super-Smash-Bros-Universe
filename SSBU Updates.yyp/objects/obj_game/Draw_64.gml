/// @description Status / Frame Advance
//Draw player status
var _fade = (1 - obj_background_manager.background_clear_amount);
for(var i = 0; i < number_of_players; i++)
	{
	//Get accent color
	var _accent = c_white;
	var _player = instance_find(obj_player, instance_number(obj_player)-1 - i);
	_accent = palette_get_color(_player.palette, 0);
	
	//Status bar back
	draw_sprite_ext
		(
		spr_player_status,
		0,
		status_bar_space * (i + 1),
		player_status_y,
		2,
		2,
		0,
		_accent,
		_fade
		);
		
	//Set shader and uniforms
	var _pal = sprite_get_texture(_player.palette_sprite, 0);
	var _tw = texture_get_texel_width(_pal);
	var _th = texture_get_texel_height(_pal);
	var _uv = texture_get_uvs(_pal);
	
	shader_set(shd_palette);
	texture_set_stage(smp_p, _pal);
	shader_set_uniform_f(uni_c, _player.player_color);
	shader_set_uniform_f(uni_t, _tw, _th);
	shader_set_uniform_f(uni_uv, _uv[0], _uv[1], _uv[2], _uv[3]);
	
	//Portrait sprite
	draw_sprite_ext
		(
		_player.portrait,
		0,
		status_bar_space * (i + 1),
		player_status_y,
		2,
		2,
		0,
		c_white,
		round(_fade) //round so the replacement shader still works
					//alternate way would be to draw to surfaces and then draw the surfaces with alpha
		);
		
	//Stocks
	for(var m = 0; m < _player.stock; m++)
		{
		draw_sprite_ext
			(
			_player.stock_sprite,
			0,
			status_bar_space * (i + 1) + (m * 18) + 48,
			player_status_y - 48,
			2,
			2,
			0,
			c_white,
			round(_fade) 
			);
		}
	shader_reset();
	
	//Status bar front
	draw_sprite_ext
		(
		spr_player_status,
		1,
		status_bar_space * (i + 1),
		player_status_y,
		2,
		2,
		0,
		_accent,
		_fade
		);
		
	//Damage
	draw_text_sprite
		(
		46 + status_bar_space * (i + 1),
		player_status_y,
		string(_player.damage),
		spr_damage_font,
		34, //38
		_player.damage_text_x,
		_player.damage_text_y,
		2,
		calculate_damage_color(_player.damage),
		_fade
		);
	}

//Startup sequence
if (countdown > 0)
	{
	//Countdown
	var _frame = countdown div count_time;
	var _scale = lerp(2.2, 2, (countdown % count_time) / count_time);
	var _alpha = lerp(0, 1, (countdown % count_time) / count_time);
	draw_sprite_ext(spr_countdown, _frame, camera_width div 2, camera_height div 2, _scale, _scale, 0, c_white, _alpha);
	}

//Frame Advance
if (state == GAME_STATE.paused)
	{
	draw_set_font(fnt_consolas);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_black);
	draw_text(32, 16, "Press Start to advance the game");
	draw_text(32, 32, "Total Frames: " + string(current_frame));
	draw_text(32, 48, "Frame Number: " + string(frames_advanced));
	}