extends pickup_component
class_name crystal_pickup

func item_pickup(body: Node2D):
	if body is player_character:
		var proj_component : projectile_component = body.get_node('projectile_component')
		if !proj_component or proj_component.can_fire == true: return
		super(body)
		proj_component.can_fire = true
