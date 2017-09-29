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
		loadGraphic(AssetPaths.shipFrames__png, true, 26, 15);
		animation.add("fly", [0, 1], 12, true);
		animation.add("flyUp", [4, 5], 12, true);
		animation.add("flyDown", [2, 3], 12, true);
		animation.play("fly");

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		velocity.set(Reg.velocidadCamara, 0);

		if (FlxG.keys.pressed.RIGHT)
			velocity.x += 100;
		if (FlxG.keys.pressed.LEFT)
			velocity.x -= 100;
		if (FlxG.keys.pressed.DOWN)
			velocity.y += 100;
		if (FlxG.keys.pressed.UP)
			velocity.y -= 100;

		if (velocity.y == 0)
		{
			animation.play("fly");
		}
		else if (velocity.y < 0)
		{
			animation.play("flyUp");
		}
		else if (velocity.y > 0)
		{
			animation.play("flyDown");
		}

	}

}