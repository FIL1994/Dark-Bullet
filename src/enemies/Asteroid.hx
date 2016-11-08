package enemies;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Spritemap;
import js.Cookie;
/**
 * ...
 * @author Philip VR
 */
class Asteroid extends Entity
{
	
	private var speed:Float = 35;
	private var frames:Int = 0;
	private var deg:Float = 270;
	private var health:Int = 4;
	
	
	public function new(x:Float, y:Float, deg:Float = 270, speed:Float = 48) 
	{
		super(x, y);
		this.deg = deg;
		this.speed = speed;
		//graphic = Image.createRect(12, 12, Colours.GRAPHITE);
		
		graphic = new Spritemap("graphics/asteroid.png", 38, 38);
		
		setHitboxTo(graphic);
		layer = 4;
		
		type = "asteroid";
	}
	
	override public function update():Void 
	{
		moveAtAngle(deg, speed * HXP.elapsed);
		checkCollision();
		checkOffScreen();
		super.update();
	}
	
	private function checkCollision() {
		
		var e:Entity = collide("playerBullet", x, y);
        if (e != null)
        {
            var b:PlayerBullet = cast(e, PlayerBullet);
            b.destroy();
			health--;
			if(health <= 0)
				destroy(true);
        }
		
		e = collide("player", x, y);
		
        if (e != null)
        {
            var player:Player = cast(e, Player);
            player.resetPosition();
        }
	}
	
	public function destroy(byPlayer:Bool = false) {
		#if (js)
		if(byPlayer){			
			Cookie.set("destroyedAsteroid", "true");
			MyGame.asteroidsDestroyed++;
		}
		#end
		graphic = null;
		scene.remove(this);
	}
	
	private function checkOffScreen() {
		if (x > 700 || x < -80) {
			destroy();
		}
		if (y > 560 || y < -80) {
			destroy();
		}
	}
	
}