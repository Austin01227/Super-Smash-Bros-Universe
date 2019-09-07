///@func Assign_Custom_Controls()
//Loop through every Player object, load the saved controls
var _num = 0;
with(obj_player)
    {
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