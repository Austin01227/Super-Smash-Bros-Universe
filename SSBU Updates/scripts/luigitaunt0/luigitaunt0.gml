///Taunt for character0
var run = true;
var _phase = argument_count > 0 ? argument[0] : attack_phase;
//Timer
attack_frame = max(--attack_frame, 0);
friction_gravity(slide_friction);
//Cancel in air
if (run && cancel_air_check()) run = false;
//Phases
if (run)
    {
    switch(_phase)
        {
       case PHASE.start:
    {
    //Animation
    anim_sprite = spr_luigitaunt0
    anim_frame = 0;
    anim_speed = 0.5;
    attack_frame = (sprite_get_number(spr_luigitaunt0) * 10);

    //Final Attack
    anim_frame=0;

    //Hitbox
    var _hitbox = create_melee(0,20,0.6,0.7,2,10,1.2,30,270,20,HITBOX_SHAPE.circle,1);
    set_hitbox_property(_hitbox, HITBOX_PROPERTY.hit_sfx, snd_hit_strong2);
    return;
    }
        case 0:
            {
            //Taunt canceling
                if (run && check_walk()) run = false;
                if (run && check_dash()) run = false;
                if (run && check_crouch()) run = false;
                if (run && check_jump()) run = false;
                if (run && check_shield()) run = false;
                if (run && check_grounds()) run = false;
                if (run && check_aerials()) run = false;
                if (run && check_smashes()) run = false;
                if (run && check_specials()) run = false;
                if (run && check_grab()) run = false;
                if (!run)
                    {
                    attack_stop();
                    }
            
            if (run && attack_frame == 0)
                {
                attack_stop(PLAYER_STATE.idle);
                }
            break;
            }
        default: break;
        }
    }
move_();