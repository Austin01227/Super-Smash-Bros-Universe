///@func Player_Draw_Self(x,y,scale)
///@param x
///@param y
///@param scale
var _x = argument_count > 0 ? argument[0] : x,
	_y = argument_count > 1 ? argument[1] : y,
	_scale = argument_count > 2 ? argument[2] : sprite_scale;
	
if (anim_sprite != -1 && sprite_exists(anim_sprite))
	{
	//Light change and alpha change
	var _light = 0.0, _alpha = 1.0;
	if (invulnerable_type == INV.invincible)
		{
		_light = 0.2;
		_alpha = 0.5;
		}
	
	//Set shader and uniforms
	var _pal = sprite_get_texture(palette_sprite, 0);
	var _tw = texture_get_texel_width(_pal);
	var _th = texture_get_texel_height(_pal);
	var _uv = texture_get_uvs(_pal);
	var _tex = sprite_get_texture(anim_sprite, anim_frame);
	var _ptw = texture_get_texel_width(_tex);
	var _pth = texture_get_texel_height(_tex);
	shader_set(shd_player);
	
	texture_set_stage(smp_p, _pal);
	shader_set_uniform_f(uni_c, player_color);
	shader_set_uniform_f(uni_t, _tw, _th);
	shader_set_uniform_f(uni_uv, _uv[0], _uv[1], _uv[2], _uv[3]);
	
	shader_set_uniform_f(uni_l, _light);
	shader_set_uniform_f(uni_a, _alpha);
	shader_set_uniform_f(uni_f, fade_value);
	shader_set_uniform_i(uni_o, player_outline);
	shader_set_uniform_f(uni_ot, _ptw, _pth);
	shader_set_uniform_f
		(
		uni_oc, 
		color_get_red  (player_outline_color) / 255,
		color_get_green(player_outline_color) / 255,
		color_get_blue (player_outline_color) / 255,
		1.0
		);
	
	//Draw the sprite
	Draw_Anim_Sprite(anim_sprite, floor(anim_frame), facing, _x, _y, _scale);
		
	shader_reset();
	}