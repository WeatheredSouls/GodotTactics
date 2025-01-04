extends BattleState
@export var cutSceneState: State

func Enter():
	super()
	Init()

func Init():
	var saveFile = _owner.board.savePath + _owner.board.fileName
	_owner.board.LoadMap(saveFile)

	var p:Vector2i = _owner.board.tiles.keys()[0]
	SelectTile(p)

	SpawnTestUnits()
	
	_owner.cameraController.setFollow(_owner.board.marker)
	
	#TranslationServer.set_locale("ja")
	#TranslationServer.set_locale("en")
	#TranslationServer.set_locale("es")
	
	_owner.stateMachine.ChangeState(cutSceneState)

func SpawnTestUnits():	
	var jobList:Array[String] = ["Rogue", "Warrior", "Wizard"]
	var path = "res://Data/Jobs/"
	
	for i in jobList.size():
		var unit:Unit = _owner.heroPrefab.instantiate()
		unit.name = jobList[i]
		_owner.add_child(unit)
		
		var s:Stats = Stats.new()
		unit.add_child(s)
		s.SetStat(StatTypes.Stat.LVL, 1)
		s.name = "Stats"		
		
		var fullPath:String = path + jobList[i] + ".tscn"
		var scene:PackedScene = load(fullPath)
		var job:Job = scene.instantiate()
		unit.add_child(job)
		job.Employ()
		job.LoadDefaultStats()
		
		var p:Vector2i = Vector2i(_owner.board.tiles.keys()[i].x,_owner.board.tiles.keys()[i].y)
		
		unit.Place(_owner.board.GetTile(p))
		unit.Match()

		var m = unit.get_node("Movement")
		m.set_script(WalkMovement)
		m.range = 5
		m.jumpHeight = 1
		m.set_process(true)
		
		units.append(unit)

#		var rank = Rank.new()
#		unit.add_child(rank)
#		rank.Init(10)
