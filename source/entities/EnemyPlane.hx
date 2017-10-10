package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxTween;


class EnemyPlane extends EnemyBase 
{
	private var shot: EnemyShot;
	private var Timer: Float = 0;
	private var AllowShot: Bool;
	
	public function new(?x:Float=0, ?y:Float=0,?SimpleGraphic:FlxGraphicAsset) 
	{
		super(x, y, SimpleGraphic);
		loadGraphic(AssetPaths.england1__png, true, 26, 15);
		animation.add("fly", [0, 1], 12, true);
		animation.play("fly");
		velocity.set( -40, 0);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		shootTimer(elapsed);
		Shoot();
	}
	
	function shootTimer(elapsed:Float) 
	{
		Timer = Timer + elapsed;
		
		if (Timer > 6)
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
			shot.velocity.set( -50, 0);
			FlxG.state.add(shot);
			AllowShot = false;
		}
	}
	
}