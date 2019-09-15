//Up Special for character0
var run = true;
var _phase = argument_count > 0 ? argument[0] : attack_phase;
//Timer
attack_frame=max(--attack_frame,0);
//Phases
if (run)
{
	switch(_phase)
	{
		case PHASE.start:
		{
			//Animation
			anim_frame = 0;
			anim_sprite = s_luigiuspec0;
			anim_speed = 0;
			
			parry_stun_time = 60;
			landing_lag = 15;
			set_speed(0, 0, false, false);
			attack_frame = 4;
			return;
		}
		//Sweetspot, Rise
		case 0:
		{
			//Animation
			if (attack_frame == 1)
				anim_frame = 1;
				
			if (attack_frame == 0)
			{
				//Animation
				anim_frame = 2;
				
				set_speed(0, -22, false, false);
				attack_phase++;
				attack_frame = 8;
				var _hitbox = create_melee(15, 30, 0.6, 0.5, 25, 10, 1.2, 15, 90, 1, HITBOX_SHAPE.circle, 0);
				set_hitbox_property(_hitbox, HITBOX_PROPERTY.hit_fx_style, HIT_FX.normal_strong);
				//set_invulnerable(INV.superarmor, 8);
			}
			break;
		}
		//Sourspot, drift
		case 1:
		{
			//Animation
			if (attack_frame == 7)
			{
				anim_frame = 3;
				create_melee(15, -38, 0.5, 0.5, 4, 12, 0.35, 5, 110, 21, HITBOX_SHAPE.circle, 0);
			}
				
			//Grab ledges
			if !stick_tilted(Lstick, DIR.down) && check_ledge_grab() return;
			
			//Drift while rising
			if (stick_tilted(Lstick, DIR.horizontal))
			{
				hsp += 1 * stick_get_value(Lstick, DIR.horizontal);
			}
			if (facing == 1)
			{
				hsp = clamp(hsp, 1, 3);
			}
			else
			{
				hsp = clamp(hsp, -3, -1);
			}
			
			//Stop rising
			if (attack_frame == 0)
			{
				//Animation
				//anim_frame = 5;
				
				if (vsp < 0)
				{
					set_speed(0, 8, true, true);
				}
				attack_phase++;
				attack_frame = 15;
			}
			break;
		}
		//Finish
		case 2:
		{
			//Gravity
			friction_gravity(air_friction, grav, max_fall_speed);
			//Grab ledges
			if (!stick_tilted(Lstick,DIR.down) && check_ledge_grab()) return;
			//Animation
			if (attack_frame == 8)
				anim_frame = 5;//6
			if(attack_frame == 6)
				anim_frame = 6;
			if (attack_frame==0)
			{
				attack_stop(PLAYER_STATE.helpless);
			}
			break;
		}
	}
}
//Movement
move_();