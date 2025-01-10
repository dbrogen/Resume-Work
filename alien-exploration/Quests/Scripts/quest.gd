class_name Quest
extends Resource
## Abstract base class to be extended by all other quest types.

## The various states that a quest can be in
enum Status {
	## Not yet visible to the hero
	PENDING = -1,
	## Available to be take on by the hero
	UNLOCKED,
	## In-progress by the hero
	ACTIVE,
	## Completion requirements have been met
	COMPLETE,
	## Turned in for a reward and closed out
	DONE
}

## title for the quest
@export var name: String

## Property indicating the current state of the quest
@export var status: Status = Status.PENDING:
	set(new_status):
		status = new_status
		match status:
			Status.UNLOCKED:
				_quest_channel.quest_unlocked.emit(self)
			Status.ACTIVE:
				_quest_channel.quest_accepted.emit(self)
			Status.COMPLETE:
				_quest_channel.quest_completed.emit(self)
			Status.DONE:
				_quest_channel.quest_rewarded.emit(self)

## Unique identifer distinguishing this specific quest
var uid: int

## Quests subscribe to event notifications from the quest channel
var _quest_channel: QuestChannel = QuestChannel.get_instance()

## ensures observers are notified of any initial quest state other than pending.
func ready():
	status = status

## Generates a self uid
func _init():
	self.uid = generate_uid()


## Accept an unlocked quest.
func _accept():
	print("Quest '", name,"' accepted!")
	Questmanager.collection_quest_status = Status.ACTIVE;
	Questmanager.collection_quest_status_name = "Complete";
	status = Status.ACTIVE

## Complete an active quest.
func _complete():
	print("Quest '", name,"' completed!")
	Questmanager.collection_quest_status = Status.COMPLETE;
	Questmanager.collection_quest_status_name = "Complete";
	status = Status.COMPLETE

## Turn in and close out a completed quest.
func _reward():
	print("Quest '", name,"' rewarded!")
	Questmanager.collection_quest_status = Status.DONE;
	status = Status.DONE

## Unlock a previously locked quest.
func _unlock():
	print("Quest '", name,"' unlocked!")
	Questmanager.collection_quest_status = Status.UNLOCKED;
	Questmanager.collection_quest_status_name = "Accept";
	status = Status.UNLOCKED


## Contains the previously assigned unique identifier
static var lastUID: int = -1


## Returns an integer identifier that is unique for each new quest instance.
static func generate_uid():
	lastUID += 1
	return lastUID
