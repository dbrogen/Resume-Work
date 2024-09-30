extends CanvasLayer

var score: int = 0;

signal start_game;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_message(text):
	$Message.text = text;
	$Message.show();
	$MessageTimer.start();
	
func show_game_over():
	#Display Game Over
	show_message("GAME OVER");
	
func show_win():
	show_message("YOU WIN");
	
func reset_score():
	score = 0;

func _on_message_timer_timeout() -> void:
	$Message.hide();


func _on_start_button_pressed() -> void:
	$StartButton.hide();
	start_game.emit();


func _on_player_add_to_score() -> void:
	score += 1;
	$Score.text = "Enemies Stomped: " + str(score);
