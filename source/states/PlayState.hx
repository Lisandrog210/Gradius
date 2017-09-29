package states;

import AssetPaths;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import entities.Player;
import flixel.addons.display.FlxBackdrop;

class PlayState extends FlxState
{
	private var player:Player;
	private var pivot:FlxSprite;
	private var background:FlxBackdrop;

	override public function create():Void
	{
		super.create();
		
		pivot = new FlxSprite(FlxG.width / 2, FlxG.height / 2);
		pivot.makeGraphic(1, 1, 0x00000000);
		pivot.velocity.x = Reg.velocidadCamara;
		FlxG.camera.follow(pivot);
		add(pivot);
		
		background = new FlxBackdrop(AssetPaths.wallpaper__png);
		add(background);
		
		player = new Player(100, 150);
		add(player);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	
}