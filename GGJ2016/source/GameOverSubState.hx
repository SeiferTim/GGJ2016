package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

class GameOverSubState extends FlxSubState
{

	var red:FlxSprite;
	var red2:FlxSprite;
	var blood1:FlxSprite;
	var blood2:FlxSprite;
	var text:FlxText;
	
	var retryButton:FlxButton;
	var quitButton:FlxButton;
	
	var callback:Int->Void;
	
	public function new(Callback:Int->Void) 
	{
		super(FlxColor.TRANSPARENT);
		callback = Callback;
		
	}
	
	
	
	override public function create():Void 
	{
		
		blood1 = new FlxSprite(0, 0, AssetPaths.Layer1_Blood__png);
		blood2 = new FlxSprite(0, 0, AssetPaths.Layer2_Blood__png);
		
		blood1.y = -FlxMath.maxInt(Std.int(blood1.height), Std.int(blood2.height));
		blood2.y = blood1.y - blood1.height;
		
		red = new FlxSprite();
		red.makeGraphic(FlxG.width, FlxG.height, 0xffe40d0d);
		red.y = blood1.y - red.height +1;
		
		red2 = new FlxSprite();
		red2.makeGraphic(FlxG.width, FlxG.height, 0xffe40d0d);
		red2.y = blood2.y - red2.height +1;
		
		add(blood1);
		add(blood2);
		add(red);
		add(red2);
		
		blood1.velocity.y = red.velocity.y = 200;
		blood2.velocity.y = 400;
		red2.velocity.y = 400;
		
		text = new FlxText();
		text.text = "GAME OVER!";
		text.size = 130;
		text.font = AssetPaths.LemonMilk__otf;
		text.color = FlxColor.WHITE;
		text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2, 10);
		text.screenCenter(FlxAxes.XY);
		text.y -= 30;
		text.alpha = 0;
		add(text);
		
		retryButton = new FlxButton(0, 0, "Retry", OnClickRetryButton);
		retryButton.loadGraphic("assets/images/BiggerButton.png", true, 148, 34);
		retryButton.label.size = 18;
		retryButton.label.font = AssetPaths.LemonMilk__otf;
		retryButton.x = (FlxG.width / 4) - (retryButton.width/2);
		retryButton.y = text.y + 30 + text.height + 50;
		retryButton.alpha = 0;
		add(retryButton);
		quitButton = new FlxButton(0, 0, "Quit", OnClickQuitButton);
		quitButton.loadGraphic("assets/images/BiggerButton.png", true, 148, 34);
		quitButton.label.size = 18;
		quitButton.label.font = AssetPaths.LemonMilk__otf;
		quitButton.x = (FlxG.width * .75) - (quitButton.width / 2);
		quitButton.y = text.y + 30 + text.height + 50;
		quitButton.alpha = 0;
		add(quitButton);
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (blood1.y > FlxG.height)
			blood1.kill();
		if (blood2.y > FlxG.height)
			blood2.kill();
		if (red2.y > 0)
		{
			red2.velocity.y = 0;
			red2.y = 0;
			
		}
		if (red.y > 0)
		{
			red.kill();
			
		}
		if (red2.velocity.y == 0)
		{
			if (text.alpha == 0)
				FlxTween.tween(text, { "y": text.y+30, "alpha":1 }, 1, { type:FlxTween.ONESHOT, ease:FlxEase.quintOut, onComplete:finishBlood } );
		}
		super.update(elapsed);
	}
	
	private function finishBlood(_):Void
	{
		FlxTween.tween(retryButton, { "alpha":1 }, .66, { type:FlxTween.ONESHOT, ease:FlxEase.quintOut } );
		FlxTween.tween(quitButton, { "alpha":1 }, .66, { type:FlxTween.ONESHOT, ease:FlxEase.quintOut } );
		FlxG.mouse.visible = true;
	}
	private function OnClickRetryButton():Void
	{
		FlxG.mouse.visible = false;
		closeCallback = callback.bind(0);
		FlxG.camera.fade(FlxColor.BLACK, .2, false, function() {	
			close();
		});
		
	}
	
	private function OnClickQuitButton():Void
	{
		FlxG.mouse.visible = false;
		closeCallback = callback.bind(1);
		FlxG.camera.fade(FlxColor.BLACK, .2, false, function() {	
			close();
		});
	}
}