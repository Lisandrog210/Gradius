package states;

import AssetPaths;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import entities.Player;

class PlayState extends FlxState
{
	private var player:Player;
	private var pivot:FlxSprite;

	override public function create():Void
	{
		super.create();

		player = new Player(100, 150);
		pivot = new FlxSprite(FlxG.width / 2, FlxG.height / 2);

		pivot.makeGraphic(1, 1, 0x00000000);

		pivot.velocity.x = Reg.velocidadCamara;

		FlxG.camera.follow(pivot);

		add(pivot);

		

		add(player);

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}