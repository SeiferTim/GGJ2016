package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.FlxSound;
import flixel.tweens.FlxTween;

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
		
		animation.add("Sigil0", [0,1], 12, true);
		animation.add("Sigil1", [2,3], 12, true);
		animation.add("Sigil2", [4,5], 12, true);
		animation.play("Sigil" + Std.string(doorNo));
		
		
	}
	
	public function spawn(X:Float, Y:Float):Void
	{
		FlxTween.circularMotion(this, X-8, Y+8, 16, FlxG.random.float(0, 360), true, 2, true, { type:FlxTween.LOOPING } );
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