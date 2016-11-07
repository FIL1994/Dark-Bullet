import com.haxepunk.Scene;
import com.haxepunk.HXP;
import borders.BottomBorder;
import enemies.Asteroid;
import com.haxepunk.graphics.Text;
import openfl.text.TextFormatAlign;
import ui.MyText;
import js.Cookie;

class GameScene extends Scene
{
	private var frames:Int = 0;
	private var addX:Int = 50;
	private var addY:Int = -40;
	private var txtSeconds:MyText;
	private var asteroidsAdded:Int = 0;
	private var phase:Int = 0;
	private var asteroidSpeed:Float = 48;
	private var frameToAddAsteroid:Int = 50;
	
	public override function begin()
	{
		var b = new BottomBorder();
		add(new Player(HXP.screen.width / 2 - 16, HXP.screen.height / 2 - 16));
		
		add(new Asteroid(200, 30));
		add(new Asteroid(250, 30));
		add(new Asteroid(300, 30));
		add(new Asteroid(350, 30));
		add(new Asteroid(400, 30));
		txtSeconds = new MyText("Seconds: ", 20, HXP.height - 35, 50, 50);
		add(txtSeconds);
		add(new MyText("Press M to Mute", 430, HXP.height - 35, 50, 50));
		
		MyGame.timer.resetSeconds();
		/*
		add(new Asteroid(310, 10));
		add(new Asteroid(290, 10));
		add(new Asteroid(270, 10));
		add(new Asteroid(330, 10));
		add(new Asteroid(350, 10));
		*/
	}
	
	override public function update() 
	{
		
		if (frames % frameToAddAsteroid == 0) {
			
			switch(phase) {
				case 0: {
					//SOUTH
					add(new Asteroid(addX, addY, 270, asteroidSpeed));
			
					addX += 35;
			
					if(addX > 600){
						addY -= 5;
						addX = 50;
					}
					if (addY < -50) {
						addY = -30;
					}
				}
				case 1: {
					//SOUTH EAST
					add(new Asteroid(addX, addY, 315, asteroidSpeed));
					addX += 10;
					addY -= 8;
					if (addX > 30) {
						addX = -50;
					}
					if (addY < -60) {
						addY = -35;
					}
				}
				case 2: {
					//SOUTH WEST
					add(new Asteroid(addX, addY, 225, asteroidSpeed));
					addX -= 10;
					addY -= 8;
					if (addX > 550) {
						addX = 520;
					}
					if (addY < -60) {
						addY = -35;
					}
				}
				case 3: {
					//NORTH EAST
					add(new Asteroid(addX, addY, 45, asteroidSpeed));
					addX += 10;
					addY += 8;
					if (addX > 30) {
						addX = -50;
					}
					if (addY > 540) {
						addY = 500;
					}
				}
				case 4: {
					//NORTH WEST
					add(new Asteroid(addX, addY, 135, asteroidSpeed));
					addX -= 10;
					addY += 8;
					if (addX > 550) {
						addX = -50;
					}
					if (addY > 540) {
						addY = 500;
					}
				}
				default: {
					trace("DEFAULT: " + phase);
				}
			}
			
			asteroidsAdded++;
			if (asteroidsAdded > 12) {
				phase++;
				asteroidsAdded = 0;
				switch(phase) {
					case 0: {
						//SOUTH
						addX = 50;
						addY = -40;
					}
					case 1: {
						//SOUTH EAST
						addX = -50;
						addY = -35;
					}
					case 2: {
						//SOUTH WEST
						addX = 520;
						addY = -35;
					}
					case 3: {
						//SOUTH EAST
						addX = -50;
						addY = 500;
					}
					case 4: {
						//SOUTH WEST
						addX = 520;
						addY = 500;
					}
					case 5: {	
						phase = 0;
						addX = 50;
						addY = -40;
						asteroidSpeed *= 1.1;
						if(frameToAddAsteroid > 30)
							frameToAddAsteroid--;
					}
				}
			}
			
		}
		
		if (frames % 20 == 0){
			txtSeconds.setText("Seconds: " + MyGame.timer.getSeconds());
			
			#if (js)
			if (MyGame.timer.getSeconds() >= 5) {
				Cookie.set("survive5", "true");
			}
			if (MyGame.timer.getSeconds() >= 15) {
				Cookie.set("survive15", "true");
			}
			if (MyGame.timer.getSeconds() >= 50) {
				Cookie.set("survive50", "true");
			}
			if (MyGame.timer.getSeconds() >= 100) {
				Cookie.set("survive100", "true");
			}
			if (MyGame.timer.getSeconds() >= 150) {
				Cookie.set("survive150", "true");
			}
			if (MyGame.timer.getSeconds() >= 300) {
				Cookie.set("survive300", "true");
			}
			#end
		}
		
		super.update();
		frames++;
	}
}