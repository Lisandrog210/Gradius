package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxTween;


class Enemies extends FlxSprite 
{
	private var shot: EnemyShot;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.england1__png, true, 26, 15);
		animation.add("fly", [0, 1], 12, true);
		animation.play("fly");
		velocity.set( -60, 0);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		Shoot();
	}
	
	function Shoot() 
	{
		
	}
	
}