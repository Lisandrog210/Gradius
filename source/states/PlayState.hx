package states;

import AssetPaths;
import entities.Enemies;
import entities.EnemyShip;
import entities.NewClass;
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
	private var enemyGroup:FlxTypedGroup<Dynamic>;
	private var stormGroup:FlxTypedGroup<Dynamic>;
	

	override public function create():Void
	{
		super.create();
		
		enemyGroup = new FlxTypedGroup<Dynamic>();
		stormGroup = new FlxTypedGroup<Dynamic>();
		
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
	
	function LevelSetup() 
	{
		loader = new FlxOgmoLoader(AssetPaths.level8__oel);
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
				
			case "storm1":
				var storm1:NewClass = new NewClass(x, y, AssetPaths.storm30x69__png);
				stormGroup.add(storm1);
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
		
		for (i in 0...enemyGroup.length)
		{
			if (FlxG.collide(enemyGroup, player))
			{
				player.kill();
				enemyGroup.members[i].kill();
			}
		}
		for (j in 0...enemyGroup.length)
		{
			if (FlxG.collide(player.shot, enemyGroup.members[j]))
			{
				enemyGroup.members[j].kill();
			}
		}
		
		for (h in 0...stormGroup.length)
		{
			if (FlxG.collide(player, stormGroup.members[h])) 
			{
				player.kill();
			}
			
		}
		
		//player.
		
		
	}
}

