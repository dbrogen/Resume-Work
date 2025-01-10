class_name QuestJournal
extends CanvasLayer

## Contains the player the journal belongs to
@export var player: Player;
## An array of icons to indicate quest progress
@export var icons: Array[Texture2D];

## Loads an instance of the QuestList node on the first frame
@onready var quest_list: ItemList = $Chooser/QuestList
## Loads an instance of the Requirements node on the first frame
@onready var requirements: ItemList = $Chooser/QuestList/Requirements

## Contains the instance of the Quest Channel node
var _quest_channel: QuestChannel = QuestChannel.get_instance();
## Contains the instance of the Collection Channel node
var _collection_channel: CollectionChannel = CollectionChannel.get_instance();

## Hides the quest journal from the viewport
func close():
	self.visible = false;
	player.set_process_input(true);

## Displays the quest journal to the viewport
func open():
	player.set_process_input(false);
	self.visible = true;

## Adds a quest to the quest journal display
func add_quest(quest: Quest):
	if(Questmanager.collection_quest_accepted):
		Questmanager.current_quest = quest;
		quest_list.add_item(Questmanager.collection_quest_name, icons[Questmanager.collection_quest_status]);
		if(quest.has_method("_on_item_collected")):
			print("Adding Requirements")
			var collectquest: CollectQuest = quest;
			for i in Questmanager.collectables.size():
				requirements.add_item(str("Collect a "+ Questmanager.collectables[i]))

## updates the quest as the status's change
func update_quest(quest:Quest):
	for i in quest_list.item_count:
		if(quest_list.get_item_text(i) == Questmanager.collection_quest_name):
			quest_list.set_item_icon(i, icons[Questmanager.collection_quest_status]);
			return;

## Subscribes the channels to the update functions on initializaion
func _init():
	print("Subscribing to Quests")
	_quest_channel.quest_unlocked.connect(add_quest);
	_quest_channel.quest_accepted.connect(update_quest);
	_quest_channel.quest_completed.connect(update_quest);
	_quest_channel.quest_rewarded.connect(update_quest);
	_collection_channel.update_journal.connect(_on_update_journal);

## Handles the input when the player hits the quests button
func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("quests")):
		if(self.visible):
			close();
		else:
			open();

## On the first load hides the quest journal and calls the add quest function using the global quest as a parameter
func _ready() -> void:
	self.visible = false;
	add_quest(Questmanager.current_quest);

## Closes the quest journal when the button is pressed
func _on_close_button_pressed() -> void:
	close();

## Updates the quest journal as requirements are completed
func _on_update_journal(quest: CollectQuest):
	print("Update Journal");
	requirements.clear();
	for i in quest.collectables.size():
		requirements.add_item(str("Collect a: " + quest.collectables[i]));
	
	
