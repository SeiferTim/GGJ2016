package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Wiz extends FlxSprite
{
	public var casting:Bool = false;
	public function new()
	{
		super();
		loadGraphic(AssetPaths.Wizard__png, true, 32, 32);
		animation.add("idle", [0], 12, true);
		animation.add("walking", [1, 2], 12, true);
		animation.add("cast", [3], 12, true);
		animation.play("idle");
		
		
	}
	
}