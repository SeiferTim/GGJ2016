package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Button extends FlxSprite
{
	public var objType(default, null):Int;
	public var pressed(default, set):Bool = false;
	
	public function new() 
	{
		super();
		objType = Reg.OBJ_BUTTON;
		loadGraphic(AssetPaths.Button__png, true, 32, 32);
		moves = false;
		immovable = true;
		
		animation.add("unpressed", [0], 12, true);
		animation.add("pressed", [1], 12, true);
		animation.play("unpressed", true);
		
	}
	
	private function set_pressed(value:Bool):Bool {
		
		pressed = value;
		
		if (pressed)
			animation.play("pressed");
		else
			animation.play("unpressed");
			
		return pressed;
	}
	
}