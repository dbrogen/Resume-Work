class_name CreditsScreen
extends TextureRect

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://StartingScreen/Scenes/SplashScreen.tscn");
