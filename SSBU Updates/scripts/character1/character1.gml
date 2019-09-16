///Sets all of the variables for a single character
show_debug_message("LUIGI")
name = "Luigi";
//Collision box
mask_index = spr_collision_mask_medium;
//Hurtbox
hurtbox_sprite = spr_hurtbox_large;
hurtbox_crouch_sprite = spr_hurtbox_large_crouch;
hurtbox = create_hurtbox(hurtbox_sprite);
//Color Palettes
palette_sprite = spr_palette0;
portrait = spr_luigiportrait0;
render = spr_luigirender0;
stock_sprite = spr_luigistock0;
//Weight
weight_multiplier = .95;
//Gravity
grav = 0.4;
hitstun_grav = 0.4;
//Falling
max_fall_speed = 9;
fast_fall_speed = 12;
//Jumping
jumpsquat_time = 3;
jump_speed = 13.5;
shorthop_speed = 6.5;
double_jump_speed = 11;
max_double_jumps = 1;
land_time = 4;
//Aerial Movment
air_accel = 0.3;
max_air_speed = 4;//5
max_air_speed_dash = 6.5;
air_friction = 0.04;
//Ground Movement
ground_friction = 0.20;
crouch_friction = 1;
slide_friction = 0.15;
hard_landing_friction = 0.5;
//Walking
walk_speed = 3.25;
walk_accel = 0.5;
walk_turn_time = 6;
//Dashing
dash_speed = 9;
dash_time = 10;
dash_accel = 4;
//Running
run_speed = 6;
run_accel = 0.8;
run_turn_time = 10;
run_turn_accel = 0.8;
run_stop_time = 8;
//Ledges
ledge_jump_vsp = 12;
ledge_jump_hsp = 2;
ledge_jump_time = 12;
ledge_jump_finish_x = 40;
ledge_jump_finish_y = -46;
ledge_getup_time = 23;
ledge_getup_finish_x = 48;
ledge_getup_finish_y = -46;
ledge_roll_time = 12;
ledge_roll_finish_x = 40;
ledge_roll_finish_y = -46;
ledge_attack_time = 12;
ledge_attack_finish_x = 40;
ledge_attack_finish_y = -46;
//Some characters would not appear to grab the ledge
//at the right spot due to sprite origin, so these
//variables allow you to add an offset.
ledge_hang_relative_x = -18;
ledge_hang_relative_y = 22;
//Air Dodge Values
switch(airdodge_type)
{
	//Melee / Rivals Air Dodge
	case AIRDODGE.melee:
	{
		air_dodge_speed = 8;
		air_dodge_startup = 2;
		air_dodge_active = 10;
		air_dodge_endlag = 12;
		waveland_speed_boost = 1;
		waveland_time = 8;
		waveland_friction = 0.05;
		break;
	}
	//Smash 4 Air Dodge
	/*
	case AIRDODGE.smash4:
	{
		air_dodge_startup = 2;
		air_dodge_active = 18;
		air_dodge_endlag = 10;
		air_dodge_land_time = 12;
		air_dodge_accel = 0.2;
		break;
	}
	//*/
	default: break;
}
//Shield Values
switch(shield_type)
	{
	//Mele Shield
	case SHIELD.melee:
		{
		shield_max_hp = 55;
		shield_hp = shield_max_hp;
		shield_depeletion_rate = 0.14;
		shield_recover_rate = 0.28;
		shield_break_speed = 13;
		shield_break_reset_hp = 25;
		shield_stun = 0;
		shield_size_multiplier = 1;
		shield_shift_amount = 10;
		spot_dodge_startup = 2;
		spot_dodge_active = 20;
		spot_dodge_endlag = 5;
		break;
		}
	//Rivals Parry
	case SHIELD.rivals:
		{
		parry_startup = 2;
		parry_active = 8;
		parry_endlag = 20;
		parry_trigger_time = 15;
		parry_script = parry0;
		break;
		}
	/*
	//Ultimate Shield
	case SHIELD.ultimate:
		{
		shield_hp = 90;
		shield_recover_rate = 0.5;
		shield_jump = 9;
		shield_stun = 0;
		shield_max_hp = 900;
		spot_dodge_startup = 6;
		spot_dodge_active = 12;
		spot_dodge_endlag = 12;
		break;
		}
	//*/
	default: break;
	}
