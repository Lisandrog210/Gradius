package states;

import AssetPaths;
import entities.EnemyBase;
import entities.EnemyBomber;
import entities.EnemyPlane;
import entities.EnemyShip;
import entities.EnemyShot;
import entities.PlayerShot;
import entities.Storm;
import flixel.FlxCamera;
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
	private var enemyPlanes:FlxTypedGroup<EnemyPlane>;
	private var enemyShips:FlxTypedGroup<EnemyShip>;
	private var enemyBombers:FlxTypedGroup<EnemyBomber>;
	private var stormGroup:FlxTypedGroup<Storm>;

	override public function create():Void
	{
		super.create();
		
		enemyPlanes = new FlxTypedGroup<EnemyPlane>();
		enemyShips = new FlxTypedGroup<EnemyShip>();
		enemyBombers = new FlxTypedGroup<EnemyBomber>();
		stormGroup = new FlxTypedGroup<Storm>();
		
		LevelSetup();
		CameraSetup();
		
		background = new FlxBackdrop(AssetPaths.wallpaper1__png);
		add(background);
		add(tilemapSea);
		add(tilemapMount);
		player = new Player(50, 50);
		player.pixelPerfectPosition = false;
		add(player);
		add(enemyPlanes);
		add(enemyShips);
		add(enemyBombers);
		add(stormGroup);
		
	}

	function CameraSetup()
	{
		pivot = new FlxSprite(FlxG.width / 2, FlxG.height / 2);
		pivot.makeGraphic(1, 1, 0x00000000);
		pivot.velocity.x = Reg.velocidadCamara;
		FlxG.camera.follow(pivot);
		add(pivot);
	}

	public function LevelSetup()
	{
		loader = new FlxOgmoLoader(AssetPaths.level8__oel);
		tilemapSea = loader.loadTilemap(AssetPaths.tilesetSea1__png, 16, 16, "sea");
		tilemapSea.setTileProperties(0, FlxObject.NONE);
		//0, 1, 2 , 3, 6, 7 , 8, 9,14,16,17,18,19,20,21,27,48,51,52,53,54,55,60,61,62,63

		//4,5,10,11,12,13,15,22,23,24,25,26,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,49,50,56,57,58,59

		tilemapMount = loader.loadTilemap(AssetPaths.tilesetMountain1__png, 16, 16, "mountain");
		tilemapMount.setTileProperties(0, FlxObject.NONE);
		for (i in 0...9)
		{
			tilemapMount.setTileProperties(i,FlxObject.NONE);
		}
		tilemapMount.setTileProperties(14, FlxObject.NONE);
		for (i in 16...21)
		{
			tilemapMount.setTileProperties(i,FlxObject.NONE);
		}
		tilemapMount.setTileProperties(27, FlxObject.NONE);
		tilemapMount.setTileProperties(48, FlxObject.NONE);
		for (i in 51...55)
		{
			tilemapMount.setTileProperties(i,FlxObject.NONE);
		}
		for (i in 60...63)
		{
			tilemapMount.setTileProperties(i,FlxObject.NONE);
		}
		loader.loadEntities(entityCreator, "enemies");

		FlxG.worldBounds.set(0, 0, tilemapMount.width, tilemapMount.height);
		
	}

	private function entityCreator(entityName:String, entityData:Xml)
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		
		switch (entityName)
		{
			case "plane1":
				var plane1:EnemyPlane = new EnemyPlane(x, y,AssetPaths.england1__png);
				enemyPlanes.add(plane1);
				
			case "ship1":
				var ship1:EnemyShip = new EnemyShip(x, y, AssetPaths.ship1__png);
				enemyShips.add(ship1);
				
			case "storm1":
				var storm1:Storm = new Storm(x, y, AssetPaths.storm30x69__png);
				stormGroup.add(storm1);
				
			case "bomber1":
				var bomber1:EnemyBomber = new EnemyBomber(x, y, AssetPaths.bomber__png);
				enemyBombers.add(bomber1);
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
		
		if (FlxG.collide(tilemapMount, player))
		{
			player.kill();
		}
		FlxG.overlap(enemyPlanes, player, collideEnemyPlayer);
		FlxG.overlap(enemyShips, player, collideEnemyPlayer);
		FlxG.overlap(player.Bullets, enemyPlanes, collideShotEnemy);
		FlxG.overlap(player, stormGroup, collidePlayerStorm);
		for (i in 0...enemyPlanes.length) 
		{
			FlxG.overlap(player, enemyPlanes.members[i].shot, collideEnemBulletPlayer);
		}
		for (i in 0...enemyShips.length) 
		{
			FlxG.overlap(player, enemyShips.members[i].shot, collideEnemBulletPlayer);
		}
		/*for (i in 0...enemyBombers.length) 
		{
			FlxG.overlap(player, enemyBombers.members[i].shot, collideEnemBulletPlayer);
		}*/
	}
	
	function collideShotEnemy(s:PlayerShot, e:FlxSprite) 
	{
		s.kill();
		e.kill();
	}
	
	function collideEnemyPlayer(e:FlxSprite, p:Player) 
	{
		p.kill();
		e.kill();
	}
	
	function collidePlayerStorm(p:Player, s:Storm) 
	{
		p.kill();
	}
	
	function collideEnemBulletPlayer(p:Player, s:EnemyShot)
	{
		p.kill();
		s.kill();
	}
}

