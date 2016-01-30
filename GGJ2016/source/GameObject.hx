package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class GameObject extends FlxSprite
{
	public var objType(default, null):Int;
	public var objid:Int = 0;
	public var triggers:Int = -1;
	public var triggered(default, set):Bool = false;
	public var size:Int = 0;
	public var xdist:Int = 0;
	public var ydist:Int = 0;
	public var xspeed:Int = 0;
	public var yspeed:Int = 0;

	private function set_triggered(Value:Bool):Bool
	{
		if (triggered == Value)
			return triggered;
		
		triggered = Value;
		
		return triggered;
	}
	
}
