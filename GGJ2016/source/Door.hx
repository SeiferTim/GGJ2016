package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Door extends FlxSprite
{

	private var startY:Float;
	public function new(X:Float, Y:Float, DoorNo:Int ) 
	{
		super(X,Y);
		startY = Y;
		loadGraphic(AssetPaths.Doors__png, true, 32, 64);
		animation.add("door-0", [0]);
		animation.add("door-1", [1]);
		animation.add("door-2", [2]);
		animation.play("door-" + Std.string(DoorNo));
		
		
	}
	
	public function open():Void
	{
		velocity.y = -20;
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (y < startY - height)
			kill();
		
		super.update(elapsed);
	}
	
}