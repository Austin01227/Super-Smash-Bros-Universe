//Neutral Special for Kirby
var run = true;
var _phase = argument_count > 0 ? argument[0] : attack_phase;
//Timer
attack_frame=max(--attack_frame,0);
//Actions
if (on_ground() && _phase == PHASE.start)
{
	set_speed(-0.35 * hsp, -0.75 * vsp, true, true);
	friction_gravity(ground_friction, grav, max_fall_speed);
}
else if (!on_ground() && _phase == PHASE.start)
{
	if((hsp < -1 || hsp > 1) && (vsp < -3 || vsp > 3))
		set_speed(-0.35 * hsp, -2, true, false);
}
//friction_gravity(air_friction, grav, max_fall_speed);
//aerial_drift();
//Phases
if (run)
{
	switch(_phase)
	{
		case PHASE.start:
		{
			anim_sprite = spr_fsmash0;	//REPLACE
			anim_speed = 0;
			anim_frame = 0;
			
			attack_frame = 12;
			return;
		}
		//Startup
		case 0:
		{
			if(attack_frame == 0)
			{
				attack_phase++;
			}
			break;
		}
		//Active
		case 1:
		{
			friction_gravity(0.25, 0.5);
			if (button_hold(INPUT.special, 1))
			{
				create_magnetbox(30, 0, 1.2, 1.2, 0, 0, 0, 0, 5, 1, HITBOX_SHAPE.rectangle, 0);
				if(attack_has_hit())
				{
					create_magnetbox(5, 0, 0.2, 1.2, 0, 0, 0, 0, 100, 10, HITBOX_SHAPE.rectangle, 1);
					if(attack_has_hit())
					{
						attack_phase = 3;
						attack_frame = 115;
					}
				}
				if(!on_ground())
					aerial_drift();
				else if(on_ground())
					set_speed(0, 0, false, false);
			}
			else
			{
				if(!on_ground() && vsp < -1)
					friction_gravity(air_friction, grav, max_fall_speed);
				create_magnetbox(30, 0, 1.2, 1.2, 0, 0, 0, 0, 5, 10, HITBOX_SHAPE.rectangle, 0);
				if(attack_has_hit())
				{
					create_magnetbox(5, 0, 0.2, 1.2, 0, 0, 0, 0, 100, 10, HITBOX_SHAPE.rectangle, 1);
					if(attack_has_hit())
					{
						attack_phase = 3;
						attack_frame = 115;
					}
				}
				attack_phase++;
				attack_frame = 15;
			}
			break;
		}
		//Endlag
		case 2:
		{
			if(!on_ground() && vsp < -2)
				friction_gravity(air_friction, grav, max_fall_speed);
			if (attack_frame == 0)
			{
				attack_phase = 4;
				attack_frame = 5;
			}
			break;
		}
		//Swallowed
		case 3:
		{
			if(attack_frame <= 100 && attack_frame != 0)
			{
				if(stick_tilted(Lstick, DIR.down))
				{
					create_melee(0, 0, 1, 1, 10, 15, 0, 10, 125, 3, HITBOX_SHAPE.circle, 2);
					attack_phase++;
					attack_frame = 15;
				}
				else if(button_hold(INPUT.attack))
				{
					create_melee(0, 0, 1, 1, 6, 25, 0, 15, 0, 3, HITBOX_SHAPE.circle, 2);
					attack_phase++;
					attack_frame = 15;
				}
			}
			if(attack_frame == 0)
			{
				create_magnetbox(0, 0, 1, 1, 0, 0, -20, -20, 2, 1, HITBOX_SHAPE.circle, 2);
				attack_phase++;
				attack_frame = 15;
			}
			break;
		}
		//Finish
		case 4:
		{
			if (attack_frame == 0)
			{
				attack_stop(PLAYER_STATE.idle);
			}
			break;
		}
	}
}
	
//Movement
move_();