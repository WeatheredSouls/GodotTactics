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
	var recipes:Array[String] = [
		"Alaois",
		"Hania",
		"Kamau",
		"Enemy Rogue",
		"Enemy Warrior",
		"Enemy Wizard"
	]
	
	var locations:Array[Tile]
	locations.assign(board.tiles.values())
	for recipe in recipes:
		var level = randi_range(9,11)
		var unit:Unit = UnitFactory.Create(recipe, level, _owner)
		
		var random = randi_range(0, locations.size() - 1)
		var randomTile:Tile = locations[random]
		locations.remove_at(random)
		
		unit.Place( randomTile)
		unit.dir = randi_range(0,3)
		unit.Match()
		
		units.append(unit)
	
	SelectTile(units[0].tile.pos)
