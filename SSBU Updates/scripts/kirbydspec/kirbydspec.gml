//Down Special for Kirby
var run = true;
var _phase = argument_count > 0 ? argument[0] : attack_phase;
//Timer
attack_frame=max(--attack_frame,0);
friction_gravity(ground_friction,grav,max_fall_speed);
//Phases
if (run)
{
	switch(_phase)
		{
		case PHASE.start:
		{
			//Animation
			anim_sprite = spr_mariodspec;	//REPLACE
			anim_speed = 0;
			anim_frame = 0;
		
			if(on_ground())
			{
				attack_frame = 14;
				attack_phase = 2;
			}
			else if	(!on_ground())
				attack_frame = 17;
			return;
		}
		//Startup
		case 0:
		{
			if(attack_frame <= 14 && attack_frame >= 1)
				set_speed(0, 0, false, false);
			if(attack_frame == 5)
				set_invulnerable(INV.superarmor, 300);
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 2;
				create_melee(0, 0, 1, 1, 16, 10, 0.4, 13, 60, 300, HITBOX_SHAPE.circle, 0);
			}
			break;
		}
		//Drop
		case 1:
		{
			if (attack_frame == 0)
			{
				set_speed(0, 16, true, false);
				attack_phase++;
				attack_frame = 300;
			}
			break;
		}
		//Land
		case 2:
		{
			if(on_ground())
			{
				destroy_all_attached_hitboxes(my_hitboxes);
				create_melee(0, 30, 1.1, 0.8, 9, 13, 0.2, 13, 40, 3, HITBOX_SHAPE.circle, 1, FLIPPER.from_player_center_horizontal);
				attack_phase++;
				attack_frame = 180;
			}
			if(!on_ground() && attack_frame <= 260 && button(INPUT.special, 1, true))
			{
				destroy_all_attached_hitboxes(my_hitboxes);
				set_invulnerable(INV.normal, 40);
				attack_phase = 4;
				attack_frame = 40;
			}
		}
		//Pop out
		case 3:
		{
			if(attack_frame <= 140 && button(INPUT.special, 1, true))
			{
				set_invulnerable(INV.normal, 40);
				anim_frame = 3;
				attack_phase++;
				attack_frame = 45;
			}
			if(attack_frame == 0)
			{
				anim_frame = 2;
				attack_phase++;
				attack_frame = 45;
			}
		}
		case 4:
		{
			if(attack_phase == 4)
				set_speed(0, 0, false, false);
			if (attack_frame == 0)
			{
				if(on_ground())
					attack_stop(PLAYER_STATE.idle);
				else if (!on_ground())
					attack_stop(PLAYER_STATE.aerial);
			}
			break;
		}
	}
}

//Movement
move_();