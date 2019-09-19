//Side Special for Kirby
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
aerial_drift();
//Phases
if (run)
{
	switch(_phase)
	{
		case PHASE.start:
		{
			//Animation
			anim_sprite = spr_fspec0;	//REPLACE
			anim_speed = 0;
			anim_frame = 0;
			charge = 0;
			
			attack_frame = 6;
			return;
		}
		//CGround/Air
		case 0:
		{
			if(attack_frame == 0)
			{
				if(on_ground())
				{
					attack_phase++;
					attack_frame = 8;
				}
				else if(!on_ground())
				{
					attack_phase = 2;
					attack_frame = 30;
				}
			}
			break;
		}
		//Charge
		case 1:
		{
			if(attack_phase == 1)
				set_speed(stick_get_value(Lstick, DIR.horizontal) * 2, 0, false, true);
			charge++;
			if (!button_hold(INPUT.special, 1))
			{
				attack_phase = 3;
				attack_frame = 10;
			}
			break;
		}
		//Aerial Swing
		case 2:
		{
			if(on_ground())
			{
				attack_phase = 4;
				attack_frame = 15;
			}
			
			if(attack_frame == 28)
				create_melee(-50, 0, 0.6, 0.6, 5, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
			if(attack_frame == 26)
				create_melee(-25, -40, 0.6, 0.6, 5, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
			if(attack_frame == 24)
				create_melee(25, -29, 0.6, 0.6, 5, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
			if(attack_frame == 22)
				create_melee(29, 15, 0.6, 0.6, 5, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
			if(attack_frame == 20)
				create_melee(-15, 40, 0.6, 0.6, 5, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 0, FLIPPER.sakurai);
			if(attack_frame == 18)
				create_melee(-50, 0, 0.6, 0.6, 4, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 1, FLIPPER.sakurai);
			if(attack_frame == 16)
				create_melee(-25, -40, 0.6, 0.6, 4, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 1, FLIPPER.sakurai);
			if(attack_frame == 14)
				create_melee(25, -29, 0.6, 0.6, 4, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 1, FLIPPER.sakurai);
			if(attack_frame == 12)
				create_melee(29, 15, 0.6, 0.6, 4, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 1, FLIPPER.sakurai);
			if(attack_frame == 10)
				create_melee(-15, 40, 0.6, 0.6, 4, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 1, FLIPPER.sakurai);
			if(attack_frame == 8)
				create_melee(-50, 0, 0.6, 0.6, 3, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 2, FLIPPER.sakurai);
			if(attack_frame == 6)
				create_melee(-25, -40, 0.6, 0.6, 3, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 2, FLIPPER.sakurai);
			if(attack_frame == 4)
				create_melee(25, -29, 0.6, 0.6, 3, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 2, FLIPPER.sakurai);
			if(attack_frame == 2)
				create_melee(29, 15, 0.6, 0.6, 3, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 2, FLIPPER.sakurai);
			if(attack_frame == 0)
			{
				create_melee(-15, 40, 0.6, 0.6, 3, 6, 0.4, 10, 45, 2, HITBOX_SHAPE.circle, 2, FLIPPER.sakurai);
				attack_phase = 4;
				attack_frame = 45;
			}
			break;
		}
		//Grounded Swing
		case 3:
		{
			if(charge > 180)
				charge = 180;
			if(attack_frame == 2)
			{
				var _damage = calculate_smash_damage(15, charge, 180, 1);
				var _hitbox = create_melee(10, 15, 0.4, 0.4, _damage, 13, 0.5, 15, 50, 3, HITBOX_SHAPE.circle, 0);
			}
			if(attack_frame == 1)
			{
				var _damage = calculate_smash_damage(15, charge, 180, 1);
				var _hitbox = create_melee(30, 0, 0.8, 0.8, _damage, 13, 0.5, 15, 50, 5, HITBOX_SHAPE.circle, 0);
			}
			if (attack_frame == 0)
			{
				var _damage = calculate_smash_damage(15, charge, 180, 1);
				var _hitbox = create_melee(20, -20, 0.7, 0.7, _damage, 13, 0.5, 15, 50, 4, HITBOX_SHAPE.circle, 0);
				
				attack_phase++;
				attack_frame = 30;
			}
		}
		//Finish
		case 4:
		{
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