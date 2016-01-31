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
	private var fall:Bool = false;
	private var p:Imp;
	
	override public function create():Void 
	{
		FlxG.mouse.visible = false;
		bgColor = FlxColor.BLACK;
		
		madeIn = new FlxSprite(0, 0, AssetPaths.made_in_stl__png);
		madeIn.alpha = 0;
		madeIn.screenCenter(FlxAxes.XY);
		add(madeIn);
		
		p = new Imp();
		p.isReal = false;
		p.x  = -p.width;
		p.y = FlxG.height;
		
		var r:RainbowTrail = new RainbowTrail(p, RainbowTrail.STYLE_RAINBOW);
		add(r);
		
		add(p);
		
		FlxTween.tween(madeIn, { "alpha":1 }, 1, { type:FlxTween.ONESHOT, ease:FlxEase.quintOut, onComplete:finishIn } );
		
		
		super.create();
	}
	
	private function finishIn(_):Void
	{
		FlxG.sound.play(AssetPaths.madeinstl__wav, 1, false, null,true, finishSoundA);
		
	}
	
	private function finishSoundA():Void
	{
		fall = true;
		p.velocity.x = 40000;
		p.velocity.y = -1400;
		p.angularVelocity = 100;
		p.acceleration.y = 1600;
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
	
	
	override public function update(elapsed:Float):Void 
	{
		
		super.update(elapsed);
		if (!fall)
		{
			p.velocity.y = 0;
			p.velocity.x = 0;
			p.acceleration.y = 0;
		}
	}
	
}