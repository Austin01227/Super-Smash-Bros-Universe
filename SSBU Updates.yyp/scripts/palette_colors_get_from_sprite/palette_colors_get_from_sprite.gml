///@func palette_colors_get_from_sprite(sprite,column)
///@param sprite
///@param column
var _spr = argument[0];
var _col = argument[1];
var _surf = surface_create(sprite_get_width(_spr), sprite_get_height(_spr));
var _array = [];

//Draw sprite to surface
surface_set_target(_surf);
draw_sprite(_spr, 0, 0, 0);
surface_reset_target();

//Grab all of the colors in a column and put them in an array
for(var i = 0; i < sprite_get_height(_spr); i++)
	{
	_array[@array_length_1d(_array)] = surface_getpixel(_surf, _col, i);
	}

surface_free(_surf);
return _array;