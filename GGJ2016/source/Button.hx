package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Button extends GameObject
{
	
	public var pressed(default, set):Bool = false;
	private var pressTimer:Float = 0;
	
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
		FlxG.watch.add(this, "pressed");
		
	}
	
	private function set_pressed(value:Bool):Bool {
		if (value)
			pressTimer = 2;
		if (pressed == value)
			return pressed;
		pressed = value;
		
		if (pressed)
		{
			animation.play("pressed");
			if (triggers != -1)
			{
				cast (FlxG.state, PlayState).triggerObj(triggers);
			}
		}
		else
		{
			animation.play("unpressed");
			if (triggers != -1)
			{
				cast (FlxG.state, PlayState).untriggerObj(triggers);
			}
		}
			
		return pressed;
	}
	
	
	override public function update(elapsed:Float):Void 
	{
		if (pressed)
		{
			if (pressTimer>0)
				pressTimer -= elapsed;
			else
			{
				pressed = false;
			}
		}
		
		super.update(elapsed);
	}
	
}