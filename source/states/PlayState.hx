package states;

import AssetPaths;
import entities.Boss;
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
	private var bossgroup:FlxTypedGroup<Boss>;
	
	
	
	override public function create():Void
	{
		super.create();

		enemyPlanes = new FlxTypedGroup<EnemyPlane>();
		enemyShips = new FlxTypedGroup<EnemyShip>();
		enemyBombers = new FlxTypedGroup<EnemyBomber>();
		stormGroup = new FlxTypedGroup<Storm>();
		bossgroup = new FlxTypedGroup<Boss>();

		LevelSetup();
		CameraSetup();

		background = new FlxBackdrop(AssetPaths.wallpaper1__png);
		add(background);
		add(tilemapSea);
		add(tilemapMount);
		player = new Player(50, 50);
		player.pixelPerfectPosition = false;
		add(enemyPlanes);
		add(enemyShips);
		add(enemyBombers);
		add(stormGroup);
		add(bossgroup);
		add(player);
		
	

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

			case "boss1":
				var boss1:Boss = new Boss(x, y, AssetPaths.boss1__png);
				bossgroup.add(boss1);

		}
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		CollisionDetect();
		camerastop();
		
	}

	function camerastop()
	{
		if (FlxG.camera.scroll.x > 5900)
		{
			pivot.velocity.x = 0;
			for (i in 0...stormGroup.length) 
			{
				stormGroup.members[i].velocity.x = 0;
				
			}
			for (j in 0...enemyBombers.length) 
			{
				enemyBombers.members[j].kill();
			}
		}
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
		FlxG.overlap(enemyBombers, player, collideEnemyPlayer);
		FlxG.overlap(player.Bullets, enemyPlanes, collideShotEnemy);
		FlxG.overlap(player.Bullets, enemyShips, collideShotEnemy);
		FlxG.overlap(player.Bullets, enemyBombers, collideShotEnemy);
		FlxG.overlap(player, stormGroup, collidePlayerStorm);
		for (i in 0...enemyBombers.length)
		{
			FlxG.overlap(player, enemyBombers.members[i].shot, collideEnemBulletPlayer);
		}
		for (i in 0...enemyShips.length)
		{
			FlxG.overlap(player, enemyShips.members[i].shot, collideEnemBulletPlayer);
		}
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

