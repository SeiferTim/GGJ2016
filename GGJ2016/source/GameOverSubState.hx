package;

import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

class GameOverSubState extends FlxSubState
{

	public function new() 
	{
		super(FlxColor.TRANSPARENT);
		
		
	}
	
	override public function create():Void 
	{
		
		var text:FlxText = new FlxText();
		text.text = "GAME OVER!";
		text.size = 60;
		text.color = FlxColor.WHITE;
		text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2, 10);
		text.screenCenter(FlxAxes.XY);
		add(text);
		
		super.create();
	}
	
}