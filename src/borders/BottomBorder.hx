package borders;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import com.haxepunk.masks.Grid;
/**
 * ...
 * @author Philip VR
 */
class BottomBorder extends Entity
{

	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		
		var _grid = new Grid(640, 485, 10, 10, 0, 0);
			mask = _grid;
			_grid.setRect(1, 22, 30, 2, true);
			
			type = "bottomBorder";
	}
	
}