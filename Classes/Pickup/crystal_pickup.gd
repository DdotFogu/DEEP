extends pickup_component
class_name crystal_pickup

func item_pickup(body: Node2D):
	if body is player_character:
		var proj_component : projectile_component = body.get_node('projectile_component')
		if proj_component.ammo == proj_component.max_ammo: return
		if !active: return
		super(body)
		active = false
		proj_component.add_ammo(1)
		
