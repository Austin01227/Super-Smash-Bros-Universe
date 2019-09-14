//Down Tilt for Kirby
var run = true;
var _phase = argument_count > 0 ? argument[0] : attack_phase;
//Timer
attack_frame=max(--attack_frame,0);
friction_gravity(ground_friction,grav,max_fall_speed);
//Canceling
if run && cancel_air_check() run = false;
//Phases
if (run)
	{
	switch(_phase)
		{
		case PHASE.start:
			{
			//Animation
			anim_sprite = spr_dtilt0;	//REPLACE
			anim_speed = 0;
			anim_frame = 0;
		
			attack_frame = 4;
			return;
			}
		//Startup -> Active
		case 0:
			{
			if (attack_frame == 0)
				{
				attack_phase++;
				attack_frame = 6;
				create_melee(25, 28, 1, 0.5, 6, 4, 0.5, 5, 20, 3, HITBOX_SHAPE.circle, 0);
				}
			break;
			}
		//Active -> Endlag
		case 1:
			{
			if (attack_frame == 0)
				{
				attack_phase++;
				attack_frame = 11;
				}
			break;
			}
		//Finish
		case 2:
			{
			if (attack_frame == 0)
				{
				attack_stop(PLAYER_STATE.crouching);
				}
			break;
			}
		}
	}
//Movement
move_grounded_();