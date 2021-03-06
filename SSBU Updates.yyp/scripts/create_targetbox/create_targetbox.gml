///@func create_targetbox(rx,ry,xscale,yscale,damage,base_kb,kb_scaling,hitlag,angle,lifetime,shape,hitbox_group,target,[flipper]);
///@param relative_x
///@param relative_y
///@param xscale
///@param yscale
///@param damage
///@param base_kb
///@param kb_scaling
///@param hitlag
///@param angle
///@param lifetime
///@param shape
///@param hitbox_group
///@param target
///@param [flipper]
var _newhitbox=instance_create_layer(x+argument[0]*facing,y+argument[1],layer,obj_targetbox);
with(_newhitbox)
	{
	image_xscale=argument[2];
	image_yscale=argument[3];
	damage=argument[4];
	base_knockback=argument[5];
	knockback_scaling=argument[6];
	base_hitlag=argument[7];
	angle=argument[8];
	grounded_angle=angle;
	lifetime=argument[9];
	set_hitbox_property(_newhitbox,HITBOX_PROPERTY.shape,argument[10]);
	owner=other.id;
	owner_xstart=other.x;
	owner_ystart=other.y;
	hitbox_group=argument[11];
	target=argument[12];
	angle_flipper=argument_count>13 ? argument[13] : FLIPPER.standard;
	drawing_angle=angle_flipper==FLIPPER.standard ? apply_angle_flipper(angle,angle_flipper,owner) : angle;
	}
ds_list_add(my_hitboxes,_newhitbox);
return _newhitbox;