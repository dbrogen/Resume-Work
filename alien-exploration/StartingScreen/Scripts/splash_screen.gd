class_name SplashScreen
extends TextureRect

func load_space():
	get_tree().change_scene_to_file("res://Space Levels/space.tscn");

func load_instructions():
	play_click_sound();
	await(get_tree().create_timer(.5));
	get_tree().change_scene_to_file("res://StartingScreen/Scenes/instructionscreen.tscn");

func _on_start_button_pressed() -> void:
	play_click_sound();
	await(get_tree().create_timer(.5));
	load_space();

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("ui_accept")):
		$AudioStreamPlayer.play()
		await(get_tree().create_timer(.5));
		load_space();


func _on_instructions_pressed() -> void:
	load_instructions();

func play_click_sound():
	$AudioStreamPlayer.play()


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://StartingScreen/Scenes/Credits_Screen.tscn");
