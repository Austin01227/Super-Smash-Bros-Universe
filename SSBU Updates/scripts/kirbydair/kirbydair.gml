//Down Air for Kirby
var run = true;
var _phase = argument_count > 0 ? argument[0] : attack_phase;
//Timer
attack_frame=max(--attack_frame,0);
friction_gravity(air_friction,grav,max_fall_speed);
fastfall_attack_try();
allow_hitfall();
aerial_drift();

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
		
			attack_frame = 15;
			set_speed(0, -1, true, true);
			landing_lag = 16;
			return;
		}
		//Startup
		case 0:
		{
			if(cancel_ground_check())
			{
				set_speed(0, 0, false, false);
				attack_phase = 3;
				attack_frame = 16;
			}
			
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 15;
				create_melee(5, 10, 0.45, 0.45, 1, 4, 0, 6, 270, 13, HITBOX_SHAPE.circle, 0, FLIPPER.autolink);
				create_melee(13, 23, 0.45, 0.45, 1, 4, 0, 6, 270, 13, HITBOX_SHAPE.circle, 0, FLIPPER.autolink);
			}
			break;
		}
		//Multihit
		case 1:
		{
			if(attack_frame % 3 == 0 && attack_frame >= 2)
			{
				//Rehit
				reset_hitbox_group(collided, 0);
				
				//Quake hit
				if (on_ground())
				{
					set_speed(0, 0, true, false);
					destroy_all_attached_hitboxes(my_hitboxes);
			
					create_melee(0, 30, 0.7, 0.5, 2, 6, 0.5, 8, 25, 2, HITBOX_SHAPE.circle, 1);
					attack_phase = 3;
					attack_frame = 16;
				}
			}
			if(attack_frame == 0)
			{
				attack_phase++;
				create_melee(5, 10, 0.5, 0.5, 4, 10, 0.4, 10, 270, 1, HITBOX_SHAPE.circle, 1);
				create_melee(13, 23, 0.5, 0.5, 4, 10, 0.4, 10, 270, 1, HITBOX_SHAPE.circle, 1);
			}
		}
		//Endlag
		case 2:
		{
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 15;
			}
		}
		//Finish
		case 3:
		{
			if(on_ground())
			{
				set_speed(0, 0, false, false);
			}
			
			if (attack_frame == 0)
			{
				set_state(PLAYER_STATE.aerial);
			}
			break;
		}
	}
}
	
//Movement
move_();