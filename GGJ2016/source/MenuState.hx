package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	
	private var btnPlay:FlxButton;
	private var btnCredits:FlxButton;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		Reg.playMusic(1);
		
		add(new FlxSprite(0, 0, AssetPaths.menu_pack__png));
		var s:StarEmitter = new StarEmitter();
		add(s);
		
		add(new FlxSprite(0, 0, AssetPaths.menu_glow__png));
		
		var wizimg:FlxSprite = new FlxSprite(0, 0, AssetPaths.small_wizlogo__png);
		wizimg.x = FlxG.width - 50 - wizimg.width;
		wizimg.y = FlxG.height - 10 - wizimg.height;
		add(wizimg);
		
		var title:FlxSprite = new FlxSprite(0, 0, AssetPaths.Logo__png);
		title.x = wizimg.x - title.width + 20;
		title.y = 100;
		add(title);
		
		
		
		var startButton:FlxButton = new FlxButton(0, 0, "Start", OnClickStartButton);
		startButton.loadGraphic("assets/images/BiggerButton.png", true, 148, 34);
		startButton.label.size = 20;
		startButton.x = (FlxG.width / 4) - (startButton.width/2);
		startButton.y = 360;
		//startButton.onUp.sound = FlxG.sound.load(AssetPaths.Boop__wav);
		add(startButton);
		
		var creditsButton:FlxButton = new FlxButton(0, 0, "Credits", OnClickCreditsButton);
		creditsButton.loadGraphic("assets/images/BiggerButton.png", true, 148, 34);
		creditsButton.label.size = 20;
		creditsButton.x = (FlxG.width / 4) - (startButton.width / 2);
		creditsButton.y = 360 +  startButton.height + 20;
		//creditsButton.onUp.sound = FlxG.sound.load(AssetPaths.Boop__wav);
		add(creditsButton);
		
		/*
		var text:FlxText = new FlxText(0, 0, 0, "Press any key to start...");
		text.color = FlxColor.WHITE;
		text.alignment = FlxTextAlign.CENTER;
		text.size = 32;
		text.screenCenter(FlxAxes.X);
		text.y = FlxG.height - text.height - 32;
		add(text);
		*/
		
		FlxG.camera.fade(FlxColor.BLACK, .5, true);
		super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}
	
	function OnClickStartButton():Void
    {
		FlxG.camera.fade(FlxColor.BLACK, .33, false, function() {
			FlxG.switchState(new PlayState());
		});
        
    }
	
	function OnClickCreditsButton():Void
    {
		FlxG.camera.fade(FlxColor.BLACK, .2, false, function() {
			FlxG.switchState(new CreditsState());
		});
    }
}