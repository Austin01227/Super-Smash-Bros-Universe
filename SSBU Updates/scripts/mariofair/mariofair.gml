//Forward Aerial
var run = true;
var _phase = argument_count > 0 ? argument[0] : attack_phase;
//Timer
attack_frame=max(--attack_frame,0);
//Actions
friction_gravity(air_friction,grav,max_fall_speed);
fastfall_attack_try();
allow_hitfall();
aerial_drift();
//Cancels
if run && cancel_ground_check()	run = false;
//Main Phases
if (run)
{
	switch(_phase)
	{
		case PHASE.start:
		{
			anim_sprite = spr_mariofair;
			anim_frame = 0;
			anim_speed = 0;
			landing_lag=10;
			set_speed(0, -1, true, true);
			attack_frame = 16;
			return;
		}
		//Active
		case 0:
		{
			//Animation
			if (attack_frame == 10)
				anim_frame = 1;
			if (attack_frame == 6)
			{
				anim_frame = 2;
				create_melee(15, -20, 0.4, 0.4, 6, 12, 0.4, 5, 60, 2, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
			}
			if (attack_frame = 4)
			{
				anim_frame = 3;
				var _hitbox1 = create_melee(56, -14, 0.5, 0.4, 13, 7.5, 0.75, 15, 300, 4, HITBOX_SHAPE.circle, 0);
				set_hitbox_property(_hitbox1, HITBOX_PROPERTY.hit_sfx, snd_hit_strong);
				create_melee(20, -4, 0.6, 0.8, 10, 8, 0.3, 6, 45, 7, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
			}
  
			if (attack_frame == 0)
			{
				//Animation
				anim_frame = 4;
				var _hitbox2 = create_melee(32, 19, 0.4, 0.4, 13, 7.5, 0.75, 15, 60, 3, HITBOX_SHAPE.circle, 0);
				set_hitbox_property(_hitbox2, HITBOX_PROPERTY.hit_sfx, snd_hit_strong);
				//Next phase
				attack_phase++;
				attack_frame = 10;
			}
			break;
		}
		//Endlag
		case 1:
		{
			//Animation
			if (attack_frame == 7)
			{
				anim_frame = 5;
				create_melee(3, 28, 0.4, 0.4, 8, 7.5, 0.75, 7, 45, 200, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
			}
			if (attack_frame == 0)
			{
				attack_phase++;
				attack_frame = 14;
			}
			break;
		}
		//Finish
		case 2:
		{
			//Animation
			if (attack_frame == 14)
				anim_frame = 2;
			if (attack_frame == 7)
				anim_frame = 1;	
			if (attack_frame == 0)
			{
				//Revert back to the original state
				attack_stop(PLAYER_STATE.aerial);
				}
			break;
		}
	}
}

 //Movement
move_();