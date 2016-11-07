package;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.math.Vector;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.HXP;
import com.haxepunk.masks.Pixelmask;
import com.haxepunk.masks.Polygon;
import enemies.Asteroid;
import com.haxepunk.Sfx;

/**
 * ...
 * @author Philip VR
 */
class Player extends Entity
{
	private var startX:Float;
	private var startY:Float;
	
	private var speed:Float = 3;
	private var rotateAngle:Float;
	private var sprite:Spritemap;
	private var deg:Float = 0;
	private var frames:Int = 0;
	private var framesSinceLastBullet:Int = 0;
	private var gotHit:Sfx = new Sfx("audio/playerGotHit.mp3");
	
	public function new(x:Float, y:Float) 
	{
		super(x, y);
		
		sprite = new Spritemap("graphics/ship.png", 32, 32);
		
		graphic = sprite; //Image.createRect(32, 32, 0xDDEEFF);
		
		setHitbox(30, 28, 15, 14);
		
		sprite.originX = 16;
		sprite.originY = 16;
		
		startX = x;
		startY = y;
		
		Input.define("up", [Key.UP, Key.W]);
		Input.define("down", [Key.DOWN, Key.S]);
		Input.define("left", [Key.LEFT, Key.A]);
		Input.define("right", [Key.RIGHT, Key.D]);
		
		type = "player";
		layer = 2;
	}
	
	override public function update():Void 
	{
		/*
		if (Input.check("right")) {
			moveBy(speed, 0);
		}
		if (Input.check("left")) {
			moveBy(-speed, 0);
		}
		if (Input.check("up")) {
			moveBy(0, -speed);
		}
		if (Input.check("down")) {
			moveBy(0, speed);
		}
		*/
		
		if (collide("asteroid", x, y) != null) {
			trace("PLAYER COLLIDED");
		}
		
		move();
		
		if (Input.check(Key.SPACE) || Input.mouseDown) {
			if(framesSinceLastBullet % 8 == 0){
				var goToX:Float = x; 
				var goToY:Float = y; 
				HXP.world.add(new PlayerBullet(goToX, goToY, deg + 180));
			}
			framesSinceLastBullet++;
		}
		else {
			framesSinceLastBullet = 0;
		}
			
		super.update();
		frames++;
	}
	
	private function move() {
		var distFromMouseX:Float = Math.abs(Input.mouseFlashX - this.x);
		var distFromMouseY:Float = Math.abs(Input.mouseFlashY - this.y);
		var distFromMouse:Float = Math.pow(distFromMouseX, 2) + Math.pow(distFromMouseY, 2);
		distFromMouse = Math.sqrt(distFromMouse);
		
		isInBounds();
		
		if (/*Input.mouseDown &&*/ distFromMouse > 5 && isInBounds()) {
			var deltaX:Float = Input.mouseX - (this.x);
			var deltaY:Float = (this.y) - Input.mouseY;
			var rad:Float = Math.atan2(deltaY, deltaX);
			deg = rad * (180 / Math.PI)+ 180;
			//trace("Angle: " + deg);
			this.moveAtAngle(deg, - 120 * HXP.elapsed);
			cast(this.graphic, Image).angle = deg + 90;
			
		}
	}
	
	private function isInBounds():Bool {
		var xBack:Float = 1.99;
		var yBack:Float = 1.99;
		
		if (x > 620) {
			x -= xBack;
			return false;
		}
		if (x < 20) {
			x += xBack;
			return false;
		}
		if (y > 460) {
			y -= yBack;
			return false;
		}
		if (y < 20) {
			y += yBack;
			return false;
		}
		
		return true;
	}
	
	public function resetPosition() {
		gotHit.play();
		trace("BULLETS SHOT: " + MyGame.bulletsShot);
		HXP.world.removeAll();
		HXP.scene.removeAll();
		HXP.scene = new GameScene();
	}
	
}