//Up Aerial
var run = true;
var _phase = argument_count > 0 ? argument[0] : attack_phase;
//Timer
attack_frame = max(--attack_frame, 0);
friction_gravity(air_friction, grav, max_fall_speed);
fastfall_attack_try();
allow_hitfall();
aerial_drift();
//Canceling
if run && cancel_ground_check() run = false;

//Phases
if (run)
	{
	switch(_phase)
		{
		case PHASE.start:
			{
			//Animation
			anim_sprite = spr_uair_joker;
			anim_speed = 0;
			anim_frame = 0;
			landing_lag = 12;
			set_speed(0, -1, true, true);
			attack_frame = 4;
			return;
			}
		//Startup -> Active
		case 0:
			{
			if (attack_frame == 2)
				anim_frame = 1;
				
			if (attack_frame == 0)
				{
				anim_frame = 2;
			
				attack_phase++;
				attack_frame = 13;
				var _hitbox = create_melee(2, -10, 0.4, 0.8, 1, 4, 0.1, 4, 80, 12, HITBOX_SHAPE.rectangle, 0, FLIPPER.autolink);
				set_hitbox_property(_hitbox, HITBOX_PROPERTY.hit_sfx, [snd_hit_weak, snd_hit_weak2]);
				}
			break;
			}
		//Active -> Endlag
		case 1:
			{
			//Animation
			if (attack_frame % 2 == 0)
				{
				anim_frame++;
				}
				
			if (attack_frame % 3 == 0)
				{
				//Re-hit
				reset_hitbox_group(0, 0);
				}
				
			if (attack_frame == 0)
				{
				//Animation
				anim_frame = 9;
				//Final hit
				var _hitbox = create_melee(2, -10, 0.45, 0.9, 4, 9, 0.8, 11, 80, 3, HITBOX_SHAPE.rectangle, 1);
				set_hitbox_property(_hitbox, HITBOX_PROPERTY.hit_sfx, [snd_hit_strong, snd_hit_strong2]);
				landing_lag = 4;
				attack_phase++;
				attack_frame = attack_has_hit() ? 6 : 18;
				}
			break;
			}
		//Finish
		case 2:
			{
			//Animation
			if (attack_frame == 8)
				anim_frame = 10;
			if (attack_frame == 9)
				anim_frame = 11;
				
			if (attack_frame == 0)
				{
				attack_stop(PLAYER_STATE.aerial);
				}
			break;
			}
		}
	}
//Movement
move_();