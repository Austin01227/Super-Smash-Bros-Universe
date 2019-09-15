//Up Smash for Kirby
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
			anim_sprite = spr_usmash0;	//REPLACE
			anim_frame = 0;
			anim_speed = 0;
		
			charge = 0;
		
			attack_frame = 6;
			return;
		}
		//Charging
		case 0:
		{
			charge++;
			if ((charge >= smash_attack_max_charge || !button_hold(INPUT.smash, 1)) && attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 6;
			}
			break;
		}
		//Sweetspot
		case 1:
		{
			var _damage = calculate_smash_damage(15, charge);	//Base damage
			
			if (attack_frame == 2)
			{
				create_melee(20, 20, 0.5, 0.5, _damage, 10, 0.5, 10, 75, 1, HITBOX_SHAPE.circle, 0);
			}
			if(attack_frame == 1)
			{
				create_melee(25, 5, 0.5, 0.5, _damage, 10, 0.5, 10, 75, 1, HITBOX_SHAPE.circle, 0);
			}
			if(attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 2;
				create_melee(20, -10, 0.5, 0.5, _damage, 10, 0.5, 10, 75, 1, HITBOX_SHAPE.circle, 0);
			}
			break;
		}
		//Sourspot
		case 2:
		{
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 3;
				var _damage = calculate_smash_damage(14, charge);	//Base damage
				create_melee(0, -20, 0.8, 0.4, _damage, 12, 0.3, 9, 88, 2, HITBOX_SHAPE.circle, 0);
			}
			break;
		}
		//Endlag
		case 3:
		{
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 26;	//Endlag
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