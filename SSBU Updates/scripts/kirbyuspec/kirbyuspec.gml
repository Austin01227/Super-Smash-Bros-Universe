//Up Special for Kirby
var run = true;
var _phase = argument_count > 0 ? argument[0] : attack_phase;
//Timer
attack_frame=max(--attack_frame,0);
//Phases
if (run)
{
	switch(_phase)
	{
		case PHASE.start:
		{
			//Animation
			anim_sprite = spr_uspec0;	//REPLACE
			anim_frame = 0;
			anim_speed = 0;
			
			landing_lag = 25;
			set_speed(0, 0, false, false);
			attack_frame = 18;
			return;
		}
		//Startup
		case 0:
		{
			if (attack_frame == 0)
			{
				set_speed(0, -18, false, false);
				create_melee(30, 35, 0.8, 0.5, 3, 16.5, 0, 8, 80, 2, HITBOX_SHAPE.circle, 0, FLIPPER.autolink);
				attack_phase++;
				attack_frame = 10;
			}
			break;
		}
		//Rising hitbox
		case 1:
		{
			//Drift while rising
			if (stick_tilted(Lstick,DIR.horizontal))
			{
				hsp += 1 * stick_get_value(Lstick,DIR.horizontal);
			}
			if (facing == 1)
			{
				hsp = clamp(hsp, 1, 3);
			}
			else
			{
				hsp = clamp(hsp, -3, -1);
			}
			
			if (attack_frame >= 0)
			{
				create_melee(30, -20, 0.6, 0.4, 6, -1 * (attack_frame - 18), 0, 8, 88, 9, HITBOX_SHAPE.circle, 0, FLIPPER.autolink);
				create_melee(10, -20, 0.3, 0.4, 6, -1 * (attack_frame - 18), 0, 8, 88, 9, HITBOX_SHAPE.circle, 0, FLIPPER.autolink);
			}
			if(attack_frame == 0)
			{
				if (vsp < 0)
				{
					set_speed(0, 8, true, true);
				}
				
				attack_phase++;
				attack_frame = 28;
			}
			break;
		}
		//Swing
		case 2:
		{
			if !stick_tilted(Lstick, DIR.down) && check_ledge_grab() return;
			friction_gravity(air_friction * 0.5, grav, max_fall_speed);
			
			if (stick_tilted(Lstick,DIR.horizontal))
			{
				hsp += 1 * stick_get_value(Lstick,DIR.horizontal);
			}
			if (facing == 1)
			{
				hsp = clamp(hsp, -3, 3);
			}
			else
			{
				hsp = clamp(hsp, -3, 3);
			}
			//Drop
			if(attack_frame <= 16 && attack_frame >= 9 && button(INPUT.special, 8, true))
			{
				set_speed(0, 18, true, false);
				create_melee(10, 40, 0.6, 0.3, 6, 13, 0.3, 11, 270, 300, HITBOX_SHAPE.circle, 1);
				create_melee(33, 40, 0.3, 0.3, 6, 13, 0.3, 11, 55, 300, HITBOX_SHAPE.circle, 1);
				attack_phase++;
				attack_frame = 15;
			}
			//End attack
			if (attack_frame == 0)
			{
				attack_stop(PLAYER_STATE.helpless);
			}
			break;
		}
		//Falling hitbox
		case 3:
		{
			if !stick_tilted(Lstick, DIR.down) && check_ledge_grab() return;
			if(on_ground() && attack_phase == 3)
			{
				destroy_all_attached_hitboxes(my_hitboxes);
				set_speed(0, 0, false, false);
				create_melee(30, 35, 0.8, 0.5, 2, 12, 0.3, 10, 60, 3, HITBOX_SHAPE.circle, 2);
				//if(facing == 1)
					//var proj = custom_projectile(obj_kirby_cutterwave, 30, 30, 1, 1, 3, 5, 0.3, 45, 5, HITBOX_SHAPE.circle, 10*facing, 0, FLIPPER.sakurai);
				//else if(facing == -1)
					//var proj = custom_projectile(obj_kirby_cutterwave, 30, 30, 1, 1, 3, 5, 0.3, 45, 5, HITBOX_SHAPE.circle, -10*facing, 0, FLIPPER.sakurai);
				//proj.grav = 0;
				//proj.base_hitlag = 10;
				attack_phase++;
				attack_frame = 34;
			}
			break;
		}
		//Release Wave
		case 4:
		{
			if(attack_frame == 0)
			{
				attack_stop(PLAYER_STATE.idle);
			}
			break;
		}
	}
}

//Movement
move_();