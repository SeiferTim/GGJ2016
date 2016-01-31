package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

class IntroState extends FlxState
{
	private var madeIn:FlxSprite;
	
	override public function create():Void 
	{
		bgColor = FlxColor.BLACK;
		
		madeIn = new FlxSprite(0, 0, AssetPaths.made_in_stl__png);
		madeIn.alpha = 0;
		madeIn.screenCenter(FlxAxes.XY);
		add(madeIn);
		
		FlxTween.tween(madeIn, { "alpha":1 }, 1, { type:FlxTween.ONESHOT, ease:FlxEase.quintOut, onComplete:finishIn } );
		
		
		super.create();
	}
	
	private function finishIn(_):Void
	{
		FlxG.sound.play(AssetPaths.GiggleFX__wav, 1, false, null,true, finishSound);
	}
	
	private function finishSound():Void
	{
		FlxTween.tween(madeIn, { "alpha":1 }, 1, { type:FlxTween.ONESHOT, ease:FlxEase.quintOut, startDelay:1, onComplete:finishOut } );
	}
	
	private function finishOut(_):Void
	{
		FlxG.switchState(new MenuState());
	}
	
}