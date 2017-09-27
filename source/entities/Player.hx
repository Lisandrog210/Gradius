package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

class Player extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		scale.set(2,2);
		updateHitbox();

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		//velocity.set(Reg.velocidadCamara, 0);

		if (FlxG.keys.pressed.RIGHT)
			velocity.x += 10;
		if (FlxG.keys.pressed.LEFT)
			velocity.x -= 10;
		if (FlxG.keys.pressed.DOWN)
			velocity.y += 10;
		if (FlxG.keys.pressed.UP)
			velocity.y -= 10;

		if (velocity.y == 0)
		{
			loadGraphic(AssetPaths.shipStraight__png, true, 32, 16);
			animation.add("fly", [0, 1], 12, true);
			animation.play("fly");
		}
		else if (velocity.y < 0)
		{
			loadGraphic(AssetPaths.shipUp__png, true, 32, 16);
			animation.add("fly", [0, 1], 12, true);
			animation.play("fly");
		}
		else if (velocity.y > 0)
		{
			loadGraphic(AssetPaths.shipDown__png, true, 32, 16);
			animation.add("fly", [0, 1], 12, true);
			animation.play("fly");
		}

	}

}