extends interact_component
class_name ammo_pickup

@export var ammo_amount:int=999

func item_pickup():
	var proj_component : projectile_component = global.player.get_node('projectile_component')
	if !proj_component: return
	if proj_component.ammo == proj_component.max_ammo: return
	proj_component.add_ammo(ammo_amount)
