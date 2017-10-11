package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Boss extends FlxSprite 
{
	private var Timer: Float = 0;
	private var AllowShot: Bool = false;
	public var shot(get, null): EnemyShot;

	public function new(?x:Float=0, ?y:Float=0,?SimpleGraphic:FlxGraphicAsset) 
	{
		super(x, y, SimpleGraphic);
		loadGraphic(AssetPaths.boss1__png, true, 63, 35);
		animation.add("fly", [0, 1, 2, 3, 4, 5], 12, true);
		animation.play("fly");
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
		
		if (Timer > 0.5)
		{
			AllowShot = true;
			Timer = 0;
		}
	}
	
	function Shoot() 
	{
		if (AllowShot == true) 
		{
			shot = new EnemyShot(x, y, AssetPaths.missile1__png);
			shot.velocity.set( -40, 0);
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