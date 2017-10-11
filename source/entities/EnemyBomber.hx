package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxTween;


class EnemyBomber extends FlxSprite
{
	private var Timer: Float = 0;
	private var AllowShot: Bool = false;
	public var shot(get, null): EnemyShot;

	public function new(?x:Float=0, ?y:Float=0,?SimpleGraphic:FlxGraphicAsset) 
	{
		super(x, y, SimpleGraphic);
		loadGraphic(AssetPaths.bomber__png, true, 28, 11);
		animation.add("fly", [0, 1], 12, true);
		animation.play("fly");
		velocity.set( Reg.velocidadCamara -8, 0);
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
		
		if (Timer > 4)
		{
			AllowShot = true;
			Timer = 0;
		}
	}
	
	function Shoot() 
	{
		if (AllowShot == true) 
		{
			shot = new EnemyShot(x, y, AssetPaths.bomb1__png);
			shot.velocity.set( 0, 40);
			shot.scale.set(1, 1);
			FlxG.state.add(shot);
			AllowShot = false;
		}
	}
	
	function get_shot():EnemyShot 
	{
		return shot;
	}
}