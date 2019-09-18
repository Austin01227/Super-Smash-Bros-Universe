//Back Air for Kirby
var run = true;
var _phase = argument_count > 0 ? argument[0] : attack_phase;
//Timer
attack_frame=max(--attack_frame,0);
friction_gravity(air_friction,grav,max_fall_speed);
fastfall_attack_try();
allow_hitfall();
aerial_drift();
//Canceling
if run && cancel_ground_check() run = false;

//Phases
if (run)
{
	switch(_phase)
	{
		case PHASE.start:
		{
			//Animation
			anim_sprite = spr_bair0;	//REPLACE
			anim_speed = 0;
			anim_frame = 0;
		
			attack_frame = 6;
			set_speed(0, -1, true, true);
			landing_lag = 10;
			return;
		}
		//Sweetspot
		case 0:
		{
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 3;
				create_melee(-20, 5, 0.8, 0.5, 12, 8, 0.5, 8, 45, 3, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai_reverse);
			}
			break;
		}
		//Sourspot
		case 1:
		{
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 8;
				create_melee(-20, 5, 0.75, 0.5, 6, 6, 0.5, 6, 45, 12, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai_reverse);
			}
			break;
		}
		//Endlag
		case 2:
		{
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 20;
			}
		}
		//Finish
		case 3:
		{
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