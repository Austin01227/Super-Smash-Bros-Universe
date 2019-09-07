///Checks for throws
var _stick = Lstick;
//Up Throw
if (stick_get_value(_stick, DIR.up) < -stick_flick_amount)
	{
	attack_start(my_attacks[?"UThrow"]);
	return true;
	}
else
//Down Throw
if (stick_get_value(_stick, DIR.down) > stick_flick_amount)
	{
	attack_start(my_attacks[?"DThrow"]);
	return true;
	}
else
//Forward Throw / Backward Throw
	{
	//Is the control stick in the direction the player is facing?
	if (abs(stick_get_value(_stick, DIR.horizontal)) > stick_flick_amount)
		{
		if (sign(stick_get_value(_stick, DIR.horizontal)) == sign(facing))
			{
			attack_start(my_attacks[?"FThrow"]);
			return true;
			}
		else
			{
			attack_start(my_attacks[?"BThrow"]);
			return true;
			}
		}
	}
return false;