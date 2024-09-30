extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#moves the player if it reaches the first checkpoint
	pass;
		
func _on_player_end_of_game() -> void:
	$HUD.show();
	$HUD.show_game_over();
	$HUD.reset_score();
	#TODO: MUSIC and Death Sound + Death Animation

func new_game():
	pass;
	


func _on_player_victory() -> void:
	$HUD.show_win();
