//Neutral Aerial for character0
//Logic Control Variable
var run = true;
var _phase = argument_count > 0 ? argument[0] : attack_phase;
anim_speed = 0.1
//Timer
attack_frame=max(--attack_frame,0);
//Actions
friction_gravity(air_friction,grav,max_fall_speed);
//fastfall_attack_try();
aerial_drift();
//allow_hitfall();
//Main Phases
if (run)
{
	switch(_phase)
	{
		//Initialize
		case PHASE.start:
		{
			//Animation
			anim_sprite = spr_run_stop0;
			anim_speed = 0;
			anim_frame = 3;
			landing_lag = 15;
			attack_frame = 12;
			set_speed(0, -1, true, true);
			return;
		}
		//Startup
		case 0:
		{
			if(attack_frame <= 12 && attack_frame >= 7 && on_ground())
			{
				set_speed(0, 0, false, false);	
			}
			
			if(attack_frame == 6)
				anim_frame = 1;
			if (attack_frame == 3)
			{
				
				if(!on_ground(self.x, self.y + 20))
				{
					set_speed(0.5 * facing, -5, false, false);
				}
				
				anim_sprite = spr_mariodspec;
				anim_frame = 0;
			}
			if (attack_frame == 0)
			{
				anim_frame = 1;
				create_melee(0, 0, 1.5, 0.8, 12, 10, 0.6, 10, 50, 2, HITBOX_SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
				
				attack_frame = 14;
				attack_phase++;
			}
			break;
		}
		//Active
		case 1:
		{
			if (attack_frame == 12)
			{
				anim_frame = 2;
				create_melee(0, 0, 1.5, 0.8, 8, 9, 0.6, 4, 50, 4, HITBOX_SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
			}
			if (attack_frame == 10)
			{
				anim_frame = 3;
			}
			if (attack_frame == 8)
			{
				anim_frame = 4;
				create_melee(0, 0, 1.5, 0.8, 8, 5, 0.6, 4, 50, 6, HITBOX_SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
			}
			if (attack_frame == 6)
			{
				anim_frame = 5;
			}
			if (attack_frame == 3)
			{
				anim_frame = 6;
				create_melee(0, 0, 1.5, 0.8, 6, 5, 0.6, 4, 50, 3, HITBOX_SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
			}
			if (attack_frame == 0)
			{
				anim_frame = 7;
				attack_frame = 30;
				attack_phase++;
			}
			break;
		}
		//Endlag
		case 2:
		{
			if(attack_frame <= 27 && attack_frame > 0)
			{
				if(!on_ground(self.x, self.y + 20))
				{
					anim_sprite = spr_spot_dodge0;
					if(attack_frame % 12 == 0)
						anim_frame = 1;
					if(attack_frame % 12 == 3)
						anim_frame = 2;
					if(attack_frame % 12 == 6)
						anim_frame = 3;
					if(attack_frame % 12 == 9)
						anim_frame = 4;
				}
				else if(position_meeting(self.x, self.y + 20, all))
				{
					set_speed(0, 0, false, true);
					
					anim_sprite = spr_crouch0;
					anim_frame = 0;
				}
				else if (on_ground(self.x, self.y + 20))
				{
					set_speed(0, 0, false, true);
					
					anim_sprite = spr_run_stop0;
					if(attack_frame == 23)
						anim_frame = 1;
					if(attack_frame == 9)
						anim_frame = 2;
				}
			}
			
			if (attack_frame == 0)
			{
				if(on_ground())
				{
					attack_stop(PLAYER_STATE.idle);
				}
				else
				{
					attack_stop(PLAYER_STATE.aerial);
				}
			}
			break;
		}
	}
}

//Movement
move_();