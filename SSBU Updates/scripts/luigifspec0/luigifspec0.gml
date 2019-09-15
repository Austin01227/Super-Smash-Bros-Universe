//Neutral Special for character0
/*
- Hold the button to charge the attack
- The attack's movement angle changes the more you charge it
*/
var run = true;
var _phase = argument_count > 0 ? argument[0] : attack_phase;
//Timer
attack_frame=max(--attack_frame,0);
//Main Phases
if (run)
{
	switch(_phase)
	{
		case PHASE.start:
		{
			//Startup
			anim_sprite = spr_luigifspec0;
			anim_speed = 0;
			anim_frame = 0;
			
			landing_lag = 30;
			attack_frame = 10;
			charge = 0;
			change_facing();
			set_speed(-0.75*facing, 0, true, false);
			return;
		}
		//Startup
		case 0:
		{
			set_speed(-0.25*facing, 0, true, false);
			friction_gravity(air_friction, 0.1, 1);
			
			if (attack_frame == 0)
			{
				//Charge or no charge
				if (button_hold(INPUT.special, 1))
				{
					attack_phase = 1;
					attack_frame = 10;
				}
				else
				{
					attack_phase = 2;
					attack_frame = 32;
					
					//Animation
					anim_frame = 3;
					
					//Lunge
					set_speed(9*facing, -3, false, false);
				}
			}
			break;
		}
		//Charging
		case 1:
		{
			friction_gravity(air_friction, 0.2, 6);
			
			//Animation
			if (attack_frame == 9)
				anim_frame = 1;
			if (attack_frame == 0)
				anim_frame = 2;
			
			charge++;
			if (!button_hold(INPUT.special, 1) || charge > 60)
			{
				if(charge < 10)
					charge = 10;
				attack_phase = 2;
				attack_frame = 32;
				
				//Animation
				//anim_frame = 3;
			}
			else
			//Opt out
			if charge > 10 && check_airdodge() run = false;
			
			break;
		}
		//Lunge
		case 2:
		{
			if(attack_frame <= 32 && attack_frame >= 22)
			{
				anim_frame = 2;
				set_speed(0, 0.1, false, true);
			}
			//Animation
			if(attack_frame == 21)
				fx_create(spr_hit_fx_launch, 2, 0, 5, x, y, 2, facing = 1 ? 0 : 180, "FX_Layer_Below");
			if (attack_frame == 18)
				anim_frame = 4;
			if (attack_frame == 16)
				anim_frame = 5;
			if (attack_frame <= 14 && attack_frame % 2 == 0)
			{
				anim_frame++;
				if (anim_frame > 9)
					anim_frame = 6;
			}
			
			friction_gravity(air_friction, grav, 10);
			
			if(attack_frame <= 22 && attack_frame >= 17)
			{
				set_speed(1.31*facing + (9*facing + (charge/3)*facing)/50, -2, true, false);
			}
			
			if (attack_frame < 17 && attack_frame >= 11)
			{
				//Animation
				anim_frame = 3;
				
				//Continue at speed
				set_speed(9*facing + (charge/5)*facing, -2, false, false);
				
				//Initial hit
				var _damage = calculate_smash_damage(10, charge, 60, 1);
				var _hitbox = create_melee(30, -0, 0.8, 0.8, _damage, 7, 0.9, 10, 45, 11, HITBOX_SHAPE.circle, 0);
				set_hitbox_property(_hitbox, HITBOX_PROPERTY.hit_sfx, snd_hit_strong2);
			}
			//Late hit
			if (attack_frame < 11 && attack_frame >= 5)
			{
				//anim_frame = 10;
				
				//Slow down
				set_speed((7.5*facing - (charge/3)*facing)/22, charge * 0.005, true, true);
				
				//Hitbox
				var _damage = calculate_smash_damage(6, charge, 60, 1);
				var _hitbox = create_melee(30, -0, 0.6, 0.6, 5, _damage, 0.8, 6, 55, 11, HITBOX_SHAPE.circle, 0);
				set_hitbox_property(_hitbox, HITBOX_PROPERTY.hit_sfx, snd_hit_strong2);
				
				//Touches ground
				if run && cancel_ground_check()
				{
					destroy_all_attached_hitboxes();
					attack_phase++;
					anim_frame = 12;
					attack_frame = 30;
				}
			}
			if(attack_frame < 5 && attack_frame > 0)
			{
				set_speed(6*facing, 0.08, false, true);
				
				//Touches ground
				if run && cancel_ground_check()
				{
					destroy_all_attached_hitboxes();
					attack_phase++;
					anim_frame = 12;
					attack_frame = 30;
				}
			}
			if(attack_frame == 0)
			{
				set_speed(6*facing, 3.5, false, true);
				friction_gravity(0.04, 0.4, 9);
				attack_phase++;
				//anim_frame = 12;
				attack_frame = 40;
			}
			break;
		}
		//Finish
		case 3:
		{
			if (stick_tilted(Lstick, DIR.horizontal))
			{
				hsp += 1 * stick_get_value(Lstick, DIR.horizontal);
			}
			if (facing == 1)
			{
				hsp = clamp(hsp, -2, 3);
			}
			else
			{
				hsp = clamp(hsp, -3, 2);
			}
			
			//Touches ground
			if(attack_frame <= 30 && attack_frame >= 10)
			{
				if run && cancel_ground_check()
				{
					destroy_all_attached_hitboxes();
					anim_frame = 12;
					attack_frame = 40;
				}
			}
			
			//Animation
			if (attack_frame == 6)
				anim_frame = 11;
			if (attack_frame == 3)
				anim_frame = 12;
				
			if (attack_frame == 0)
			{
				//Finish
				if (attack_has_hit())
				{
					set_state(PLAYER_STATE.aerial);
				}
				else
				{
					set_state(PLAYER_STATE.aerial);
				}
			}
			break;
		}
	}
}
	
//Movement
move_();