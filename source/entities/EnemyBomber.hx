package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxTween;


class EnemyBomber extends EnemyBase
{

	public function new(?x:Float=0, ?y:Float=0,?SimpleGraphic:FlxGraphicAsset) 
	{
		super(x, y, SimpleGraphic);
		loadGraphic(AssetPaths.bomber__png, true, 28, 11);
		animation.add("fly", [0, 1], 12, true);
		animation.play("fly");
		velocity.set( -40, 0);
	}
	
	
}