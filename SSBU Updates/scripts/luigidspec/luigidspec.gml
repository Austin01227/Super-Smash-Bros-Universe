//Down Special for Luigi
var run = true;
var _phase = argument_count > 0 ? argument[0] : attack_phase;
//Timer
attack_frame=max(--attack_frame,0);
friction_gravity(air_friction, grav, 2);
aerial_drift();
if(!on_ground()) hsp = clamp(hsp, -2, 2);
//Phases
if (run)
{
	switch(_phase)
	{
		case PHASE.start:
		{
			//Animation
			anim_sprite = spr_dair0;	//REPLACE
			anim_speed = 0;
			anim_frame = 0;
		
			attack_frame = 10;
			return;
		}
		//Startup
		case 0:
		{
			if (attack_frame == 0)
			{
				attack_frame = 45;
				create_melee(0, 0, 1.4, 1.2, 1, 6, 0, 4, 45, 43, HITBOX_SHAPE.circle, 0, FLIPPER.toward_hitbox_center);
				attack_phase++;
			}
			break;
		}
		//Multihit
		case 1:
		{
			if (on_ground())
			{
				if(button(INPUT.special, 12, true))
					set_speed(stick_get_value(Lstick, DIR.horizontal) * 6, -3, false, true);
				else
					set_speed(stick_get_value(Lstick, DIR.horizontal) * 6, 0, false, true);
			}
			else
			{
				if(button(INPUT.special, 12, true))
					set_speed(stick_get_value(Lstick, DIR.horizontal) * 0.0015, -3, true, true);
				else
					set_speed(stick_get_value(Lstick, DIR.horizontal) * 0.0015, 0, true, true);
			}
			
			if(attack_frame % 5 == 0 && attack_frame >= 2)
			{
				//Rehit
				reset_hitbox_group(collided, 0);
			}
			if(attack_frame == 0)
			{
				create_melee(0, 0, 1.5, 1.2, 4, 13, 0.3, 12, 90, 5, HITBOX_SHAPE.circle, 2);
				if(!on_ground())
				{
					attack_frame = 45;
				}
				else if(on_ground())
				{
					//set_speed(0, 0, false, true);
					attack_frame = 45;
				}
				attack_phase++;
			}
		}
		//Finish
		case 2:
		{
			if(on_ground() && attack_phase == 2)
			{
				set_speed(0, 0, false, false);
			}
			if (attack_frame == 0)
			{
				if(on_ground())
					set_state(PLAYER_STATE.idle);
				else if (!on_ground())
					set_state(PLAYER_STATE.aerial);
			}
			break;
		}
	}
}
	
//Movement
move_();