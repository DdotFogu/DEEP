extends jump
class_name frog_jump

func enter(msg:={}):
	animation.play('jump')
	body.velocity = Vector2(50, -stats.jump_height)
