package ui;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import openfl.text.TextFormatAlign;

class MyText extends Entity
{
	private var txt:Text;

	public function new(text:String, x:Float, y:Float, width:Int, height:Int, fontSize:Int = 20) 
	{
		super();
		layer = -5;
		txt = new Text(text, x, y, width, height);
		txt.size = fontSize;
		txt.align = TextFormatAlign.CENTER;
		//txt.y = HXP.height / 2 - 50;
		graphic = txt;
	}
	
	public function setText(text:String) {
		txt.text = text;
	}
	
}