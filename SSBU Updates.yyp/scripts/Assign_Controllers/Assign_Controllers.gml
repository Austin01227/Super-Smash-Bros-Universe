///@func Assign_Controllers()
//Assigns controllers to the player based on the global.device_number
//Additionally assigns custom controls
var _num = 0;
with(obj_player)
    {
    controller = real(global.device_number[_num]);
    player_number = _num;
    player_color = _num + 1; //Offset for palettes
	if global.selected_characters = 0
	{
		character0();
	}
	if global.selected_characters = 1
	{
		character1();
	}
    if (controller >= 0)
        {
        Custom_Controls_Load(cc, player_number);
        }
    else
        {
        Custom_Controls_Load(cc, 0);
        is_AI = true;
        }
    if (_num == 1)
        {
        uses_keyboard = true;
        is_AI = false;
        }
    _num++;
    }
