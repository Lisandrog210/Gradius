package states;

import AssetPaths;
import entities.Enemies;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import entities.Player;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;

class PlayState extends FlxState
{
	private var loader:FlxOgmoLoader;
	private var player:Player;
	private var pivot:FlxSprite;
	private var background:FlxBackdrop;
	private var tilemapSea:FlxTilemap;
	private var tilemapMount:FlxTilemap;
	var enemyGroup:FlxTypedGroup<Enemies>;

	override public function create():Void
	{
		super.create();
		
		enemyGroup = new FlxTypedGroup<Enemies>();

		loader = new FlxOgmoLoader(AssetPaths.level1GradiusGG__oel);

		tilemapSea = loader.loadTilemap(AssetPaths.tilesetSea1__png);
		tilemapSea.setTileProperties(FlxObject.ANY);

		tilemapMount = loader.loadTilemap(AssetPaths.tilesetMountain1__png);
		tilemapMount.setTileProperties(FlxObject.ANY);

		pivot = new FlxSprite(FlxG.width / 2, FlxG.height / 2);
		pivot.makeGraphic(1, 1, 0x00000000);
		pivot.velocity.x = Reg.velocidadCamara;
		FlxG.camera.follow(pivot);
		add(pivot);

		background = new FlxBackdrop(AssetPaths.wallpaper1__png);
		add(background);

		add(tilemapSea);
		add(tilemapMount);

		loader.loadEntities(entityCreator, "Entities");

		player = new Player(100, 150);
		add(player);
		add(enemyGroup);

	 function entityCreator(entityName:String, entityData:Xml)

		{

			var x:Int = Std.parseInt(entityData.get("x"));

			var y:Int = Std.parseInt(entityData.get("y"));

			var enemy:Enemies = new Enemies(x,y,AssetPaths.england1__png);
			enemyGroup.add(enemy);
			var enemyShip:Enemies = new Enemies(x, y, AssetPaths.ship1__png);
			enemyGroup.add(enemyShip);

		}

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(tilemapSea, player);
		FlxG.collide(tilemapMount, player);

	}

}

