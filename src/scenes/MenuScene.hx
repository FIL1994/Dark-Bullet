package scenes;
import com.haxepunk.Scene;
import ui.MyText;
import com.haxepunk.utils.Input;
import com.haxepunk.HXP;
/**
 * ...
 * @author Philip VR
 */
class MenuScene extends Scene
{

	public function new() 
	{
		super();
		var txtTitle:MyText = new MyText("Dark Bullet", HXP.width / 2 - 230, HXP.height / 2 - 120, 50, 50, 80);
		var txtStart:MyText = new MyText("Click to Start", HXP.width / 2 - 128, HXP.height / 2 - 30, 50, 50, 32);
		add(txtTitle);
		add(txtStart);
	}
	override public function update() 
	{
		super.update();
		if (Input.mousePressed) {
			HXP.world.removeAll();
			HXP.scene.removeAll();
			HXP.scene = new GameScene();
		}
	}
	
}