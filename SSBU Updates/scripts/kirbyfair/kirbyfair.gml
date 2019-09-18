//Forward Air for Kirby
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
			anim_sprite = spr_fair0;	//REPLACE
			anim_speed = 0;
			anim_frame = 0;
		
			attack_frame = 8;
			set_speed(0, -1, true, true);
			landing_lag = 8;
			return;
		}
		//First hit
		case 0:
		{
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 8;
				create_melee(30, 15, 0.9, 0.5, 3, 5, 0, 6, 75, 2, HITBOX_SHAPE.circle, 0, FLIPPER.autolink);
			}
			break;
		}
		//Second hit
		case 1:
		{
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 8;
				create_melee(30, 15, 0.9, 0.5, 3, 5, 0, 6, 75, 2, HITBOX_SHAPE.circle, 1, FLIPPER.autolink);
			}
			break;
		}
		//Third hit
		case 2:
		{
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 8;
				create_melee(30, 15, 0.9, 0.5, 4, 8, 0.5, 8, 45, 5, HITBOX_SHAPE.circle, 2, FLIPPER.sakurai);
			}
			break;
		}
		//Endlag
		case 3:
		{
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 17;
			}
			break;
		}
		//Finish
		case 4:
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