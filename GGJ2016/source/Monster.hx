package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.FlxSound;

class Monster extends FlxSprite
{

	public function new() 
	{
		super();
		loadGraphic(AssetPaths.Creature__png, true, 60, 60);
		animation.add("walk", [0, 1, 2], 6);
		
		animation.play("walk");
		velocity.x = 20;
	}
	
}