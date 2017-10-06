package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class EnemyShip extends FlxSprite 
{
	private var AllowShot: Bool;
	private var Timer: Float = 0;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		velocity.set(30, 0);
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
		
		if (Timer > 0.2)
		{
			AllowShot = true;
			Timer = 0;
		}
	}
	
	function Shoot() 
	{
		if (AllowShot == true) 
		{
			var shot: EnemyShot = new EnemyShot(x, y, AssetPaths.playerBullet__png);
			shot.velocity.set(0, 20);
		}
	}
}