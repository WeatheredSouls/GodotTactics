extends AbilityArea

@export var horizontal:int = 6
@export var minH:int = 1
@export var vertical:int = 2
@export var useAbilityRange:bool = false
@export var extendPastTarget:bool = false

var targetTile:Tile
var unitTile:Tile

func GetTilesInArea(board:BoardCreator, pos:Vector2i):
	var retValue:Array[Tile] = []
	
	targetTile = board.GetTile(pos)
	unitTile = self.get_node("../../../").tile
	
	var numberSteps = LongestSide(unitTile.pos, targetTile.pos)
	var maxSteps = rangeH if useAbilityRange else horizontal
	var minSteps = rangeMinH if useAbilityRange else minH
	
	for i in range(minSteps,maxSteps+1):
		if !extendPastTarget && i > numberSteps + 1:
			break
		var lerpAmount:float = 0 if numberSteps==0 else float(i)/numberSteps
		var point:Vector2 = lerp(Vector2(unitTile.pos),Vector2(targetTile.pos),lerpAmount)
		var tile:Tile = board.GetTile(point.round())
		if Distance(unitTile.pos,point.round()) > maxSteps :
			break
		if ValidTile(tile, lerpAmount):
			retValue.append(tile)
	return retValue

func LongestSide(p0:Vector2i, p1:Vector2i):
	var distX = p1.x - p0.x
	var distY = p1.y - p0.y
	return max(abs(distX),abs(distY))

func Distance(p0:Vector2i, p1:Vector2i):
	var distX = p1.x - p0.x
	var distY = p1.y - p0.y
	return abs(distX) + abs(distY)
	
func ValidTile(t:Tile, lerpDistance:float):
	var height:int = round(lerp(unitTile.height, targetTile.height, lerpDistance))
	return t != null && abs(t.height - height) <= vertical
