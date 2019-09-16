//Neutral Special
/*
- Tilt the left stick to change the trajectory
*/
var run = true;
var _phase = argument_count > 0 ? argument[0] : attack_phase;
//Timer
attack_frame=max(--attack_frame,0);
//Actions / Cancels
if (on_ground())
{
	friction_gravity(ground_friction,grav,max_fall_speed);
}
else
{
	aerial_drift();
	friction_gravity(air_friction,grav,max_fall_speed);
}
//Phases
if (run)
{
	switch(_phase)
	{
		case PHASE.start:
		{
			//Animation
			anim_sprite = spr_nspec_shot_put;
			anim_frame = 0;
			anim_speed = 0;
		
			attack_frame = 20;
			return;
		}
		//Throw
		case 0:
		{
			//Animation
			if (attack_frame == 17)
				anim_frame = 1;
			if (attack_frame == 14)
				anim_frame = 2;
			if (attack_frame == 11)
				anim_frame = 3;
			if (attack_frame == 8)
				anim_frame = 4;
			if (attack_frame ==4)
				anim_frame = 5;
				
			if (attack_frame == 0)
			{
				var _len = 11;
				var _dir = 20;
				if (facing == 1)
				{
					_dir += ((stick_get_value(Lstick, DIR.horizontal)) * -40);
				}
				else
				{
					_dir += ((stick_get_value(Lstick, DIR.horizontal)) * 40);
				}
				var proj = custom_projectile(obj_mario_fireball, 30, -5, 0.4, 0.4, 7, 7, 0.15, 70, 100, HITBOX_SHAPE.circle, lengthdir_x(_len, _dir), lengthdir_y(_len, _dir));
				audio_play_sound(snd_mario_fireball_shoot, 1, false);
				proj.grav = 0.5;
				proj.base_hitlag = 5;
				attack_phase++;
				attack_frame = 16;
			}
			break;
		}
		//Finish
		case 1:
		{
			//Animation
			if (attack_frame > 8)
				anim_frame = 6;
			
			if (attack_frame == 0)
			{
				attack_stop(PLAYER_STATE.idle);
			}
			break;
		}
	}
}

//Movement
move_();