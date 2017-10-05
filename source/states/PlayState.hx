package states;

import AssetPaths;
import entities.Enemies;
import entities.EnemyShip;
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
	var enemyGroup:FlxTypedGroup<Dynamic>;

	override public function create():Void
	{
		super.create();
		
		enemyGroup = new FlxTypedGroup<Dynamic>();
		
		LevelSetup();
		CameraSetup();
		
		background = new FlxBackdrop(AssetPaths.wallpaper1__png);
		add(background);
		add(tilemapSea);
		add(tilemapMount);
		player = new Player(100, 50);
		player.pixelPerfectPosition = false;
		add(player);
		add(enemyGroup);
	}
	
	function CameraSetup() 
	{
		pivot = new FlxSprite(FlxG.width / 2, FlxG.height / 2);
		pivot.makeGraphic(1, 1, 0x00000000);
		pivot.velocity.x = Reg.velocidadCamara;
		FlxG.camera.follow(pivot);
		add(pivot);
	}
	
	function LevelSetup() 
	{
		loader = new FlxOgmoLoader(AssetPaths.level6__oel);
		tilemapSea = loader.loadTilemap(AssetPaths.tilesetSea1__png, 16, 16, "sea");
		tilemapMount = loader.loadTilemap(AssetPaths.tilesetMountain1__png, 16, 16, "mountain");
		FlxG.worldBounds.set(0, 0, tilemapMount.width, tilemapMount.height);
		loader.loadEntities(entityCreator, "enemies");
	}

	private function entityCreator(entityName:String, entityData:Xml)
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		switch (entityName)
		{
			case "plane1":
				var plane1:Enemies = new Enemies(x, y);
				enemyGroup.add(plane1);
				
			case "ship1":
				var ship1:EnemyShip = new EnemyShip(x, y, AssetPaths.ship1__png);
				enemyGroup.add(ship1);
		}
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		CollisionDetect();
	}
	
	function CollisionDetect() 
	{
		FlxG.collide(tilemapSea, player);
		FlxG.collide(tilemapMount, player);
	}
}

