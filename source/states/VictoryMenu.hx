package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class VictoryMenu extends FlxState 
{
	private var Title:FlxText;
	private var Text:FlxText;
	private var Text2:FlxText;

	override public function create():Void
	{
		Title = new FlxText(100, 20, FlxG.width, "Victory");
		Title.setFormat(null, 12, FlxColor.RED);
		add(Title);
		
		Text = new FlxText(70, 50, FlxG.width, "Press 'Space' to menu");
		add(Text);
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (FlxG.keys.justPressed.SPACE)
		{
			FlxG.switchState(new Menu());
		}
	}
}
