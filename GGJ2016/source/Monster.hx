package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Monster extends FlxSprite
{

	public function new() 
	{
		super();
		loadGraphic(AssetPaths.Creature__png, true, 60, 60);
		animation.add("walk", [0, 1, 2], 15);
		animation.play("walk");
		velocity.x = 50;
	}
	
}