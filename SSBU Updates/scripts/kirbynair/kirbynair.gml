//Neutral Air for Kirby
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
			anim_sprite = spr_nair0;	//REPLACE
			anim_speed = 0;
			anim_frame = 0;
		
			attack_frame = 6;
			set_speed(0, -1, true, true);
			landing_lag = 7;
			return;
		}
		//Sweetspot
		case 0:
		{
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 2;
				create_melee(25, 30, 0.9, 0.4, 8, 8, 0.4, 7, 39, 2, HITBOX_SHAPE.circle, 0);
				create_melee(-15, 25, 0.4, 0.4, 8, 8, 0.4, 7, 45, 2, HITBOX_SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
			}
			break;
		}
		//Mid hit
		case 1:
		{
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 4;
				create_melee(25, 30, 0.85, 0.4, 6, 6, 0.4, 6, 361, 4, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
				create_melee(-15, 25, 0.35, 0.35, 6, 6, 0.4, 6, 45, 4, HITBOX_SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
			}
			break;
		}
		//Sourspot
		case 2:
		{
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 5;
				create_melee(25, 30, 0.85, 0.4, 4, 4, 0.4, 5, 361, 8, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
				create_melee(-15, 25, 0.35, 0.35, 4, 4, 0.4, 5, 45, 8, HITBOX_SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
			}
			break;
		}
		//Endlag
		case 3:
		{
			if (attack_frame == 0)
			{
				//Animation
				anim_frame = 3;
				
				attack_phase++;
				attack_frame = 20;
			}
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