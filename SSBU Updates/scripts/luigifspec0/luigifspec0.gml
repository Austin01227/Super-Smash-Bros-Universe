//Neutral Special for character0
/*
- Hold the button to charge the attack
- The attack's movement angle changes the more you charge it
*/
var run = true;
var _phase = argument_count > 0 ? argument[0] : attack_phase;
//Timer
attack_frame=max(--attack_frame,0);
//Main Phases
if (run)
	{
	switch(_phase)
		{
		case PHASE.start:
			{
			//Startup
			anim_sprite=spr_luigifspec0;
			anim_speed=0;
			anim_frame=0;
			
			landing_lag =40;
			attack_frame=10;
			charge=0;
			set_speed(0,0,false,false);
			return;
			}
		//Startup
		case 0:
			{
			friction_gravity(air_friction,0.2,2);
			if (attack_frame==0)
				{
				//Charge or no charge
				if (button_hold(INPUT.special,1))
					{
					attack_phase=1;
					attack_frame=10;
					}
				else
					{
					attack_phase=2;
					attack_frame=22;
					//Animation
					anim_frame=3;
					//Lunge
					change_facing();
					set_speed(9*facing,-3,false,false);
					}
				}
			break;
			}
		//Charging
		case 1:
			{
			friction_gravity(air_friction,0.2,6);
			//Animation
			if (attack_frame==9)
				anim_frame=1;
			if (attack_frame==0)
				anim_frame=2;
			
			charge++;
			if (!button_hold(INPUT.special,1) || charge > 60)
				{
				attack_phase=2;
				attack_frame=22;
				//Animation
				anim_frame=3;
				//Lunge
				change_facing();
				set_speed(clamp(charge/3,10,18)*facing,-9+clamp(charge/12,0,5),false,false);
				fx_create(spr_hit_fx_launch,1,0,10,x,y,2,0,"FX_Layer_Below");
				}
			else
			//Opt out
			if charge>10 && check_airdodge() run = false;
			break;
			}
		//Lunge
		case 2:
			{
			//Animation
			if (attack_frame==18)
				anim_frame=4;
			if (attack_frame==16)
				anim_frame=4;
			if (attack_frame<=14 && attack_frame % 2 == 0)
				{
				anim_frame++;
				if (anim_frame > 9)
					anim_frame=6;
				}
			
			friction_gravity(air_friction,grav,10);
			
			if (attack_frame=1)
				{
				//Animation
				attack_phase++;
				anim_frame=4;
				set_speed(3*facing,-2,false,true);
				//Initial hit
				var _hitbox = create_melee(30,-28,1,0.9,10,7,0.9,10,82,2,HITBOX_SHAPE.circle,1);
				set_hitbox_property(_hitbox, HITBOX_PROPERTY.hit_sfx, snd_hit_strong2);
				}
			
			if (attack_frame==0)
				{
				//Final Attack
				attack_phase++;
				attack_frame=10;
				anim_frame=10;
				set_speed(3*facing,-2,false,true);
				//Hitbox
				var _hitbox = create_melee(35,0,0.6,0.7,10,9,0.8,15,65,20,HITBOX_SHAPE.circle,1);
				set_hitbox_property(_hitbox, HITBOX_PROPERTY.hit_sfx, snd_hit_strong2);
				}
			break;
			}
		//Attack & Finish
		case 3:
			{
			//Animation
			if (attack_frame==6)
				anim_frame=11;
			if (attack_frame==3)
				anim_frame=12;
				
			if (attack_frame==0)
				{
				//Finish
				if (attack_has_hit())
					{
					set_state(PLAYER_STATE.aerial);
					}
				else
					{
					set_state(PLAYER_STATE.aerial);
					}
				}
			break;
			}
		}
	}
//Movement
move_();