//Up Air for Kirby
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
			anim_sprite = spr_uair_mario;	//REPLACE
			anim_speed = 0;
			anim_frame = 0;
		
			attack_frame = 13;
			set_speed(0, -1, true, true);
			landing_lag = 7;
			return;
		}
		//Active
		case 0:
		{
			if(attack_frame == 5)
				create_melee(15, 13, 0.4, 0.4, 8, 8, 0.5, 6, 55, 1, HITBOX_SHAPE.circle, 0);
			if(attack_frame == 4)
				create_melee(20, -9, 0.4, 0.4, 8, 8, 0.5, 6, 55, 1, HITBOX_SHAPE.circle, 0);
			if(attack_frame == 3)
				create_melee(16, -26, 0.4, 0.4, 8, 8, 0.5, 6, 55, 1, HITBOX_SHAPE.circle, 0);
			if(attack_frame == 2)
				create_melee(0, -35, 0.4, 0.4, 8, 8, 0.5, 6, 55, 1, HITBOX_SHAPE.circle, 0);
			if(attack_frame == 1)
				create_melee(-13, -35, 0.4, 0.4, 8, 8, 0.5, 6, 55, 1, HITBOX_SHAPE.circle, 0);
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 6;
				create_melee(-28, -28, 0.4, 0.4, 8, 8, 0.5, 6, 55, 1, HITBOX_SHAPE.circle, 0);
			}
			break;
		}
		//Endlag
		case 1:
		{
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 13;
			}
		}
		//Finish
		case 2:
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