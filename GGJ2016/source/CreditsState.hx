package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.ui.FlxButton;

/**
 * ...
 * @author ...
 */
class CreditsState extends FlxState
{

	private var btnPlay:FlxButton;
	private var btnCredits:FlxButton;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		var verticalSpace = 40;  //Variables to handle margins and spacing
		var leftMargin = 100;
		var width = 1000;
		
		var mgmtTitle:FlxText = new FlxText(leftMargin, verticalSpace, width); // x, y, width
		mgmtTitle.text = "Production Management";
		mgmtTitle.color = FlxColor.WHITE;
		mgmtTitle.size = 20;
		mgmtTitle.alignment = "center";
		add(mgmtTitle);
		
		var mgmtCrew:FlxText = new FlxText(leftMargin, (verticalSpace+=40), width); // x, y, width
		mgmtCrew.text = "Tim I. Hely (@AxolStudio)";
		mgmtCrew.color = FlxColor.WHITE;
		mgmtCrew.size = 15;
		mgmtCrew.alignment = "center";
		add(mgmtCrew);
		
		var designTitle:FlxText = new FlxText(leftMargin, (verticalSpace+=50), width); // x, y, width
		designTitle.text = "Concept & Design";
		designTitle.color = FlxColor.WHITE;
		designTitle.size = 20;
		designTitle.alignment = "center";
		add(designTitle);
		
		var designCrew:FlxText = new FlxText(leftMargin, (verticalSpace+=40), width); // x, y, width
		designCrew.text = "Tim Hely\t\tEmma Daues (@audinoEars)\t\tT. C. Painter (@theresacpainter)\t\tVicky Hedgecock";
		designCrew.color = FlxColor.WHITE;
		designCrew.size = 15;
		designCrew.alignment = "center";
		add(designCrew);
		
		var artTitle:FlxText = new FlxText(leftMargin, (verticalSpace+=50), width); // x, y, width
		artTitle.text = "Graphics & Art";
		artTitle.color = FlxColor.WHITE;
		artTitle.size = 20;
		artTitle.alignment = "center";
		add(artTitle);
		
		var artCrew:FlxText = new FlxText(leftMargin, (verticalSpace+=40), width); // x, y, width
		artCrew.text = "Vicky Hedgecock\t\tT.C. Painter\t\tLaray McGee (@SincereVenom)";
		artCrew.color = FlxColor.WHITE;
		artCrew.size = 15;
		artCrew.alignment = "center";
		add(artCrew);
		
		var progTitle:FlxText = new FlxText(leftMargin, (verticalSpace+=50), width); // x, y, width
		progTitle.text = "Programming";
		progTitle.color = FlxColor.WHITE;
		progTitle.size = 20;
		progTitle.alignment = "center";
		add(progTitle);
		
		var progCrew:FlxText = new FlxText(leftMargin, (verticalSpace+=40), width); // x, y, width
		progCrew.text = "Tim Hely\t\tEmma Daues";
		progCrew.color = FlxColor.WHITE;
		progCrew.size = 15;
		progCrew.alignment = "center";
		add(progCrew);
		
		var musicTitle:FlxText = new FlxText(leftMargin, (verticalSpace+=50), width); // x, y, width
		musicTitle.text = "Music & SFX";
		musicTitle.color = FlxColor.WHITE;
		musicTitle.size = 20;
		musicTitle.alignment = "center";
		add(musicTitle);
		
		var musicCrew:FlxText = new FlxText(leftMargin, (verticalSpace+=40), width); // x, y, width
		musicCrew.text = "Sarah Wahoff (miwic.bandcamp.com)\t\tAndy Garces (thevanillabeans.bandcamp.com)";
		musicCrew.color = FlxColor.WHITE;
		musicCrew.size = 15;
		musicCrew.alignment = "center";
		add(musicCrew);
		
		var musicTitle:FlxText = new FlxText(leftMargin, (verticalSpace+=50), width); // x, y, width
		musicTitle.text = "Resident Jévion";
		musicTitle.color = FlxColor.WHITE;
		musicTitle.size = 20;
		musicTitle.alignment = "center";
		add(musicTitle);
		
		var musicCrew:FlxText = new FlxText(leftMargin, (verticalSpace+=40), width); // x, y, width
		musicCrew.text = "Jévion White (@OrianWolf)";
		musicCrew.color = FlxColor.WHITE;
		musicCrew.size = 15;
		musicCrew.alignment = "center";
		add(musicCrew);
		
		var musicCrew:FlxText = new FlxText(leftMargin, (verticalSpace+=50), width); // x, y, width
		musicCrew.text = "Created for Global Game Jam 2016 | Theme: \"Ritual\"";
		musicCrew.color = FlxColor.WHITE;
		musicCrew.size = 15;
		musicCrew.alignment = "center";
		add(musicCrew);
		
		var backButton:FlxButton = new FlxButton(550, (verticalSpace+=40), "Back to Menu", OnClickBackButton);
		backButton.loadGraphic("assets/images/BiggerButton.png", true, 148, 34);
		add(backButton);

		
		super.create();
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}
	
	function OnClickBackButton():Void
    {
        FlxG.switchState(new MenuState());
    }
	
}