package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Spikes extends FlxSprite
{

	public function new() 
	{
		super();
		loadGraphic(AssetPaths.Spike__png, true, 32, 32);
		moves = false;
		immovable = true;
		
	}
	
}