extends TextureRect

func back_to_splash():
	get_tree().change_scene_to_file("res://StartingScreen/Scenes/SplashScreen.tscn");


func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("ui_cancel")):
		back_to_splash();


func _on_button_pressed() -> void:
	back_to_splash();
