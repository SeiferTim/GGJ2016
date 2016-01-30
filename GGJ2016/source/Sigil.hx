package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Sigil extends GameObject
{
	public var collected(default, set):Bool = false;
	public var doorNo:Int = -1;
	private var pressTimer:Float = 0;

	public function new(DoorNo:Int) 
	{
		super();
		doorNo = DoorNo;
		objType = Reg.OBJ_SIGIL;
		loadGraphic(AssetPaths.Sigils__png, true, 32, 32);
		moves = false;
		immovable = true;
		
		animation.add("Sigil1", [0], 12, true);
		animation.add("Sigil2", [1], 12, true);
		animation.add("Sigil3", [2], 12, true);
		animation.play("Sigil" + Std.string(doorNo));
	}
	
	private function set_collected(value:Bool):Bool {
		if (value)
			pressTimer = 2;
		if (collected == value)
			return collected;
		collected = value;
		
		if (collected)
		{
			kill();
			if (triggers != -1)
			{
				cast (FlxG.state, PlayState).openDoor(doorNo);
			}
		}
			
		return collected;
	}
	
}