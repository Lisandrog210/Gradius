package entities;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import states.DefeatMenu;


class Player extends FlxSprite
{
	private var shot: PlayerShot;
	public var Bullets(get, null): FlxTypedGroup<PlayerShot>;
	private var selectedShot: Int = 0;
	private var Timer: Float = 0;
	private var AllowShot: Bool;
	private var Lives:Int = 4;
	public var KeepAlive(get, null): Bool;
	private var Totalhealth:FlxTypedGroup<FlxSprite>;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		scale.set(1, 1);
		updateHitbox();
		AnimationSetup();
		HealthSetup();
		BulletsSetup();
		
	}
	
	function BulletsSetup() 
	{
		Bullets = new FlxTypedGroup<PlayerShot>();
		
		
		for (i in 0...5) 
		{
			shot = new PlayerShot(x, y, AssetPaths.playerBullet__png);
			shot.kill();
			Bullets.add(shot);
		}
		
		FlxG.state.add(Bullets);
	}
	
	private function Limites():Void
	{
		if (x > camera.scroll.x + FlxG.width - width)
		{
			x = camera.scroll.x + FlxG.width - width;
		}
		if (x < camera.scroll.x)
		{
			x = camera.scroll.x;
		}
	}

	
	function AnimationSetup() 
	{
		loadGraphic(AssetPaths.shipFrames__png, true, 26, 15);
		animation.add("fly", [0, 1], 12, true);
		animation.add("flyUp", [4, 5], 12, true);
		animation.add("flyDown", [2, 3], 12, true);
		animation.play("fly");
	}
	
	function HealthSetup() 
	{
		Totalhealth = new FlxTypedGroup<FlxSprite>();
		for (i in 1...Lives) 
		{
			var health = new FlxSprite(i * 20, 10, AssetPaths.life__png);
			health.pixelPerfectPosition = false;
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
		Limites();
	}
	
	function livesStop()
	{
	if (FlxG.camera.scroll.x > 5900)
		for (i in 0...Totalhealth.length) 
		{
			Totalhealth.members[i].velocity.x = 0;
		}
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
				Bullets.members[selectedShot].reset(x + 5, y + 5);
				Bullets.members[selectedShot].velocity.set(Reg.velocidadCamara + 300, 0);
				AllowShot = false;
				selectedShot++;
				
				if (selectedShot >= 4) 
				{
					selectedShot = 0;
				}
			}
		}
	}
	function movement()
	{
		velocity.set(Reg.velocidadCamara, 0);
		
		if (FlxG.keys.pressed.RIGHT)
		velocity.x += 120;
		if (FlxG.keys.pressed.LEFT)
		velocity.x -= 120;
		if (FlxG.keys.pressed.DOWN)
		velocity.y += 120;
		if (FlxG.keys.pressed.UP)
			velocity.y -= 120;
		
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
	override public function kill():Void 
	{
		super.kill();
		Totalhealth.members.pop();
		Lives--;
		if (Lives == 0) 
		{
			this.destroy();
			KeepAlive = false;
			FlxG.switchState(new DefeatMenu());
		}
		else 
		{
			KeepAlive = true;
			this.reset( camera.scroll.x - width, 100);
		}
	}
	
	function get_KeepAlive():Bool 
	{
		return KeepAlive;
	}
	
	function get_Bullets():FlxTypedGroup<PlayerShot> 
	{
		return Bullets;
	}
}