///@func die()
///@desc Knocks out a player and destroys their hitboxes
attack_stop();
set_state(PLAYER_STATE.knocked_out);
destroy_all_attached_hitboxes();
camera_shake(death_cam_shake);
hit_sfx_play(snd_hit_explosion);

//Variable reset
jump_is_dash_jump = false;
jump_is_midair_jump = false;

//Stock matches
stock--;

//Invulnerability
set_invulnerable(INV.invincible, ko_frame);

//VFX
var _col = palette_get_color(palette, 0);
var _fx = fx_create(spr_hit_fx_ko_explosion, 1, 0, 47, x, y, 4, point_direction(x, y, room_width / 2, room_height / 2));
_fx.image_blend = _col;
var _fx = fx_create(spr_hit_fx_ko_explosion, 1, 0, 47, x, y, 3, point_direction(x, y, room_width / 2, room_height / 2));
_fx.fx_ys *= -1;
_fx.image_blend = _col;