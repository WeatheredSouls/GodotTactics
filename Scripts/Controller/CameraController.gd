extends Node
class_name CameraController

@export var _followSpeed: float = 3.0
var _follow: Node3D

var _minZoom = 5
var _maxZoom = 20
var _zoom = 10

var _minPitch = -90
var _maxPitch = 0

func _process(delta):
	if _follow:
		self.position = self.position.lerp(_follow.position, _followSpeed * delta)

func setFollow(follow: Node3D):
	if follow:
		_follow = follow
	
func Zoom(scroll: int):
	_zoom = clamp(_zoom + scroll,_minZoom, _maxZoom )
	
	if $Heading/Pitch/Camera3D.projection == Camera3D.PROJECTION_ORTHOGONAL:
		$Heading/Pitch/Camera3D.position.z = 100
		$Heading/Pitch/Camera3D.size = _zoom
	else:
		$Heading/Pitch/Camera3D.position.z = _zoom

func Orbit(direction: Vector2):
	if direction.x != 0:
		var headingSpeed = 2
		var headingAngle = $Heading.rotation.y
		headingAngle += direction.x * headingSpeed * get_process_delta_time()
		$Heading.rotation.y = headingAngle
		while $Heading.rotation.y > deg_to_rad(360):
			$Heading.rotation.y -= deg_to_rad(720)
		while $Heading.rotation.y < deg_to_rad(-360):
			$Heading.rotation.y += deg_to_rad(720)
		
	if direction.y !=0:
		var orbitSpeed = 2
		var vAngle = direction.y
		var orbitAngle = $Heading/Pitch.rotation.x
		orbitAngle += direction.y * orbitSpeed * get_process_delta_time()
		orbitAngle = clamp(orbitAngle,deg_to_rad(_minPitch), deg_to_rad(_maxPitch) )
		$Heading/Pitch.rotation.x = orbitAngle

func AdjustedMovement(originalPoint:Vector2i):
	var angle = rad_to_deg($Heading.rotation.y)

	if ((angle >= -45 && angle < 45) || ( angle < -315 || angle >= 315)):
		return originalPoint
		
	elif ((angle >= 45 && angle < 130) || ( angle >= -315 && angle < -210 )):
		return Vector2i( originalPoint.y, originalPoint.x * -1)
		
	elif ((angle >= 130 && angle < 210) || ( angle >= -210 && angle < -130 )):
		return Vector2i(originalPoint.x * -1, originalPoint.y * -1)

	elif ((angle >= 210 && angle < 315) || ( angle >= -130 && angle < -45 )):
		return Vector2i(originalPoint.y * -1, originalPoint.x)

	else:
		print("Camera angle is wrong: " + str(angle))
		return originalPoint


