class_name TilesetBuilder

var tile_width:int  = 16
var tile_height:int = 16
var tiles_input_image:Texture = null
var tileset_output_image:ImageTexture = null
var tileset_image : Image = null

var tilset_3x3b = {
		"0,0" : ["11abcd"],
		"1,0" : ["14abcd"],
		"2,0" : ["04abcd"],
		"3,0" : ["14ac","04bd"],
		"4,0" : ["03abcd"]
	}
#--------------------------------------------------------------------
# Set tile size
#--------------------------------------------------------------------
func SetTileSize(w:int, h:int) -> void:
	self.tile_width = w
	self.tile_height = h

#--------------------------------------------------------------------
# SET Input TEXTURE
#--------------------------------------------------------------------
func SetTexture(img_in:Texture)->void:
	self.tiles_input_image = img_in
	self.tileset_image = Image.new()

#--------------------------------------------------------------------
# Prepare data
#--------------------------------------------------------------------
func Prepare() -> void:
	
	# create output image
	self.tileset_output_image = ImageTexture.new()	
	self.tileset_image.create(8*self.tile_width,6*self.tile_height,false,Image.FORMAT_RGBA8)
	
	# set output texture from image
	self.tileset_output_image.create_from_image(self.tileset_image)

#--------------------------------------------------------------------
# Decode x or y position 
#--------------------------------------------------------------------
func _DecodePosition(val) -> int:
	
	match val:
		"0" : return self.tile_width*0
		"1" : return self.tile_width*1
		"2" : return self.tile_width*2
		"3" : return self.tile_width*3
		"4" : return self.tile_width*4
	
	return -1

#--------------------------------------------------------------------
# Decode sub tile position
#--------------------------------------------------------------------
func _DecodeSubPosition(val) -> Vector2:
	
	var sub_size = Vector2(self.tile_width /2,self.tile_height / 2)
	
	match val:
		"a" : return Vector2(sub_size.x*0,sub_size.y*0)
		"b" : return Vector2(sub_size.x*1,sub_size.y*0)
		"c" : return Vector2(sub_size.x*0,sub_size.y*1)
		"d" : return Vector2(sub_size.x*1,sub_size.y*1)
		
	return Vector2(0,0)
		