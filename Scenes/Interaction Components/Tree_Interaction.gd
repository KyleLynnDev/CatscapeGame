extends InteractionManager

func interaction():
	var player = get_tree().current_scene.player
	player.anim_sm.travel("Chop Tree")
	print(player.name)
