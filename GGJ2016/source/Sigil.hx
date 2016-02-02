package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.FlxSound;
import flixel.tweens.FlxTween;

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
		
		switch (doorNo) 
		{
			case 0:
				loadRotatedGraphic(AssetPaths.sigil_1__png, 360, -1, false, false, "sigil-1");
			case 1:
				loadRotatedGraphic(AssetPaths.sigil_2__png, 360, -1, false, false, "sigil-2");
			case 2:
				loadRotatedGraphic(AssetPaths.sigil_3__png, 360, -1, false, false, "sigil-3");
			
				
		}
		
		//loadGraphic(AssetPaths.Sigils__png, true, 32, 32);
		//loadRotatedGraphic(AssetPaths.Sigils__png);
		
		moves = true;
		immovable = true;
		
		sigCollect = FlxG.sound.load(AssetPaths.Ding__wav);
		
		angularVelocity = -200;
		
	}
	
	public function spawn(X:Float, Y:Float):Void
	{
		FlxTween.circularMotion(this, X - 8, Y + 8, 16, FlxG.random.float(0, 360), true, 2, true, { type:FlxTween.LOOPING } );
		
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