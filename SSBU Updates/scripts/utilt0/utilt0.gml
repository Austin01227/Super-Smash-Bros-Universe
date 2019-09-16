//Up Tilt for character0
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
			anim_sprite=spr_utilt0;
			anim_speed=0;
			anim_frame=0;
		
			attack_frame=6;
			return;
		}
		//Sweetspot
		case 0:
		{
			//Animation
			if (attack_frame == 3)
				anim_frame = 1;
				
			if (attack_frame == 0)
			{
				//Animation
				anim_frame = 2;
			
				attack_phase++;
				attack_frame = 9;
				create_melee(15, -5, 0.5, 0.4, 6, 7, 0.9, 10, 90, 2, HITBOX_SHAPE.circle, 0);
			}
			break;
		}
		//Sourspot
		case 1:
		{
			//Animation
			if (attack_frame == 6)
			{
				anim_frame = 3;
				create_melee(20, -30, 0.5, 0.8, 5, 9, 0.35, 7, 90, 6, HITBOX_SHAPE.circle, 0);
			}
			
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = attack_has_hit() ? 9 : 15;
			}
			break;
		}
		//Finish
		case 2:
		{
			//Animation
			anim_frame = 4;
		
			if (attack_frame == 0)
			{
				attack_stop(PLAYER_STATE.idle);
			}
			break;
		}
	}
}

//Movement
move_grounded_();