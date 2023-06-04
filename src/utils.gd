const TILE_SRC = "res://src/tile.gd"

enum PAWN_CLASSES {Knight, Archer, Paladin, Zombie, Skeleton_Archer, Imp, Dragon}
enum HERO_CLASSES {Princess, Necromancer}
enum PAWN_STRATEGIES {Tank, Flank, Support}

#const KNIGHT_SPRITE = "res://assets/sprites/characters/chr_pawn_knight.png"
#const ARCHER_SPRITE = "res://assets/sprites/characters/chr_pawn_archer.png"
#const CHEMIST_SPRITE = "res://assets/sprites/characters/chr_pawn_chemist.png"
#const CLERIC_SPRITE = "res://assets/sprites/characters/chr_pawn_mage.png"
#const SKELETON_CPT_SPRITE = "res://assets/sprites/characters/chr_pawn_skeleton_cpt.png"
#const SKELETON_SPRITE = "res://assets/sprites/characters/chr_pawn_skeleton.png"
#const SKELETON_MAGE_SPRITE = "res://assets/sprites/characters/chr_pawn_skeleton_mage.png"
#PRINCESS
#const PRINCESS_SPRITE = "res://assets/sprites/characters/princessUnits/chr_pawn_princess.png"
const KNIGHT_SPRITE = "res://assets/sprites/characters/princessUnits/chr_pawn_knight.png"
const ARCHER_SPRITE = "res://assets/sprites/characters/princessUnits/chr_pawn_archer.png"
#const SOLDIER_SPRITE = "res://assets/sprites/characters/princessUnits"
#const ENCHANTRESS_SPRITE = "res://assets/sprites/characters/princessUnits"
#const SPELLCASTER_SPRITE = "res://assets/sprites/characters/princessUnits"
#const GRIFFIN_RIDER_SPRITE = "res://assets/sprites/characters/princessUnits"
#const CAVALRY_SPRITE = "res://assets/sprites/characters/princessUnits"
const PALADIN_SPRITE = "res://assets/sprites/characters/princessUnits/chr_pawn_paladin.png"
#const BARD_SPRITE = "res://assets/sprites/characters/princessUnits"
#const DRAGON_KNIGHT_SPRITE = "res://assets/sprites/characters/princessUnits"
#const PRIESTESS_SPRITE = "res://assets/sprites/characters/princessUnits"
#const SIEGE_ENGINEER_SPRITE = "res://assets/sprites/characters/princessUnits"
#const ELEMENTAL_SUMMONER_SPRITE = "res://assets/sprites/characters/princessUnits"

#NECROMANCER
#const NECROMANCER_SPRITE "res://assets/sprites/characters/necromancerUnits/chr_pawn_necromancer.png"
const ZOMBIE_SPRITE = "res://assets/sprites/characters/necromancerUnits/chr_pawn_zombie.png"
const SKELETON_ARCHER_SPRITE = "res://assets/sprites/characters/necromancerUnits/chr_pawn_skeleton_archer.png"
#const DARK_KNIGHT_SPRITE = "res://assets/sprites/characters/necromancerUnits"
#const PLAGUEBEARER_SPRITE = "res://assets/sprites/characters/necromancerUnits"
#const LICH_MAGE_SPRITE = "res://assets/sprites/characters/necromancerUnits"
#const DEATH_KNIGHT_SPRITE = "res://assets/sprites/characters/necromancerUnits"
#const WRAITH_SPRITE = "res://assets/sprites/characters/necromancerUnits"
#const GHOST_WHISPERER_SPRITE = "res://assets/sprites/characters/necromancerUnits"
#const SHADOW_ASSASSIN_SPRITE = "res://assets/sprites/characters/necromancerUnits"
#const BANSHEE_SPRITE = "res://assets/sprites/characters/necromancerUnits"
#const BONE_GOLEM_SPRITE = "res://assets/sprites/characters/necromancerUnits"
#const DARK_ALCHEMIST_SPRITE = "res://assets/sprites/characters/necromancerUnits"
#const NECROMANCER_LORD_SPRITE = "res://assets/sprites/characters/necromancerUnits"
const IMP_SPRITE = "res://assets/sprites/characters/necromancerUnits/chr_pawn_imp.png"
#const DRAGON_SPRITE = "res://assets/sprites/characters/necromancerUnits/chr_pawn_dragon.png"

static func convert_tiles_into_static_bodies(tiles_obj):

	#Given a Node3D Node as parameter (tiles_obj), this function will iterate over each
	#of its children converting them into a static body and attaching the tile.gd script.
	#e.g. this function will transform the 'Tiles' into the following structure:
	
	#	> Tiles:                                > Tiles:
	#		> Tile1                                 > StaticBody3D (tile.gd):
	#		> Tile2                                     > Tile1
	#		...                                         > CollisionShape3D
	#		> TileN       -- TRANSFORM INTO ->      > StaticBody2 (tile.gd):
	#													> Tile2
	#													> CollisionShape3D
	#												...
	#												> StaticBodyN (tile.gd):
	#													> TileN
	#													> CollisionShape3D

	#As you can see this is very usefull for configure walkeable tiles as fast as posible
	#especially if the map used was exported from Blender using the Godot Extension

	for t in tiles_obj.get_children():
		t.create_trimesh_collision()
		var static_body = t.get_child(0)
		static_body.set_position(t.get_position())
		t.set_position(Vector3.ZERO)
		t.set_name("Tile")
		t.remove_child(static_body)
		tiles_obj.remove_child(t)
		static_body.add_child(t)
		static_body.set_script(load(TILE_SRC))
		static_body.configure_tile()
		static_body.set_process(true)
		tiles_obj.add_child(static_body)


static func create_material(color, texture=null, shaded_mode=0):
	var material = StandardMaterial3D.new()
	material.flags_transparent = true
	material.albedo_color = Color(color)
	material.albedo_texture = texture
	material.shading_mode = shaded_mode
	return material


static func get_pawn_sprite(pawn_class):
	match pawn_class:
		0: return load(KNIGHT_SPRITE)
		1: return load(ARCHER_SPRITE)
		2: return load(PALADIN_SPRITE)
		#Necromancer
		3: return load(ZOMBIE_SPRITE)
		4: return load(SKELETON_ARCHER_SPRITE)
		5: return load(IMP_SPRITE)
		#6: return load(DRAGON_SPRITE)
	

static func get_pawn_move_radious(pawn_class):
	match pawn_class:
		0: return 4
		1: return 5
		2: return 3
		#Necromancer
		3: return 3
		4: return 5
		5: return 5
		#6: return 15


static func get_pawn_jump_height(pawn_class):
	match pawn_class:
		0: return 0.5
		1: return 0.5
		2: return 0.5
		#Necromancer
		3: return 0.5
		4: return 0.5
		5: return 10
		#6: return 10


static func get_pawn_attack_radious(pawn_class):
	match pawn_class:
		0: return 1
		1: return 6
		2: return 1
		#Necromancer
		3: return 1
		4: return 6
		5: return 4
		#6: return 6


static func get_pawn_attack_power(pawn_class):
	match pawn_class:
		0: return 17
		1: return 28
		2: return 43
		#Necromancer
		3: return 17
		4: return 39
		5: return 27
		#6: return 123


static func get_pawn_health(pawn_class):
	match pawn_class:
		0: return 42
		1: return 33
		2: return 83
		#Necromancer
		3: return 34
		4: return 55
		5: return 31
		#6: return 1350


static func vector_remove_y(vector):
	return vector*Vector3(1,0,1)


static func vector_distance_without_y(b, a):
	return vector_remove_y(b).distance_to(vector_remove_y(a))
