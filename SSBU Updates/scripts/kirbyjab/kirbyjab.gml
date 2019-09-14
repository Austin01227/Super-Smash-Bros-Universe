//Jab for Kirby
/*
- Press the button multiple times to continue the combo
- The first two hits can be canceled into tilts
*/
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
			anim_sprite = spr_jab0;	//REPLACE
			anim_speed = 0;
			anim_frame = 0;
			can_be_parried = false;
		
			attack_frame = 5;
			return;
			}
		//Jab 1
		case 0:
			{
			if (attack_frame == 0)
				{
				attack_phase++;
				attack_frame = 8;
				set_speed(0, 0, true, false);
				var _hitbox = create_melee(15, 10, 0.5, 0.3, 3, 5, 0.1, 3, 75, 3, HITBOX_SHAPE.circle, 0);
				set_hitbox_property(_hitbox, HITBOX_PROPERTY.knockback_state, PLAYER_STATE.in_flinch);
				}
			break;
			}
		//Jab 1 Endlag
		case 1:
			{
			if (attack_frame == 0)
				{
				attack_phase++;
				attack_frame = 6;
				}
			break;
			}
		//Jab 1 Cancel
		case 2:
			{
			//Cancel into tilts from first jab
			if (stick_tilted(Lstick) && check_grounds())
				{
				break;
				}
			//Continue to next jab
			if (button(INPUT.attack, 12))
				{
				attack_phase++;
				attack_frame = 3;
				}
			//Auto end
			else if (attack_frame == 0)
				{
				attack_stop(PLAYER_STATE.idle);
				}
			break;
			}
		//Jab 2
		case 3:
			{
			if (attack_frame == 0)
				{
				//Continue jab combo
				attack_phase++;
				attack_frame = 3;
				set_speed(0, 0, false, false);
				var _magnetbox = create_magnetbox(15, 10, 0.6, 0.3, 2, 2, 15, 15, 11, 3, HITBOX_SHAPE.circle, 1);
				set_hitbox_property(_magnetbox, HITBOX_PROPERTY.base_hitlag, 5);
				set_hitbox_property(_magnetbox, HITBOX_PROPERTY.hit_fx_style, HIT_FX.normal_weak);
				}
			break;
			}
		//Jab 2 Endlag
		case 4:
			{
			if (attack_frame == 0)
				{
				attack_phase++;
				attack_frame = 16;
				}
			break;
			}
		//Jab 2 Cancel
		case 5:
			{
			//Cancel into tilts from the second jab
			if (stick_tilted(Lstick) && check_grounds())
				{
				break;
				}
			//Continue to next jab
			if (button(INPUT.attack, 12))
				{
				attack_phase++;
				attack_frame = 4;
				}
			//Auto end
			else if (attack_frame == 0)
				{
				attack_stop(PLAYER_STATE.idle);
				}
			break;
			}
		//Jab 3
		case 6:
			{
			//Animation
			if (attack_frame == 0)
				{
				attack_phase++;
				attack_frame = 15;
				set_speed(0, 0, false, false);
				var _hitbox = create_melee(15, 10, 0.5, 0.3, 4, 6, 0.9, 6, 60, 3, HITBOX_SHAPE.circle, 2);
				set_hitbox_property(_hitbox, HITBOX_PROPERTY.hit_sfx, snd_hit_strong);
				}
			break;
			}
		//Jab 3 Endlag
		case 7:
			{
			if (attack_frame == 0)
				{
				attack_phase++;
				attack_frame = 10;
				}
			break;
			}
		//Endlag
		case 8:
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