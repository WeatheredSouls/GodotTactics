extends LayoutAnchor
class_name AbilityMenuPanel

@export var anchorList:Array[PanelAnchor] = []

func SetPosition(anchorName:String, animated:bool):
	var anchor = GetAnchor(anchorName)
	await ToAnochorPosition(anchor, animated)
	
	
func GetAnchor(anchorName: String):
	for anchor in self.anchorList:
		if anchor.anchorName == anchorName:
			return anchor
	return null
