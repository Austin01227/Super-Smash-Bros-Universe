//Dash Attack for Kirby (Yoyo Whip / Burning)
/*
	checks for held attack button after 5 frames
	if held, does Burning instead of Yoyo Whip
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
			anim_sprite = spr_dashattack0;	//REPLACE
			anim_speed = 0;
			anim_frame = 0;
		
			//Startup lag
			attack_frame = 6;
			return;
		}
		//Startup -> Active
		case 0:
		{
			//Burning Check
			if(attack_frame == 1)
			{
				if(button_hold(INPUT.attack))
				{
					attack_phase = 3;
					attack_frame = 22;
					break;
				}
			}
			//Yoyo Whip
			if (attack_frame==0)
			{
				attack_phase++;
				attack_frame = 13;
				var _hitbox = create_melee(0, 0, 1, 1, 1, 4, 0, 5, 45, 1, HITBOX_SHAPE.circle, 0, FLIPPER.autolink);
				//set weak hit
			}
			break;
		}
		//Active -> Endlag
		case 1:
		{
			set_speed(sign(facing)*5.5, 0, false, false);

			if(attack_frame % 4 == 0 && attack_frame != 0)	//Multihit (4 hits/4 frames)
			{
				reset_hitbox_group(collided, 0);
				create_magnetbox(0, 0, 1, 1, 1, 4, 30, 1, 15, 2, HITBOX_SHAPE.circle, 0);
			}
			if (attack_frame == 0)	//Final hit
			{
				var _hitbox = create_melee(0, 0, 1, 1, 4, 10, 0.4, 8, 45, 2, HITBOX_SHAPE.circle, 1);
				attack_phase++;
				attack_frame = 15;	//Endlag
			}
			break;
		}
		//Yoyo finish
		case 2:
		{
			if (attack_frame == 0)
			{
				attack_stop(PLAYER_STATE.idle);
			}
			break;
		}
		//Burning
		case 3:
		{
			if(attack_frame > 18)
			{
				set_speed(sign(facing)*10, 0, false, false);
			}
			if(attack_frame == 18)	//Sweetspot
			{
				create_melee(0, 0, 1, 1, 12, 10, 0.5, 10, 45, 2, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
			}
			if(attack_frame == 15)	//Mid hit
			{
				create_melee(0, 0, 1, 1, 8, 8, 0.5, 6, 50, 2, HITBOX_SHAPE.circle, 0);
			}
			if(attack_frame < 15)
			{
				set_speed(sign(facing)*6, 0, false, false);
			}
			if(attack_frame == 12)	//Sourspot
			{
				create_melee(0, 0, 1, 1, 6, 8, 0.25, 5, 60, 4, HITBOX_SHAPE.circle, 0);
			}
			//if(attack_frame == 8)
				//{
				//set_speed(sign(facing)*2, 0, false, false);
				//}
			if(attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 15;
			}
			break;
		}
		//Burning finish
		case 4:
		{
			set_speed(sign(facing)*2, 0, false, false);
			if(attack_frame == 0)
			{
				attack_stop(PLAYER_STATE.idle);
			}
			break;
		}
	}
}
//Movement
move_grounded_();