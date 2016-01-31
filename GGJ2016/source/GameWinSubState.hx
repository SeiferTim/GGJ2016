package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

class GameWinSubState extends FlxSubState
{
	var retryButton:FlxButton;
	var quitButton:FlxButton;
	var text:FlxText;
	var callback:Int->Void;
	private var back:FlxSprite;
	
	public function new(Callback:Int->Void) 
	{
		super(FlxColor.TRANSPARENT);
		callback = Callback;
		
	}
	
	
	override public function create():Void 
	{
		back = new FlxSprite();
		back.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		back.alpha = 0;
		add(back);
		
		
		text = new FlxText();
		text.text = "VICTORY!";
		text.size = 72;
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
		
		FlxTween.tween(back, { "alpha":.5 }, .33, { type:FlxTween.ONESHOT, ease:FlxEase.quintOut, onComplete:finishBlackIn } );
		
		
		super.create();
	}
	
	private function finishBlackIn(_):Void
	{
		FlxTween.tween(text, { "y": text.y+30, "alpha":1 }, 1, { type:FlxTween.ONESHOT, ease:FlxEase.quintOut, onComplete:finishText } );
	}
	
	private function finishText(_):Void
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