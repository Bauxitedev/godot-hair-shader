tool
extends WorldEnvironment

func _ready():
	
	var sphere = $sphere
	var mesh = sphere.mesh
	var faces = mesh.get_faces()
	
	var hair = $hair
	
	# first delete all children of sphere
	
	for child in sphere.get_children():
		print("deleting ", child)
		child.queue_free()
	
	# randomly add hairs to the mesh
	
	for i in faces.size() / 3:
		
		if rand_range(0,1) > 0.3:
        	continue
		
		var v1 = faces[i*3]
		var v2 = faces[i*3+1]
		var v3 = faces[i*3+2]
		
		var avg = (v1+v2+v3) / 3.0
		
		var v1v2 = (v2 - v1).normalized()
		var v1v3 = (v3 - v1).normalized()
		var norm = (v1v2.cross(v1v3)).normalized()
		
		var dup = hair.duplicate()
		
		dup.transform.basis = Basis(norm, v1v3, v1v2)
		
		dup.transform = dup.transform.rotated(norm.normalized(), rand_range(0, 2*PI))
		dup.transform = dup.transform.scaled(Vector3(1,1,1) * rand_range(0, 1.5))		
		dup.transform.origin = avg
				
		sphere.add_child(dup)
	

func _process(delta):
	$sphere.rotate_y(delta*0.1)
	