//Walljump Values
switch(walljump_type)
{
	//Rivals of Aether
	case WALLJUMP.rivals:
	{
		wall_jump_startup = 2;
		wall_jump_time = 12;
		wall_jump_hsp = 7;
		wall_jump_vsp = -8;
		max_wall_jumps = 1;
		can_wall_cling = true;
	}
	default: break;
}
//*/
//Rolling
roll_speed = 9;
roll_startup = 3;
roll_active = 14;
roll_endlag = 8;
//Teching
tech_active = 16;
tech_endlag = 6;
techroll_speed = 10;
techroll_startup = 8;
techroll_active = 12;
techroll_endlag = 16;
//Helpless
helpless_accel = 0.4;
helpless_max_speed = 1;
//Attacks
my_attacks[?"Jab"	] = luigijab0;
my_attacks[?"DashA" ] = luigidashattack0;
my_attacks[?"Ftilt" ] = luigiftilt0;
my_attacks[?"Utilt" ] = luigiutilt0;
my_attacks[?"Dtilt" ] = luigidtilt0;
my_attacks[?"Fsmash"] = luigifsmash0;
my_attacks[?"Usmash"] = luigiusmash0;
my_attacks[?"Dsmash"] = luigidsmash0;
my_attacks[?"Nair"	] = luiginair0;
my_attacks[?"Fair"	] = luigifair0;
my_attacks[?"Bair"	] = luigibair0;
my_attacks[?"Uair"	] = luigiuair0;
my_attacks[?"Dair"	] = luigidair0;
my_attacks[?"Nspec" ] = luiginspec;
my_attacks[?"Fspec" ] = luigifspec0;
my_attacks[?"Uspec" ] = luigiuspec0;
my_attacks[?"Dspec" ] = luigidspec0;
my_attacks[?"Grab"	] = luigigrab0;
my_attacks[?"DashG"	] = luigidash_grab0;
my_attacks[?"Pummel"] = luigipummel0;
my_attacks[?"Zair"	] = luigizair0;
my_attacks[?"FThrow"] = luigifthrow0;
my_attacks[?"BThrow"] = luigibthrow0;
my_attacks[?"UThrow"] = luigiuthrow0;
my_attacks[?"DThrow"] = luigidthrow0;
my_attacks[?"LedgeA"] = luigiledgeattack0;
my_attacks[?"Taunt" ] = luigitaunt0;
//Animations / Sprites
sprite_scale = 2;
my_sprites[?"Idle"		] = spr_luigiidle0;
my_sprites[?"Crouch"	] = spr_luigicrouch0;
my_sprites[?"Walk"		] = s_luigiwalk0;
my_sprites[?"Run"		] = s_luigirun0;
my_sprites[?"Run_Stop"	] = s_luigirun_stop0;
my_sprites[?"JumpS"		] = spr_luigijumpsquat0;
my_sprites[?"Jump"		] = s_luigijump0;
my_sprites[?"JumpMid"	] = spr_luigijump_midair;
my_sprites[?"Midair"	] = spr_luigimidair0;
my_sprites[?"Fall"		] = spr_luigifall0;
my_sprites[?"Fastfall"	] = spr_luigifastfall0;
my_sprites[?"Airdodge"	] = spr_luigiairdodge0;
my_sprites[?"Waveland"	] = spr_luigiwaveland0;
my_sprites[?"Rolling"	] = s_luigiroll0; 
my_sprites[?"Techroll"	] = s_luigiroll0; 
my_sprites[?"Teching"	] = spr_luigiidle0;
my_sprites[?"Hitlag"	] = s_luigihitlag0;
my_sprites[?"Hitstun"	] = s_luigihitstun0;
my_sprites[?"Tumble"	] = s_luigitumble0;
my_sprites[?"Helpless"	] = s_luigihelpless0;
my_sprites[?"Lag"		] = spr_luigicrouch0;
my_sprites[?"Shield"	] = s_luigishield0;
my_sprites[?"ShieldB"	] = spr_luigishield_break0;
my_sprites[?"ParryS"	] = spr_parry_stun0;
my_sprites[?"SDodge"	] = spr_luigispot_dodge0;
my_sprites[?"LedgeS"	] = spr_luigiledge_snap0;
my_sprites[?"Ledge"		] = spr_luigiledge_hang0;
my_sprites[?"LedgeG"	] = spr_luigiledge_getup0;
my_sprites[?"LedgeJ"	] = spr_luigiledge_jump0;
my_sprites[?"LedgeR"	] = spr_luigiledge_jump0;
my_sprites[?"LedgeA"	] = spr_luigiledge_attack_getup0;
my_sprites[?"LedgeT"	] = spr_luigiledge_hang0
my_sprites[?"LedgeTr"	] = spr_luigiledgetrump;
my_sprites[?"WallC"		] = spr_wall_cling0;
my_sprites[?"WallJ"		] = spr_wall_jump0;
my_sprites[?"Grabbing"	] = spr_luigigrabbing0;
my_sprites[?"Entrance"	] = spr_luigientrance0;
//Custom Step Event
custom_script = custom0;