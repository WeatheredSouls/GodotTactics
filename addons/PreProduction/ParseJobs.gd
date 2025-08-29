@tool
extends Button
var path = "res://Data/Jobs/"

func _on_pressed():
	
	var error = DirAccess.make_dir_recursive_absolute(path)
	if error != 0:
		print("Error Creating Directory. Error Code: " + str(error))
	ParseStartingStats(Get_data("res://Settings/JobStartingStats.csv"))
	ParseGrowthStats(Get_data("res://Settings/JobGrowthStats.csv"))
	
func Get_data(path:String):
	var maindata = {}
	var file = FileAccess.open(path,FileAccess.READ)
	while !file.eof_reached():
		var data_set = Array(file.get_csv_line())
		maindata[maindata.size()] = data_set
	file.close()
	return maindata

func ParseStartingStats(data):
	for item in data.keys():
		if item == 0:
			continue
		var elements : Array = data[item]
		var scene:PackedScene = GetOrCreate(elements[0])
		var job = scene.instantiate()

		for i in job.statOrder.size():
			job.baseStats[i] = int(elements[i+1])
		
		var evade:StatModifierFeature = GetFeature(job, StatTypes.Stat.EVD)
		evade.amount = int(elements[8])
		evade.name = "SMF_EVD"
		
		var res:StatModifierFeature = GetFeature(job, StatTypes.Stat.RES)
		res.amount = int(elements[9])
		res.name = "SMF_RES"
		
		var move:StatModifierFeature = GetFeature(job, StatTypes.Stat.MOV)
		move.amount = int(elements[10])
		move.name = "SMF_MOV"
		
		var jump:StatModifierFeature = GetFeature(job, StatTypes.Stat.JMP)
		jump.amount = int(elements[11])
		jump.name = "SMF_JMP"
		
		scene.pack(job)
		ResourceSaver.save(scene, path + elements[0] + ".tscn")

func ParseGrowthStats(data):
	for item in data.keys():
		if item == 0:
			continue
		var elements : Array = data[item]
		
		var scene:PackedScene = GetOrCreate(elements[0])
		var job = scene.instantiate()

		for i in job.statOrder.size():
			job.growStats[i] = float(elements[i+1])
		
		scene.pack(job)
		ResourceSaver.save(scene, path + elements[0] + ".tscn")

func GetOrCreate(jobName:String):
	var fullPath:String = path + jobName + ".tscn"
	if ResourceLoader.exists(fullPath):
		return load(fullPath)
	else:
		return Create(fullPath)
		
func Create(fullPath:String):
	var job:Job = Job.new()
	job.name = "Job"
	var scene:PackedScene = PackedScene.new()
	scene.pack(job)
	ResourceSaver.save(scene, fullPath)
	return scene

func GetFeature(job:Job, type:StatTypes.Stat):
	var nodeArray:Array[Node] = job.get_children()
	var filteredArray = nodeArray.filter(func(node):return node is Feature)
	
	for smf in filteredArray:
		if smf.type == type:
			return smf
	
	var feature:StatModifierFeature = StatModifierFeature.new()
	feature.type = type
	job.add_child(feature)
	feature.set_owner(job)
	return feature
