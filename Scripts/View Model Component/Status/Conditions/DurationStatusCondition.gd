extends StatusCondition
class_name DurationStatusCondition

var duration:int = 10
var turnController

func _ready():
	turnController = get_node("/root/Battle/Battle Controller/Turn Order Controller")
	turnController.roundBeganNotification.connect(OnNewTurn)

func _exit_tree():
	turnController.roundBeganNotification.disconnect(OnNewTurn)

func OnNewTurn():
	duration -= 1
	if duration <= 0:
		Remove()
