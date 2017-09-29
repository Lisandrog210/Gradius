package states;

import AssetPaths;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import entities.Player;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;

class PlayState extends FlxState
{
	private var loader:FlxOgmoLoader;
	private var player:Player;
	private var pivot:FlxSprite;
	private var background:FlxBackdrop;
	private var tilemap:FlxTilemap;

	override public function create():Void
	{
		super.create();
		
		loader= new FlxOgmoLoader(AssetPaths.level1GradiusGG__oel);
		tilemap = loader.loadTilemap();
		
		pivot = new FlxSprite(FlxG.width / 2, FlxG.height / 2);
		pivot.makeGraphic(1, 1, 0x00000000);
		pivot.velocity.x = Reg.velocidadCamara;
		FlxG.camera.follow(pivot);
		add(pivot);
		
		background = new FlxBackdrop(AssetPaths.wallpaper1__png);
		add(background);
		
		player = new Player(100, 150);
		add(player);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	
}