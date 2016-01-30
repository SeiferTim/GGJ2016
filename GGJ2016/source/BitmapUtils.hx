package;
import flash.display.BitmapData;
import flash.display3D.textures.RectangleTexture;
import flash.geom.Point;
import flixel.FlxG;
import flixel.util.FlxColor;
import openfl.geom.Rectangle;
using flixel.util.FlxColor;

class BitmapUtils
{

	public static function getThresholds(Source:BitmapData):Array<FlxColor>
	{
		var hi:Int = 0;
		var lo:Int = 255;
		var p:FlxColor;
		for (x in 0...Source.width)
		{
			for (y in 0...Source.height)
			{
				p = Source.getPixel(x, y);
				
				if (p.red > hi)
					hi = p.red;
				if (p.red < lo)
					lo = p.red;
			}
		}
		return [lo, hi];
	}
	
	public static function combineARGBChannels(Alpha:UInt, Red:UInt, Green:UInt, Blue:UInt):UInt
	{
		var color:UInt = 0 ;
		color |= Alpha << 24;
		color |= Red << 16;
		color |= Green << 8;
		color |= Blue;
		return color;
	}
	
	public static inline function colorBitmap(bmp:BitmapData, color:FlxColor):BitmapData
	{
		var redArr:Array<Int> = [];
		var greenArr:Array<Int> = [];
		var blueArr:Array<Int> = [];
		
		var redVal:Int = color >> 16;         // shift 16 for red channel 
		var greenVal:Int = color >> 8 & 0xFF;  // shift 8 and mask for green 
		var blueVal:Int = color & 0xFF; 
		
		for (i in 0...128)
		{ 
			redArr.push( Std.int(redVal/128 * i) << 16);     
			greenArr.push( Std.int(greenVal/128 *i) << 8);  
			blueArr.push( Std.int(blueVal/128 *i) );      
		}
		
		for (i in 0...128)
		{
			redArr.push( Std.int((redVal + (255 - redVal) / 128 * i)) << 16);
			greenArr.push( Std.int((greenVal + (255 - greenVal) / 128 * i)) << 8);
			blueArr.push( Std.int((blueVal + (255 - blueVal) / 128 * i)) );
		}
		
		var coloredBMP:BitmapData = bmp.clone(); 
		coloredBMP.paletteMap(coloredBMP, new Rectangle(0,0,bmp.width,bmp.height), new Point(), redArr, greenArr, blueArr);
		
		
		return coloredBMP;
	}
	
}