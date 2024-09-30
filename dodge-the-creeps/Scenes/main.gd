extends Node

@export var mob_scene: PackedScene;
var score = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass;


func game_over() -> void:
	$HUD.show_game_over();
	$ScoreTimer.stop();
	$MobTimer.stop();
	$Music.stop();
	$DeathSound.play();
	
func new_game():
	get_tree().call_group("mobs", "queue_free");
	$Music.play();
	$HUD.update_score(score); #updates the score
	$HUD.show_message("Get Ready");
	$Player.start($StartPosition.position);
	$StartTimer.start();


func _on_mob_timer_timeout() -> void:
	#Create a new instance of the Mob scene
	var mob = mob_scene.instantiate();
	
	#Choose a random loaction on Path2D
	var mob_spawn_loaction = $MobPath/MobSpawnLocation;
	mob_spawn_loaction.progress_ratio = randf();
	
	#Set the mob's direction perpendicular to the path direction
	var direction = mob_spawn_loaction.rotation + PI /2;
	
	#Set the mob's position to a random location
	mob.position = mob_spawn_loaction.position;
	
	#Add some randomness to the direction
	direction += randf_range(-PI/4, PI/4);
	mob.rotation = direction;
	
	#Choose the velocity for the mob
	var veleocity = Vector2(randf_range(150.0, 250.0), 0.0);
	mob.linear_velocity = veleocity.rotated(direction);
	
	#Spawn the mob by adding it to the Main scene
	add_child(mob);

func _on_score_timer_timeout() -> void:
	score += 1;
	$HUD.update_score(score); #keeps the display in sync with the changing score


func _on_start_timer_timeout() -> void:
	$MobTimer.start();
	$ScoreTimer.start();
