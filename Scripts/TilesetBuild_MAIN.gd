extends Node2D

var Builder =  TilesetBuilder.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var image = Image.new()	
	image.load("res://Sprites/Example/AutoTile_1.png")

#	Builder.SetTileSize(16,16)	
#	Builder.SetInputImage(image)	
#	Builder.Prepare()
#	Builder.Build()
#	Builder.SaveTileset("TestTilset_3x3M_16x16pix")
#	get_node("UserInput/SpriteOutput").texture = Builder.GetResult()

	Builder.BuildFromImage(16,16,image,"TestTilset_3x3M_16x16pix")
	#Builder.BuildFromTexture(16,16,get_node("UserInput/SpriteInput").get_texture(),"TestTilset_3x3M_16x16pix")
	#Builder.BuildFromSprite(16,16,get_node("UserInput/SpriteInput"),"TestTilset_3x3M_16x16pix")
	get_node("UserInput/SpriteOutput").texture = Builder.GetResult()
	

	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass