extends Node2D

var Builder =  TilesetBuilder.new()

# Called when the node enters the scene tree for the first time.
func _ready():

# Example #1
# ----------------------------------------------
#	var image = Image.new()	
#	image.load("res://Sprites/Example/AutoTile_1.png")
#	Builder.SetTileSize(16,16)	
#	Builder.SetInputImage(image)	
#	Builder.Prepare()
#	Builder.Build()
#	Builder.SaveTileset("res://TestTilset_3x3M_16x16pix.tres")
#	get_node("UserInput/SpriteOutput").texture = Builder.GetResult()

# Example #2
# ----------------------------------------------
	
	
	# method #2a
	var image = Image.new()	
	image.load("res://Sprites/Example/AutoTile_1.png")
	Builder.BuildFromImage(16,16,image,"res://TestTilset_3x3M_16x16pix.tres")

	# method #2b
	#Builder.BuildFromTexture(16,16,get_node("UserInput/SpriteInput").get_texture(),"res://TestTilset_3x3M_16x16pix.tres")

	# method #2c
	#Builder.BuildFromSprite(16,16,get_node("UserInput/SpriteInput"),"res://TestTilset_3x3M_16x16pix.tres")

	get_node("UserInput/SpriteOutput").texture = Builder.GetResult()
	

	
	pass # Replace with function body.
