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
	private var ready:Bool = false;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		FlxG.mouse.visible = true;
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
		startButton.label.size = 18;
		startButton.label.font = AssetPaths.LemonMilk__otf;
		startButton.x = (FlxG.width / 4) - (startButton.width/2);
		startButton.y = 360;
		add(startButton);
		
		var creditsButton:FlxButton = new FlxButton(0, 0, "Credits", OnClickCreditsButton);
		creditsButton.loadGraphic("assets/images/BiggerButton.png", true, 148, 34);
		creditsButton.label.size = 18;
		creditsButton.label.font = AssetPaths.LemonMilk__otf;
		creditsButton.x = (FlxG.width / 4) - (startButton.width / 2);
		creditsButton.y = 360 +  startButton.height + 20;
		add(creditsButton);
		
		UIControl.unload();
		UIControl.init([startButton,creditsButton]);
		
		FlxG.camera.fade(FlxColor.BLACK, .5, true, function() { ready = true;} );
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
		if (!ready)
			return;
		ready = false;
		UIControl.unload();
		FlxG.mouse.visible = false;
		FlxG.camera.fade(FlxColor.BLACK, .33, false, function() {
			FlxG.switchState(new PlayState());
		}, true);
        
    }
	
	function OnClickCreditsButton():Void
    {
		if (!ready)
			return;
		ready = false;
		UIControl.unload();
		FlxG.camera.fade(FlxColor.BLACK, .2, false, function() {
			FlxG.switchState(new CreditsState());
		}, true);
    }
	
	override public function update(elapsed:Float):Void 
	{
		if (FlxG.keys.anyJustReleased([F4, F]))
		{
			Reg.toggleFullscreen();
		}
		
		if(ready)
			UIControl.checkControls(elapsed);
		
		super.update(elapsed);
	}
}