//Forward Smash for Kirby
var run = true;
var _phase = argument_count > 0 ? argument[0] : attack_phase;
//Timer
attack_frame=max(--attack_frame,0);
friction_gravity(slide_friction,grav,max_fall_speed);
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
			anim_sprite = spr_fsmash0;	//REPLACE
			anim_frame = 0;
			anim_speed = 0;
		
			charge = 0;
		
			attack_frame = 9;
			return;
		}
		//Charging
		case 0:
		{
			charge++;
			if ((charge >= smash_attack_max_charge || !button_hold(INPUT.smash, 1)) && attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 4;
			}
			break;
		}
		//Sweetspot
		case 1:
		{
			if (attack_frame == 0)
			{
				set_speed(facing * 8, 0, false, false);
				attack_phase++;
				attack_frame = 3;
				var _damage = calculate_smash_damage(15, charge);	//Base damage
				create_melee(30, 10, 1, 0.5, _damage, 12, 0.5, 10, 45, 3, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
			}
			break;
		}
		//Sourspot
		case 2:
		{
			if(attack_frame > 0)
			{
				//set_speed(facing * -0.5, 0, true, false);
			}
			if (attack_frame == 0)
			{
				set_speed(facing * -0.5, 0, true, false);
				attack_phase++;
				attack_frame = 4;
				var _damage = calculate_smash_damage(11, charge);	//Base damage
				create_melee(30, 10, 1, 0.5, _damage, 8, 0.5, 6, 60, 4, HITBOX_SHAPE.circle, 0);
			}
			break;
		}
		//Endlag
		case 3:
		{
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 28;	//Endlag
			}
			break;
		}
		//Finish
		case 4:
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