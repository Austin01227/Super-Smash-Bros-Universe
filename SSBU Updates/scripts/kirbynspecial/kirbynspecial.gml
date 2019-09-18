//Dash Attack for character0
var run = true;
var _phase = argument_count > 0 ? argument[0] : attack_phase;
//Timer
attack_frame=max(--attack_frame,0);
//Canceling
if run && cancel_air_check() run = false;
//Phases
if (run)
{
	switch(_phase)
	{
		case PHASE.start:
		{
			anim_sprite = spr_fsmash0;	//REPLACE
			anim_speed = 0;
			anim_frame = 0;
			
			attack_frame = 12;
			return;
		}
		//Startup
		case 0:
		{
			if(attack_frame == 0)
			{
				attack_phase++;
			}
			break;
		}
		//Active
		case 1:
		{
			if (button_hold(INPUT.special, 1))
			{
				//attack_frame = 3;
				create_melee(30, 25, 1.2, 0.5, 9, 8, 0.6, 9, 45, 1, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
			}
			else
				attack_phase++;
				attack_frame = 15;
			break;
		}
		//Endlag
		case 2:
		{
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 5;
			}
			break;
		}
		//Finish
		case 3:
		{
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