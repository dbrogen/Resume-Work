class_name CollectQuest
extends Quest
## A type of quest that is specific to collecting items

## An array of the collectables required to complete the quest
@export var collectables: Array[String];

## Contains an instance of the collection channel
var _event_channel:CollectionChannel = CollectionChannel.get_instance();

## Accepts the quest and connects the on_item_collected_ signal
func _accept():
	_event_channel.item_collected.connect(_on_item_collected);
	super._accept();

## Completes the quest and disconnects the on_item_collected_ signal
func _complete():
	Questmanager.collection_quest_status = Quest.Status.COMPLETE;
	_event_channel.item_collected.disconnect(_on_item_collected);
	super._complete();

## When an item is collected erase it from the requirements array and update the quest journal
## If the array is empty after call to complete the quest
func _on_item_collected(item):
	collectables.erase(item.name);
	_event_channel.update_journal.emit(self)
	if(collectables.is_empty()):
		print("Quest Complete");
		_complete();
