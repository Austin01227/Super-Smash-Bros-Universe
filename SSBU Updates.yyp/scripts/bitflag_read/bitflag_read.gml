///@func bitflag_read(number,pos)
///@param number
///@param pos

var _num = argument[0],
	_pos = argument[1];
	
return (_num >> _pos) & 1;