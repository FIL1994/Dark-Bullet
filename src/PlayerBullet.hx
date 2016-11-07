package;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;

/**
 * ...
 * @author Philip VR
 */
class PlayerBullet extends Entity
{

	private var speed:Float = 200;
	private var frames:Int = 0;
	private var deg:Float = 0;
	
	public function new(x:Float, y:Float, deg:Float) 
	{
		super(x, y);
		this.deg = deg;
		graphic = Image.createRect(4, 4, Colours.GRAPHITE);
		setHitboxTo(graphic);
		layer = 3;
		MyGame.bulletsShot++;
		type = "playerBullet";
	}
	
	override public function update():Void 
	{
		moveAtAngle(deg, speed * HXP.elapsed);
		checkOffScreen();
		super.update();
	}
	
	public function destroy() {
		graphic = null;
		scene.remove(this);
	}
	
	private function checkOffScreen() {
		if (x > 640 || x < 0) {
			destroy();
		}
		if (y > 480 || y < 0) {
			destroy();
		}
	}
	
}