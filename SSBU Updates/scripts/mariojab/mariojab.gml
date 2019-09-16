//Jab for character0
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
			anim_sprite = spr_jab0;
			anim_speed = 0;
			anim_frame = 3;
			can_be_parried = false;
		
			attack_frame = 3;
			return;
		}
		//Jab 1
		case 0:
		{
			if (attack_frame == 0)
			{
				//Animation
				anim_frame = 1;
			
				attack_phase++;
				attack_frame = 8;
				set_speed(0, 0, true, false);
				var _hitbox = create_melee(20, 4, 0.5, 0.3, 3, 5, 0.1, 3, 75, 3, HITBOX_SHAPE.circle, 0);
				set_hitbox_property(_hitbox, HITBOX_PROPERTY.knockback_state, PLAYER_STATE.in_flinch);
			}
			break;
		}
		//Jab 1 Endlag
		case 1:
		{
			if(attack_frame == 5)
				anim_frame = 2;
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 6;
			}
			break;
		}
		//Jab 1 -> Jab 2
		case 2:
		{
			//Animation
			anim_frame = 2;
			
			//Cancel into tilts from first jab
			if (stick_tilted(Lstick) && check_grounds())
			{
				break;
			}
			//Continue to next jab
			if (button(INPUT.attack, 6))
			{
				attack_phase++;
				anim_frame = 5;
				attack_frame = 3;
			}
			//Auto end
			else if (attack_frame == 0)
			{
				attack_phase = 8;
				attack_frame = 5;
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
				anim_frame = 4;
				attack_frame = 3;
				set_speed(0, 0, false, false);
				var _magnetbox = create_magnetbox(20, 4, 0.7, 0.3, 2, 2, 34, 5, 16, 3, HITBOX_SHAPE.circle, 1);
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
		//Jab 2 -> Jab 3
		case 5:
		{
			//Animation
			if(attack_frame == 7)
				anim_frame = 5;
			
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
				attack_phase = 8;
				attack_frame = 10;
			}
			break;
		}
		//Jab 3
		case 6:
		{
			//Animation
			if (attack_frame == 0)
			{
				//Animation
				anim_frame = 5;
			
				attack_phase++;
				attack_frame = 20;
				set_speed(0, 0, false, false);
				var _hitbox = create_melee(30, 5, 0.6, 0.5, 4, 6, 0.9, 6, 60, 3, HITBOX_SHAPE.circle, 2);
				set_hitbox_property(_hitbox, HITBOX_PROPERTY.hit_sfx, snd_hit_strong);
			}
			break;
		}
		//Jab 3 Endlag
		case 7:
		{
			if(attack_frame == 18)
				anim_frame = 8;
			if(attack_frame == 13)
				anim_frame = 9;
			if(attack_frame == 7)
				anim_frame = 10;
			if(attack_frame == 2)
				anim_frame = 3;
				
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 5;
			}
			break;
		}
		//Finish
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