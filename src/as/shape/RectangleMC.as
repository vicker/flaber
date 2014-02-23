// *****************
// RectangleMC class
// *****************
class as.shape.RectangleMC extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip;				// interface for the rectangle mc
	
	// rectangle parameters
	private var rect_width:Number;
	private var rect_height:Number;
	private var rect_corner:Number;
	private var fill_color:Number;
	
	// constructor
	public function RectangleMC ()
	{
		mc_ref = this;
	}
	
	// draw_it
	public function draw_it ():Void
	{
		if (fill_color != null)
		{
			mc_ref.beginFill (fill_color);
		}
		
		mc_ref.lineTo (rect_width, 0);
		mc_ref.lineTo (rect_width, rect_height);
		mc_ref.lineTo (0, rect_height);
		mc_ref.lineTo (0, 0);
		
		if (fill_color != null)
		{
			mc_ref.endFill ();
		}
	}
	
	// set_dimension
	public function set_dimension (w:Number, h:Number, c:Number):Void
	{
		rect_width = w;
		rect_height = h;
		rect_corner = c;
	}
	
	// set_line_style
	public function set_line_style (t:Number, r:Number, a:Number):Void
	{
		mc_ref.lineStyle (t, r, a);
	}
	
	// set_fill_color
	public function set_fill_color (c:Number):Void
	{
		fill_color = c;
	}
}