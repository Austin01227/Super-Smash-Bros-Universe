//Forward Tilt for character0
var run = true;
var _phase = argument_count > 0 ? argument[0] : attack_phase;
//Timer
attack_frame = max(--attack_frame, 0);
if (on_ground())
{
	friction_gravity(ground_friction);
}
else
{
	friction_gravity(air_friction * 0.5, grav, max_fall_speed);
}
//Phases
if (run)
{
	switch(_phase)
	{
		case PHASE.start:
		{
			//Animation
			anim_sprite = spr_fspec0;
			anim_speed = 0;
			anim_frame = 0;
		
			attack_frame = 7;
			return;
		}
		//Active
		case 0:
		{
			if (attack_frame == 0)
			{
				//Animation
				anim_frame = 1;
			
				attack_phase++;
				attack_frame = 6;
				
				if(!on_ground())
				{
					set_speed(-0.5*hsp, -8, true, false);
				}
				
				create_melee(35, 2, 1.1, 0.6, 6, 9, 0.3, 5, 90, 3, HITBOX_SHAPE.circle, 0);
			}
			break;
		}
		//Endlag
		case 1:
		{
			//if(attack_has_hit() && attack_frame <= 6 && attack_frame >= 4)
			//{
				//var inst = instance_position(mouse_x, mouse_y, all);
				//if(instance_exists(inst))
				//{
					//if(inst.direction < 90)
					//{
						//create_melee(35, 2, 1.1, 0.6, 0, 0.001, 0, 0, 45, 100, HITBOX_SHAPE.circle, 1, FLIPPER.sakurai);
					//}
					//else
					//{
						//create_melee(35, 2, 1.1, 0.6, 0, 0.001, 0, 0, 125, 500, HITBOX_SHAPE.circle, 1, FLIPPER.sakurai);
					//}
				//}
			//}
			
			if(attack_has_hit() && on_ground())
			{
				attack_phase++;
				attack_frame = 10;
			}
				
			//Animation
			if (attack_frame == 4)
				anim_frame = 2;
				
			if (attack_frame == 0)
			{
				//Animation
				anim_frame = 3;
			
				attack_phase++;
				attack_frame = 22;
			}
			break;
		}
		//Finish
		case 2:
		{
			//Animation
			if (attack_frame == 11)
				anim_frame = 4;
			
			if (attack_frame == 0 && on_ground())
			{
				attack_stop(PLAYER_STATE.idle);
			}
			if(attack_frame == 0 && !on_ground())
			{
				attack_stop(PLAYER_STATE.aerial);
			}
			
			break;
		}
	}
}

//Movement
move_();