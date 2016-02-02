package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.ui.FlxButton;
import flixel.util.FlxDestroyUtil;

/**
 * ...
 * @author ...
 */
class CreditsState extends FlxState
{

	private var ready:Bool = false;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		var verticalSpace = 50;  //Variables to handle margins and spacing
		var leftMargin = 100;
		var width = 1080;
		
		var mgmtTitle:FlxText = new FlxText(leftMargin, verticalSpace, width); // x, y, width
		mgmtTitle.text = "Production Management";
		mgmtTitle.color = FlxColor.WHITE;
		mgmtTitle.size = 24;
		mgmtTitle.bold = true;
		mgmtTitle.font = AssetPaths.LemonMilk__otf;
		mgmtTitle.alignment = "center";
		add(mgmtTitle);
		
		var mgmtCrew:FlxText = new FlxText(leftMargin, (verticalSpace+=40), width); // x, y, width
		mgmtCrew.text = "Tim I. Hely (@AxolStudio)";
		mgmtCrew.color = FlxColor.WHITE;
		mgmtCrew.size = 18;
		mgmtCrew.font = AssetPaths.LemonMilk__otf;
		mgmtCrew.alignment = "center";
		add(mgmtCrew);
		
		var designTitle:FlxText = new FlxText(leftMargin, (verticalSpace+=50), width); // x, y, width
		designTitle.text = "Concept & Design";
		designTitle.color = FlxColor.WHITE;
		designTitle.size = 24;
		designTitle.bold = true;
		designTitle.font = AssetPaths.LemonMilk__otf;
		designTitle.alignment = "center";
		add(designTitle);
		
		var designCrew:FlxText = new FlxText(leftMargin, (verticalSpace+=40), width); // x, y, width
		designCrew.text = "Tim Hely\t\tEmma Daues (@audinoEars)\t\tT. C. Painter (@theresacpainter)\t\tVicky Hedgecock";
		designCrew.color = FlxColor.WHITE;
		designCrew.size = 18;
		designCrew.font = AssetPaths.LemonMilk__otf;
		designCrew.alignment = "center";
		add(designCrew);
		
		var artTitle:FlxText = new FlxText(leftMargin, (verticalSpace+=50), width); // x, y, width
		artTitle.text = "Graphics & Art";
		artTitle.color = FlxColor.WHITE;
		artTitle.size = 24;
		artTitle.font = AssetPaths.LemonMilk__otf;
		artTitle.bold = true;
		artTitle.alignment = "center";
		add(artTitle);
		
		var artCrew:FlxText = new FlxText(leftMargin, (verticalSpace+=40), width); // x, y, width
		artCrew.text = "Vicky Hedgecock\t\tT.C. Painter\t\tLaray McGee (@SincereVenom)";
		artCrew.color = FlxColor.WHITE;
		artCrew.size = 18;
		artCrew.font = AssetPaths.LemonMilk__otf;
		artCrew.alignment = "center";
		add(artCrew);
		
		var progTitle:FlxText = new FlxText(leftMargin, (verticalSpace+=50), width); // x, y, width
		progTitle.text = "Programming";
		progTitle.color = FlxColor.WHITE;
		progTitle.size = 24;
		progTitle.font = AssetPaths.LemonMilk__otf;
		progTitle.bold = true;
		progTitle.alignment = "center";
		add(progTitle);
		
		var progCrew:FlxText = new FlxText(leftMargin, (verticalSpace+=40), width); // x, y, width
		progCrew.text = "Tim Hely\t\tEmma Daues";
		progCrew.color = FlxColor.WHITE;
		progCrew.size = 18;
		progCrew.font = AssetPaths.LemonMilk__otf;
		progCrew.alignment = "center";
		add(progCrew);
		
		var musicTitle:FlxText = new FlxText(leftMargin, (verticalSpace+=50), width); // x, y, width
		musicTitle.text = "Music & SFX";
		musicTitle.color = FlxColor.WHITE;
		musicTitle.size = 24;
		musicTitle.font = AssetPaths.LemonMilk__otf;
		musicTitle.bold = true;
		musicTitle.alignment = "center";
		add(musicTitle);
		
		var musicCrew:FlxText = new FlxText(leftMargin, (verticalSpace+=40), width); // x, y, width
		musicCrew.text = "Sarah Wahoff (miwsic.bandcamp.com)\t\tAndy Garces (thevanillabeans.bandcamp.com)";
		musicCrew.color = FlxColor.WHITE;
		musicCrew.size = 18;
		musicCrew.font = AssetPaths.LemonMilk__otf;
		musicCrew.alignment = "center";
		add(musicCrew);
		
		var musicTitle:FlxText = new FlxText(leftMargin, (verticalSpace+=50), width); // x, y, width
		musicTitle.text = "Resident FlyGuy";
		musicTitle.color = FlxColor.WHITE;
		musicTitle.size = 24;
		musicTitle.font = AssetPaths.LemonMilk__otf;
		musicTitle.bold = true;
		musicTitle.alignment = "center";
		add(musicTitle);
		
		var musicCrew:FlxText = new FlxText(leftMargin, (verticalSpace+=40), width); // x, y, width
		musicCrew.text = "Jévion White (@OrianWolf)";
		musicCrew.color = FlxColor.WHITE;
		musicCrew.size = 18;
		musicCrew.font = AssetPaths.LemonMilk__otf;
		musicCrew.alignment = "center";
		add(musicCrew);
		
		var musicCrew:FlxText = new FlxText(leftMargin, (verticalSpace+=50), width); // x, y, width
		musicCrew.text = "Created for Global Game Jam 2016 | Theme: \"Ritual\"";
		musicCrew.color = FlxColor.WHITE;
		musicCrew.size = 18;
		musicCrew.font = AssetPaths.LemonMilk__otf;
		musicCrew.bold = true;
		musicCrew.alignment = "center";
		add(musicCrew);
		
		var backButton:FlxButton = new FlxButton(550, (verticalSpace+=40), "Back to Menu", OnClickBackButton);
		backButton.loadGraphic("assets/images/BiggerButton.png", true, 148, 34);
		//backButton.onUp.callback = OnButtonUp;
		backButton.label.size = 18;
		backButton.label.font = AssetPaths.LemonMilk__otf;
		backButton.screenCenter(FlxAxes.X);
		add(backButton);

		
		UIControl.unload();
		UIControl.init([backButton]);
		
		FlxG.camera.fade(FlxColor.BLACK, .2, true, function() { ready = true; } );
		
		super.create();
	}
	
	/*
	function OnButtonUp():Void {
		
		buttonSound.play(true);		
	}
	*/
	
	function OnClickBackButton():Void
    {
		if (!ready)
			return;
		ready = false;
		UIControl.unload();
		FlxG.camera.fade(FlxColor.BLACK, .2, false, function() {
			FlxG.switchState(new MenuState());
		}, true);
        
    }
	
	
	override public function destroy():Void
	{
		
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (FlxG.keys.anyJustReleased([F4, F]))
		{
			Reg.toggleFullscreen();
		}
		
		if (ready)
			UIControl.checkControls(elapsed);
			
		super.update(elapsed);
	}
	
}