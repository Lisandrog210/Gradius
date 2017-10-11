package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class Menu extends FlxState 
{
	private var PlayButton:FlxButton;
	private var Title: FlxText;
	private var Text: FlxText;
	private var Text2: FlxText;

	override public function create():Void
	{
		super.create();
		
		Title = new FlxText(60, 25, FlxG.width, "El Gradióluh");
		Title.setFormat(null, 20, FlxColor.RED);
		add(Title);
		
		Text = new FlxText(70, 100, FlxG.width, "Press 'Space' to play");
		add(Text);
		
		Text2 = new FlxText(20, 150, FlxG.width, "Created by: Lisandro Guevara, Garcia Agustin");
		Text2.setFormat(null, 8);
		add(Text2);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (FlxG.keys.pressed.SPACE) 
		{
			ClickPlay();
		}
	}
	
	function ClickPlay():Void
	{
		FlxG.switchState(new PlayState());
	}
	
}