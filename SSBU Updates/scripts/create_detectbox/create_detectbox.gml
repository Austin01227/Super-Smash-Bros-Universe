///@func create_detectbox(rx,ry,xscale,yscale,lifetime,shape,hitbox_group);
///@param relative_x
///@param relative_y
///@param xscale
///@param yscale
///@param lifetime
///@param shape
///@param hitbox_group
var _newhitbox = instance_create_layer(x + argument[0] * facing, y + argument[1], layer, obj_detectbox);
with(_newhitbox)
	{
	image_xscale = argument[2];
	image_yscale = argument[3];
	lifetime = argument[4];
	set_hitbox_property(_newhitbox, HITBOX_PROPERTY.shape, argument[5]);
	owner = other.id;
	owner_xstart = other.x;
	owner_ystart = other.y;
	hitbox_group = argument[6];
	}
ds_list_add(my_hitboxes, _newhitbox);
return _newhitbox;