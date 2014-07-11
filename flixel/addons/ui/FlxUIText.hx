package flixel.addons.ui;

import flixel.addons.ui.FlxUI.UIEventCallback;
import flixel.addons.ui.interfaces.IFlxUIWidget;
import flixel.addons.ui.interfaces.IHasParams;
import flixel.addons.ui.interfaces.IResizable;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.loaders.TextureAtlasFrame;

/**
 * Simple extension to the basic text field class.
 * @author Lars Doucet
 */
class FlxUIText extends FlxText implements IResizable implements IFlxUIWidget implements IHasParams
{
	public var broadcastToFlxUI:Bool = true;
	
	public var id:String; 
	
	public var params(default, set):Array<Dynamic>;
	
	public function resize(w:Float, h:Float):Void {
		width = w;
		height = h;
		
		var old_size:Float = size;
		var diff:Float = height - cachedGraphics.bitmap.height;
		var failsafe:Int = 0;
		while (diff > 0 && failsafe < 999)
		{
			failsafe++;
			size = size+1;
			calcFrame();
			diff = (h - cachedGraphics.bitmap.height);
		}
		if (failsafe >= 999)
		{
			FlxG.log.warn("Loop failsafe tripped while resizing FlxUIText to height(" + h + ")");
			size = old_size;
		}
	}
	
	public function set_params(p:Array<Dynamic>):Array<Dynamic>
	{
		params = p;
		return params;
	}
	
	public override function clone():FlxUIText
	{
		var newText = new FlxUIText();
		newText.width = width;
		newText.height = height;
		newText.setFormat(font, size, color);
		
		//for some reason, naively setting (f.alignment = alignment) causes cast errors!
		if (_defaultFormat != null && _defaultFormat.align != null)
		{
			newText.alignment = alignment;
		}
		newText.setBorderStyle(borderStyle, borderColor, borderSize, borderQuality);
		newText.text = text;
		return newText;
	}
}
