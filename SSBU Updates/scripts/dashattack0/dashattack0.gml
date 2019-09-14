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
			//Startup
			//Animation
			anim_sprite = spr_dashattack0;
			anim_speed = 0;
			anim_frame = 0;
			
			attack_frame = 6;
			return;
			}
		//Startup -> Active
		case 0:
			{
			//Animation
			if (attack_frame == 8)
				anim_frame = 1;
			if (attack_frame == 6)
				anim_frame = 2;
			if (attack_frame == 4)
				anim_frame = 3;
			if (attack_frame == 2)
				anim_frame = 4;
			if (attack_frame==0)
				{
				//Animation
				anim_frame = 5;
			
				attack_phase++;
				attack_frame = 3;
				create_melee(30, 25, 1.2, 0.5, 9, 8, 0.6, 9, 45, 3, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
				}
			break;
			}
		//Active
		case 1:
			{
			//Animation
			if (attack_frame % 3 == 0)
				anim_frame++;
			if (anim_frame > 6)
				{
				//Animation
				anim_frame = 4;
				anim_frame = 8;
				
				set_speed(sign(facing)*8, 0, false, false);
				}
			if(attack_frame == 0)
				{
				attack_phase++;
				attack_frame = 14;
				create_melee(30, 25, 0.8, 0.4, 6, 6, 0.6, 6, 50, 2, HITBOX_SHAPE.circle, 0);
				}
			break;
			}
		//Active -> Endlag
		case 2:
			{
			set_speed(sign(facing)*5, 0, false, false);
			
			//Animation
			if (attack_frame == 5)
				anim_frame = 9;
				
			if (attack_frame == 0)
				{
				//Animation
				anim_frame = 10;
			
				attack_phase++;
				attack_frame = attack_has_hit() ? 5 : 14;
				}
			break;
			}
		//Finish
		case 3:
			{
			//Friction
			friction_gravity(0.7);
			
			//Animation
			if (attack_frame<8)
				anim_frame=11;
			
			if (attack_frame==0)
				{
				attack_stop(PLAYER_STATE.idle);
				}
			break;
			}
		}
	}
//Movement
move_grounded_();