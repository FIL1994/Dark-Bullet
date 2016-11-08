package misc;

import haxe.Timer;
import com.haxepunk.HXP;
/**
 * ...
 * @author Philip VR
 */
class MyTime extends Timer
{
	private var seconds:Int = 0;
	
	public function new() 
	{
		super(1000);
	}
	
	override public function run() 
	{
		if(HXP.world.active){
			seconds++;
		}
	}
	
	public function resetSeconds():Void {
		seconds = 0;
	}
	
	public function getSeconds():Int {
		return seconds;
	}
	
}