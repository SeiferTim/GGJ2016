package;


import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
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
	private var wiz:FlxSprite;
	private var imps:FlxTypedGroup<Imp>;
	private var impRain:FlxTypedGroup<RainbowTrail>;
	private var impsReady:Bool = false;
	private var impTimer:Float = 0;
	private var impSpawn:FlxSound;
	private var cookies:FlxSprite;
	
	public function new(Callback:Int->Void) 
	{
		super(FlxColor.TRANSPARENT);
		callback = Callback;
		
	}
	
	
	override public function create():Void 
	{
		
		impSpawn = FlxG.sound.load(AssetPaths.GiggleFX__wav);
		back = new FlxSprite();
		back.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		back.alpha = 0;
		add(back);
		
		
		imps = new FlxTypedGroup<Imp>(5);
		
		impRain = new FlxTypedGroup<RainbowTrail>(5);
		add(impRain);
		add(imps);
		
		text = new FlxText();
		text.text = "VICTORY!";
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
		
		wiz = new FlxSprite();
		wiz.loadGraphic(AssetPaths.Wizard__png, true, 32, 32);
		wiz.animation.frameIndex = 3;
		wiz.y = text.y - wiz.height - 50;
		wiz.screenCenter(FlxAxes.X);
		wiz.alpha = 0;
		add(wiz);
		
		cookies = new FlxSprite();
		cookies.loadGraphic(AssetPaths.victory_cookies__png, true, 32, 32);
		cookies.animation.add("cookies", [0, 1, 2, 3, 4], 12);
		cookies.animation.play("cookies");
		cookies.alpha = 0;
		cookies.x = wiz.x;
		cookies.y = wiz.y - cookies.height;
		add(cookies);
		
		
		FlxTween.tween(back, { "alpha":.8 }, .5, { type:FlxTween.ONESHOT, ease:FlxEase.quintOut, onComplete:finishBlackIn } );
		
		
		super.create();
	}
	
	private function finishBlackIn(_):Void
	{
		FlxTween.tween(text, { "y": text.y+30, "alpha":1 }, 1, { type:FlxTween.ONESHOT, ease:FlxEase.quintOut, onComplete:finishText } );
		FlxTween.tween(wiz, { "alpha":1 }, 1, { type:FlxTween.ONESHOT, ease:FlxEase.quintOut, startDelay:.33 } );
		FlxTween.tween(cookies, { "alpha":1 }, 1, { type:FlxTween.ONESHOT, ease:FlxEase.quintOut, startDelay:.66, onComplete:cookiesFinished } );
	}
	
	private function cookiesFinished(_):Void
	{
		FlxTween.linearMotion(cookies, cookies.x, cookies.y, cookies.x, cookies.y - 32, 2, true, { type:FlxTween.PINGPONG, ease:FlxEase.sineInOut } );
	}
	
	private function finishText(_):Void
	{
		impsReady = true;
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
	
	override public function update(elapsed:Float):Void 
	{
		if (impsReady)
		{
			impTimer -= elapsed;
			if (impTimer <= 0)
			{
				var i:Imp = imps.recycle(Imp);
				if (i == null)
				{
					i = new Imp();
					
				}
				i.isReal = false;
				i.x  = FlxG.random.float( -i.width, FlxG.width);
				i.y = FlxG.height;
				i.velocity.x = FlxG.random.int( -8, 8) * 5000;
				i.velocity.y = -1000 - (FlxG.random.int(0, 10) * 100);
				i.angularVelocity = FlxG.random.int( -6, 6) * 50;
				i.acceleration.y = 1600;
				impSpawn.play();
				impTimer = FlxG.random.int(1, 4) * .5;
				imps.add(i);
				
				var r:RainbowTrail = impRain.recycle(RainbowTrail);
				if (r == null)
				{
					r = new RainbowTrail(i, RainbowTrail.STYLE_RAINBOW);
				}
				else
				{
					r.spawn(i, RainbowTrail.STYLE_RAINBOW);
				}
				impRain.add(r);
			}
		}
		super.update(elapsed);
	}
	
}