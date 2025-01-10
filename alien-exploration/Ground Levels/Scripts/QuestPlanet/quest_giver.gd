class_name QuestGiver
extends StaticBody2D

## Contains the instance of the interatable scene
@onready var interactable: Interactable = $interactable

## Contains the quest the character can give
@export var quest: Quest;

## Instances the QuestChannel to a variable
var _quest_channel: QuestChannel = QuestChannel.get_instance();

## Called when the node enters the scene tree for the first time.
## Readys the quest and sets the interact to trigger the give_quest() function
func _ready() -> void:
	interactable.interact = give_quest;
	interactable.interact_name = str("[E] to " + Questmanager.collection_quest_status_name + " the Quest");
	quest.ready();

## Gives the player the quest on interaction and sets the global quest variable through the Questmanager
func give_quest():
	Questmanager.collection_quest_accepted = true;
	Questmanager.collection_quest_name = quest.name;
	Questmanager.current_quest = quest;
	Questmanager.collectables = Questmanager.current_quest.collectables;
	
	## Matches the quest status and prompts accordingly
	match Questmanager.collection_quest_status:
		Quest.Status.PENDING:
			interactable.interact_name = "[E] to Accept the Quest";
			quest._unlock();
		Quest.Status.UNLOCKED:
			quest._accept();
			interactable.interact_name = "[E] to Complete the Quest"
		Quest.Status.COMPLETE:
			quest._reward();
			interactable.interact_name = "Quest Rewarded!";


## If the Area2D node is entered it sets the sprite to face the player
func _on_left_looking_body_entered(body: Node2D) -> void:
	$Sprite2D.flip_h = true;
	$Sprite2D.play("FacingRight")

## If the Area2D node is exited it sets the sprite to idle
func _on_left_looking_body_exited(body: Node2D) -> void:
	$Sprite2D.play("Idle")

## If the Area2D node is entered it sets the sprite to face the player
func _on_right_looking_body_entered(body: Node2D) -> void:
	$Sprite2D.flip_h = false;
	$Sprite2D.play("FacingRight");

## If the Area2D node is entered it sets the sprite to idle
func _on_right_looking_body_exited(body: Node2D) -> void:
	$Sprite2D.play("Idle")
