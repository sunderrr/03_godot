extends Node2D

@export var noise_height_texture: NoiseTexture2D
@export var noise_tree_texture: NoiseTexture2D
var noise: Noise
var noise_tree: Noise

@onready var tile_map_layer_water: TileMapLayer = $TileMapLayer_water
@onready var tile_map_layer_ground_1: TileMapLayer = $TileMapLayer_ground1
@onready var tile_map_layer_ground_2: TileMapLayer = $TileMapLayer_ground2
@onready var tile_map_layer_cliff: TileMapLayer = $TileMapLayer_cliff
@onready var tile_map_layer_env: TileMapLayer = $TileMapLayer_env

var tile_arr_sand = []
var tile_arr_grass = []
var tile_arr_cliff = []

var source_id = 0
var water_atlas = Vector2i(0,1)
var land_atlas = Vector2i(0,0)

var terrain_sand_int = 0
var terrain_grass_int = 1

var width = 150
var height = 150

var tmp_noise_val_arr = []
var tmp_noise_tree_val_arr = []

var palm_tree_atlas = [Vector2i(12,2), Vector2i(15,2), Vector2i(12,6)]
var oak_tree_atlas = [Vector2i(15,6)]

func _ready():
	noise = noise_height_texture.noise
	noise_tree = noise_tree_texture.noise
	generate_world()
	
func generate_world():
	for x in range(-width/2, width/2):
		for y in range(-height/2, height/2):
			var noise_tree_val = noise_tree.get_noise_2d(x,y)
			var noise_val = noise.get_noise_2d(x,y)
			tmp_noise_tree_val_arr.append(noise_tree_val)
			tmp_noise_val_arr.append(noise_val)
			tile_map_layer_water.set_cell(Vector2i(x,y), source_id, water_atlas)
			
			if noise_val >= -0.2 :
				tile_arr_sand.append(Vector2i(x,y))
				if noise_val > -0.18 and noise_val < 0.18 and noise_tree_val > 0.6:
					tile_map_layer_env.set_cell(Vector2i(x,y), source_id, palm_tree_atlas.pick_random())
				if noise_val >= 0.2:
					tile_arr_grass.append(Vector2i(x,y))
					if noise_val > 0.22 and noise_val < 0.4 and noise_tree_val > 0.58:
						tile_map_layer_env.set_cell(Vector2i(x,y), source_id, oak_tree_atlas.pick_random())
					if noise_val >= 0.42:
						tile_arr_cliff.append(Vector2i(x,y))
				
	print("count sand ", tile_arr_sand.size())
	print("count grass ", tile_arr_grass.size())
	print("count cliff ", tile_arr_cliff.size())
	tile_map_layer_ground_1.set_cells_terrain_connect(tile_arr_sand, 0, 0)
	tile_map_layer_ground_1.set_cells_terrain_connect(tile_arr_grass, 1, 0)
	tile_map_layer_cliff.set_cells_terrain_connect(tile_arr_cliff, 3, 0)
	
	
	print("max ", tmp_noise_val_arr.max())
	print("min ", tmp_noise_val_arr.min())
	print("max tree ", tmp_noise_val_arr.max())
	print("min tree ", tmp_noise_val_arr.min())
