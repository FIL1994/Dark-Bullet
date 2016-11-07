import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Input;
import scenes.MenuScene;
import js.Cookie;

enum GAME_STATE {
		Playing;
		Menu;
}

class Main extends Engine
{
	
	public var gameState:Enum<GAME_STATE> = GAME_STATE;
	private var frames:Int = 0;
	private var themeSong:Sfx = new Sfx("audio/DarkBulletTheme.mp3");
	private var mute:Bool = false;
	
	public function new(){
		super(640, 480, 60);
		HXP.screen.color = Colours.GRAY;
	}
	
	override public function init()
	{
		HXP.scene = new MenuScene();
		themeSong.loop();
	}

	public static function main():Void {
		new Main();
		var w:GAME_STATE = GAME_STATE.Menu;
		trace(w.getName());
	}
	
	override public function update():Void 
	{
		#if (js)
		if(frames % 25 == 0){
			if (MyGame.asteroidsDestroyed >= 5) {
				Cookie.set("asteroid5", "true");
			}
			if (MyGame.asteroidsDestroyed >= 10) {
				Cookie.set("asteroid10", "true");
			}
			if (MyGame.asteroidsDestroyed >= 25) {
				Cookie.set("asteroid25", "true");
			}
			if (MyGame.asteroidsDestroyed >= 50) {
				Cookie.set("asteroid50", "true");
			}
			if (MyGame.bulletsShot >= 50) {
				Cookie.set("bullet50", "true");
			}
			if (MyGame.bulletsShot >= 100) {
				Cookie.set("bullet100", "true");
			}
			if (MyGame.bulletsShot >= 250) {
				Cookie.set("bullet250", "true");
			}
			if (MyGame.bulletsShot >= 500) {
				Cookie.set("bullet500", "true");
			}
			if (MyGame.bulletsShot >= 1000) {
				Cookie.set("bullet1000", "true");
			}
		}
		#end
		
		if (Input.pressed(Key.M)) {
			mute = !mute;
			if (mute) {
				HXP.volume = 0;
			}
			else {
				HXP.volume = 1;
			}
		}
		
		frames++;
		return super.update();
	}
	
	override public function focusGained() 
	{
		HXP.world.active = true;
		HXP.screen.color = Colours.GRAY;
		super.focusGained();
	}
	
	override public function focusLost() 
	{
		HXP.world.active = false;
		HXP.screen.color = Colours.JET_BLACK;
		super.focusLost();
	}

}