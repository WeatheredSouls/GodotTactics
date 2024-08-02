extends Node

var pools:Dictionary = {}

func AddEntry(key:String, prefab: PackedScene, prepopulate: int ,maxCount: int)->bool:
	if pools.has(key):
		return false
	
	var data:PoolData = PoolData.new()
	data.prefab = prefab
	data.maxCount = maxCount
	pools[key] = data
	for i in prepopulate:
		Enqueue(CreateInstance(key,prefab))
	
	return true

func Enqueue(sender:Poolable):
	if(sender == null || sender.isPooled || not pools.has(sender.key)):
		return
	
	var data:PoolData = pools[sender.key]
	if data.pool.size() >= data.maxCount:
		sender.free()
		return
	
	data.pool.push_back(sender)
	if(sender.get_parent()):
		sender.get_parent().remove_child(sender)
	self.add_child(sender)
	sender.isPooled = true
	sender.hide()

func Dequeue(key:String)->Poolable:
	if not pools.has(key):
		return null

	var data:PoolData = pools[key]
	if data.pool.size() == 0:
		return CreateInstance(key, data.prefab)
	
	var obj:Poolable = data.pool.pop_front()
	obj.isPooled = false
	return obj
	
func CreateInstance(key:String, prefab:PackedScene)->Poolable:
	var instance = prefab.instantiate()
	instance.set_script(Poolable)
	instance.key = key
	return instance

func ClearEntry(key:String):
	if not pools.has(key):
		return
	
	var data:PoolData = pools[key]
	while data.pool.size() > 0:
		var obj:Poolable = data.pool.pop_front()
		obj.free()
	pools.erase(key)

func SetMaxCount(key:String, maxCount:int):
	if not pools.has(key):
		return
	pools[key].maxCount = maxCount
