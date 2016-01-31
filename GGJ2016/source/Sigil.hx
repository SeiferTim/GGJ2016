package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.FlxSound;

/**
 * ...
 * @author ...
 */
class Sigil extends GameObject
{
	public var collected(default, set):Bool = false;
	public var doorNo:Int = -1;
	private var pressTimer:Float = 0;
	
	private var sigCollect:FlxSound;

	public function new(DoorNo:Int) 
	{
		super();
		doorNo = DoorNo;
		objType = Reg.OBJ_SIGIL;
		loadGraphic(AssetPaths.Sigils__png, true, 32, 32);
		moves = false;
		immovable = true;
		
		sigCollect = FlxG.sound.load(AssetPaths.Ding__wav);
		
		animation.add("Sigil0", [0], 12, true);
		animation.add("Sigil1", [1], 12, true);
		animation.add("Sigil2", [2], 12, true);
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
			sigCollect.play();
			kill();
			if (triggers != -1)
			{
				cast (FlxG.state, PlayState).openDoor(triggers);
			}
		}
			
		return collected;
	}
	
}