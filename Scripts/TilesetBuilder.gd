class_name TilesetBuilder

var tile_width:int  = 16
var tile_height:int = 16
var tiles_input_image:Image = null
var tileset_image : Image = null
var tileset_output_name : String = "DefaultTilset"
var _debug:bool = false
var tilset_template_3x3M_16x16p = preload("res://Template/TMP_Tileset_3x3M_16x16.tres")

var tilset_template = {
		"0,0" : ["11abcd"],
		"1,0" : ["14abcd"],
		"2,0" : ["04abcd"],
		"3,0" : ["14ac","04bd"],
		"4,0" : ["03abcd"],
		"5,0" : ["14a","02b","20c","03d"],
		"6,0" : ["04ab","03cd"],
		"7,0" : ["14a","04b","20c","03d"],
		"0,1" : ["13abcd"],
		"1,1" : ["14ab","13cd"],
		"2,1" : ["22a","13c","04b","00d"],
		"3,1" : ["14a","13c","04b","00d"],
		"4,1" : ["13ac","03bd"],
		"5,1" : ["14a","02b","13c","03d"],
		"6,1" : ["22a","04b","13c","03d"],
		"7,1" : ["14a","04b","13c","03d"],
		"0,2" : ["01abcd"],
		"1,2" : ["01ac","04b","00d"],
		"2,2" : ["01ac","02b","03d"],
		"3,2" : ["01ac","04b","03d"],
		"4,2" : ["10abcd"],
		"5,2" : ["10ab","20c","03d"],
		"6,2" : ["10ab","13c","00d"],
		"7,2" : ["10ab","13c","03d"],
		"0,3" : ["21abcd"],
		"1,3" : ["22a","13c","21bd"],
		"2,3" : ["14a","20c","21bd"],
		"3,3" : ["14a","13c","21bd"],
		"4,3" : ["12abcd"],
		"5,3" : ["14a","02b","12cd"],
		"6,3" : ["04b","22a","12cd"],
		"7,3" : ["14a","04b","12cd"],
		"0,4" : ["01ac","21bd"],
		"1,4" : ["10ab","12cd"],
		"2,4" : ["00abcd"],
		"3,4" : ["00abcd","03d"],
		"4,4" : ["20abcd"],
		"5,4" : ["20abcd","13c"],
		"6,4" : ["22abcd"],
		"7,4" : ["22abcd","14a"],
		"0,5" : ["02abcd"],
		"1,5" : ["02abcd","04b"],
		"2,5" : ["00ac","20bd"],
		"3,5" : ["00ab","02cd"],
		"4,5" : ["02ac","22bd"],
		"5,5" : ["20ab","22cd"],
		"6,5" : ["00a","20b","02c","22d"],
		"7,5" : ["24abcd"]
		
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
func SetInputImage(img_in:Image)->void:
	self.tiles_input_image = img_in
	self.tileset_image = Image.new()
	
#--------------------------------------------------------------------
# Prepare data
#--------------------------------------------------------------------
func Prepare() -> void:

	self.tileset_image.create(8*self.tile_width,6*self.tile_height,false,Image.FORMAT_RGBA8)

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

#--------------------------------------------------------------------
# BUILD
#--------------------------------------------------------------------
func Build() -> void:
	
	# for all tile in template
	for tile in self.tilset_template:
		if _debug: print(tile)
		
		# for all composed tile from template
		for subtiles in tilset_template[tile]:
			if _debug: print("   :"+subtiles)
			var src_tile_pos:String = subtiles.substr(0,2)
			var src_sub_parts:String = subtiles.substr(2,subtiles.length()-2)
			
			# get tile position in source
			var tx:int = self._DecodePosition(src_tile_pos[0])
			var ty:int = self._DecodePosition(src_tile_pos[1])
			
			# calculate sub tile position 
			for sub_tile in src_sub_parts:
				var sub_pos:Vector2 = self._DecodeSubPosition(sub_tile)
				var read_subtile_at = Vector2(tx,ty)+sub_pos
				if _debug: print (read_subtile_at)
				
				#draw subtile to output image
				
				# calc blit rectangel
				var src_rect:Rect2 = Rect2(read_subtile_at.x,read_subtile_at.y,self.tile_width/2,self.tile_height/2)
				
				# calc dst tile position
				var pos_str:PoolStringArray = tile.split(",")
				var dst_pos:Vector2 = Vector2(sub_pos.x+self.tile_width*int(pos_str[0]),sub_pos.y+self.tile_height*int(pos_str[1]))
				
				# blit subtile to tile
				self.tileset_image.blit_rect(self.tiles_input_image,src_rect,dst_pos)
			
	pass

func BuildFromImage(width:int, height:int, src:Image,output_name:String):
	self.SetTileSize(16,16)
	self.SetInputImage(src)
	self.tileset_output_name = output_name
	self.Prepare()
	self.Build()
	self.Save()
	pass
	
func BuildFromTexture(width:int, height:int, src:Texture,output_name:String):
	self.SetTileSize(16,16)
	self.SetInputImage(src.get_data())
	self.tileset_output_name = output_name
	self.Prepare()
	self.Build()
	self.Save()
	pass
	
func BuildFromSprite(width:int, height:int, src:Sprite,output_name:String):
	self.SetTileSize(16,16)
	self.SetInputImage(src.get_texture().get_data())
	self.tileset_output_name = output_name
	self.Prepare()
	self.Build()
	self.Save()
	pass	

func Save():
	
	var auto_tile_atlas_texture:Texture = self.GetResult()
	tilset_template_3x3M_16x16p.tile_set_texture(0,auto_tile_atlas_texture)
	ResourceSaver.save("res://"+self.tileset_output_name+".tres", tilset_template_3x3M_16x16p)
	pass


#--------------------------------------------------------------------
# Tilset RESULT
#--------------------------------------------------------------------
func GetResult() -> ImageTexture:
	var itex = ImageTexture.new()    
	itex.set_storage(ImageTexture.STORAGE_RAW)
	itex.create_from_image(self.tileset_image,0)	
	return itex
	
#--------------------------------------------------------------------
# Tilset SAVE
#--------------------------------------------------------------------	
func SaveTileset(tilset_name:String):
	
	self.tileset_output_name = tilset_name
	
	var auto_tile_atlas_texture:Texture = self.GetResult()
	tilset_template_3x3M_16x16p.tile_set_texture(0,auto_tile_atlas_texture)
	ResourceSaver.save("res://"+self.tileset_output_name+".tres", tilset_template_3x3M_16x16p)
	pass
	