package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Spikes extends GameObject
{
	
	public function new() 
	{
		super();
		objType = Reg.OBJ_SPIKES;
		loadGraphic(AssetPaths.Spike__png, true, 32, 32);
		moves = false;
		immovable = true;
		
	}
	
}