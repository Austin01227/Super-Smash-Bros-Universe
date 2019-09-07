///Checks for grounded upward attacks
//If the player is on the ground
if (on_ground())
	{
	var _stick=Choose_Stick_By_Input(INPUT.attack);
	if (stick_tilted(_stick,DIR.up))
		{
		//Up Tilt
		if (button(INPUT.attack,buff))
			{
			//Change direction
			change_facing(_stick);
			attack_start(my_attacks[?"Utilt"]);
			return true;
			}
		}
		
	var _stick=Choose_Stick_By_Input(INPUT.smash);
	if (stick_tilted(_stick,DIR.up))
		{
		//Up Smash
		if (button(INPUT.smash,buff) ||
			(scs_AB_smash && button(INPUT.attack,buff,false) && button(INPUT.special,buff,false)))
			{
			//Change direction
			change_facing(_stick);
			attack_start(my_attacks[?"Usmash"]);
			return true;
			}
		}
		
	var _stick=Choose_Stick_By_Input(INPUT.special);
	if (stick_tilted(_stick,DIR.up))
		{
		//Up Special
		if (button(INPUT.special,buff))
			{
			//Change direction
			change_facing(_stick);
			attack_start(my_attacks[?"Uspec"]);
			return true;
			}
		}
	}
return false;