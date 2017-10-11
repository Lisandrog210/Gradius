package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class EnemyShip extends FlxSprite
{
	public var shot(get, null): EnemyShot;
	private var AllowShot: Bool;
	private var Timer: Float = 0;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.ship1__png, true, 30, 17);
		//velocity.set(30, 0);
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		Shoot();
		shootTimer(elapsed);
	}
	
	function shootTimer(elapsed:Float) 
	{
		Timer = Timer + elapsed;
		
		if (Timer > 5)
		{
			AllowShot = true;
			Timer = 0;
		}
	}
	
	function Shoot() 
	{
		if (AllowShot == true) 
		{
			shot = new EnemyShot(x, y, AssetPaths.playerBullet__png);
			shot.velocity.set(0, -20);
			FlxG.state.add(shot);
			AllowShot = false;
		}
	}
	
	function get_shot():EnemyShot 
	{
		return shot;
	}
}