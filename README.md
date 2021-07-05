# Godot 3.1 Tileset Builder
Create 3x3 MINIMAL tileset from image:

- Input example

![Alt text](Screenshots/AutoTile_1.png?raw=true "PREVIEW")

- Base output:

![Alt text](Screenshots/Godot_v3.1-stable_win64_2019-03-18_21-39-47.png?raw=true "PREVIEW")

- Reordered output (new feature)

FROM 

![Alt text](Screenshots/AutoTile_1_spritesheet.png?raw=true "PREVIEW")

TO

![Alt text](Screenshots/AutoTile_1_spritesheet_UNITY.png?raw=true "PREVIEW")

- Features:
  - build from Image
  - build from Images (example in code under # method #2d )
  - build from Texture
  - build from Sprite
  - user defined tile size
  - user defined tile with collision shape or not
  - save tileset to user defined tres
  - get result as texture
  - tileset is saved with bitmask per tile
  - collision shapes is not defined
  - autotile mode is included
  - reordering finalized tileset by user defined ordering


# Usage:

- Example #1
``` python
	var image = Image.new()	
	image.load("res://Sprites/Example/AutoTile_1.png")
	Builder.SetTileSize(16,16)	
	Builder.SetInputImage(image)	
	Builder.Prepare()
	Builder.Build(true) # if true generate collision shape 
	Builder.tileset_output_name = "res://TileSet/TestTilset_3x3M_16x16pix.tres"
	Builder.Save()		
```

- Example #2
``` python
	var image = Image.new()	
	var image_folder = "res://Sprites/Example"
	var image_filename = "AutoTile_1.png"
	var image_name = "AutoTile_1"

	image.load(image_folder+"/"+image_filename)
	image.set_name(image_name);
	Builder.BuildFromImage(16,16,image,"res://TestTilset_3x3M_16x16pix.tres",true)
	get_node("UserInput/SpriteOutput").texture = Builder.GetResult()
```
- Example #3
``` python
var Builder =  TilesetBuilder.new()
Builder.BuildFromTexture(16,16,get_node("UserInput/SpriteInput").get_texture(),"res://TestTilset_3x3M_16x16pix.tres")
```
- Example #4
``` python
var Builder =  TilesetBuilder.new()
Builder.BuildFromSprite(16,16,get_node("UserInput/SpriteInput"),"res://TestTilset_3x3M_16x16pix.tres")
```

- Example #5
``` python
	var image1 = Image.new()	
	image1.load("res://Sprites/Example/AutoTile_1.png")
	var image2 = Image.new()	
	image2.load("res://Sprites/Example/AutoTile_2.png")

	var images = { 
		"0" : {"name": "AutoTile_1" ,"width":16,"height":16, "src":image1,"collshape":true},
		"1" : {"name": "AutoTile_2" ,"width":16,"height":16, "src":image2,"collshape":true}
		}

	Builder.BuildFromImages(images,"res://TileSet/TestTilset_from_img_list.tres")
```

- Example #6
``` python
	var images_json = { 
		"0" : {"name": "AutoTile_1" ,"width":16,"height":16, "src":"res://Sprites/Example/AutoTile_1.png","collshape":true}
	}
	
	Utils.SaveJSON("res://TilesetImages4Unity.data",images_json,true)
	
	Builder.BuildFromFile(Utils.LoadJSON("res://TilesetImages4Unity.data"),"TestTilset_from_img_list.tres")
	
	Builder.ReorderTileset(
		"res://TileSet_Spritesheet/AutoTile_1_spritesheet.png",
		"res://TileSet_Spritesheet/AutoTile_1_spritesheet_UNITY.png",
		16,16,
		Builder.tileset_ruletile,
		Builder.tileset_ruletile_w,
		Builder.tileset_ruletile_h)

```
