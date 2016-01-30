package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class GameObject extends FlxSprite
{
	public var objType(default, null):Int;
	public var id:Int = 0;
	public var triggers:Int = -1;
	public var triggered(default, set):Bool = false;
	public function new() 
	{
		super();
		
	}
	
	private function set_triggered(Value:Bool):Bool
	{
		if (triggered == Value)
			return triggered;
		
		triggered = Value;
		
		return triggered;
	}
	
}