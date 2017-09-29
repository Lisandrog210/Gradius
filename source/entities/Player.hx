package entities;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;


class Player extends FlxSprite
{
	private var shot: PlayerShot;
	private var Timer: Float = 0;
	private var AllowShot: Bool;
	private var Lives:Int = 4;
	private var Totalhealth:FlxTypedGroup<FlxSprite>;

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
		Totalhealth = new FlxTypedGroup<FlxSprite>();
		
		for (i in 1...Lives) 
		{
			var health = new FlxSprite(i * 20, 10, AssetPaths.life__png);
			health.velocity.set(Reg.velocidadCamara, 0);
			health.scale.set(2, 2);
			Totalhealth.add(health);
		}
		FlxG.state.add(Totalhealth);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		movement();
		shootTimer(elapsed);
		shoot();
	}
  
  function shootTimer(elapsed:Float) 
  {
    Timer = Timer + elapsed;
	
    if (Timer > 0.25)
    {
      AllowShot = true;
      Timer = 0;
    }
  }
  function shoot()
  {
	if (FlxG.keys.pressed.Z)
    {
      if (AllowShot == true)
		{
			shot = new PlayerShot(x + 15, y + 10, AssetPaths.playerBullet__png);
			FlxG.state.add(shot);
			AllowShot = false;
			Timer = 0;
		}
    }
  }
  function movement()
  {
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