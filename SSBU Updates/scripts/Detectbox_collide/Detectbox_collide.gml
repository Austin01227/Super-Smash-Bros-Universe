///@func Detectbox_Collide(id)
///@param id
//All of the actions that happen when a melee hitbox comes into contact with a hurtbox
//Exit out early if it is the owner or if it is a detached hurtbox
var _hurtbox = argument[0];
var _hit = _hurtbox.player;
if (_hit == noone || _hit == owner) return;

//Mark the hitbox as having hit something
has_hit = true;
owner.any_hitbox_has_hit = true;

//Get the hitbox group list
var _col_list = owner.collided[| hitbox_group];

//Check the id's
//The hitbox cannot hit someone who has already been hit.
//Now loop through the collided list to ensure the target has not been hit already
for(var i= 0 ; i < ds_list_size(_col_list); i++)
	{
	//If the target had been hit before, the whole script ends
	if (_hit == _col_list[| i])
		{
		return;
		}
	}
	
//Check invulnerability
switch(_hit.invulnerable_type)
	{
	case INV.shielding:
	case INV.counter:
	case INV.parry:
	case INV.invincible:
	case INV.superarmor:
	case INV.normal:
		{
		//Add the other player to the collided list
		ds_list_add(_col_list,_hit);
		
		//Run the attack's detection phase
		with(owner) 
			{
			script_execute(attack_script, PHASE.detection, _hit);
			}
		break;
		}
	default: break;
	}