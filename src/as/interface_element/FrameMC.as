// *************
// FrameMC class
// *************
class as.interface_element.FrameMC extends MovieClip
{
	private var mc_ref:MovieClip;
	private var frame_param:Object;
  
	// ***********
	// constructor
	// ***********
	public function FrameMC ()
	{
		mc_ref = this;
		frame_param = new Object ();
	}
	
	// ***********
	// clear frame
	// ***********
	public function clear_frame ():Void
	{
		mc_ref.clear ();
	}
	
	// *********
	// draw rect
	// *********
	// px py : padding
	public function draw_rect (px:Number, py:Number, w:Number, h:Number,
										 ls:Number, lc:Number, la:Number,
										 fc:Number, fa:Number):Void
	{
		mc_ref.lineStyle (ls, lc, la);
		
		// fill if fill parameters present
		if (fc != null && fa != null)
		{
			mc_ref.beginFill (fc, fa);
		}
		
		mc_ref.moveTo (px, py);
		
		mc_ref.lineTo (px + w, py);
		mc_ref.lineTo (px + w, py + h);
		mc_ref.lineTo (px, py + h);
		mc_ref.lineTo (px, py);
		
		// end fill if fill parameter present
		if (fc != null && fa != null)
		{
			mc_ref.endFill ();
		}
		
		store_frame_param (px, py, w, h, ls, lc, la, fc, fa);
	}
	
	// *********
	// draw oval
	// *********
	// px py : padding
	public function draw_oval (px:Number, py:Number, w:Number, h:Number,
										 ls:Number, lc:Number, la:Number,
										 fc:Number, fa:Number):Void
	{
		mc_ref.lineStyle (ls, lc, la);
		
		// fill if fill parameters present
		if (fc != null && fa != null)
		{
			mc_ref.beginFill (fc, fa);
		}
		
		
		// reference http://www.adobe.com/devnet/flash/articles/adv_draw_methods.html
		
		var theta:Number = Math.PI / 4;
		var xrCtrl:Number = (w / 2) / Math.cos (theta / 2);
		var yrCtrl:Number = (h / 2) / Math.cos (theta / 2);
		var angle:Number = 0;
		
		mc_ref.moveTo (px + w, py + (h / 2));
		
		for (var i = 0; i < 8; i++)
		{
			var angleMid:Number;
			var cx:Number;
			var cy:Number;
			var ex:Number;
			var ey:Number;
			
			angle += theta;
			angleMid = angle - (theta/2);
			
			cx = px + Math.cos (angleMid) * xrCtrl + (w / 2);
			cy = py + Math.sin (angleMid) * yrCtrl + (h / 2);
			
			ex = px + Math.cos (angle) * w / 2 + (w / 2);
			ey = py + Math.sin (angle) * h / 2 + (h / 2);
			
			mc_ref.curveTo (cx, cy, ex, ey);
		}
				
		// end fill if fill parameter present
		if (fc != null && fa != null)
		{
			mc_ref.endFill ();
		}
		
		store_frame_param (px, py, w, h, ls, lc, la, fc, fa);		
	}

	// *****************
	// store frame param
	// *****************
	private function store_frame_param (px:Number, py:Number, w:Number, h:Number,
										 ls:Number, lc:Number, la:Number,
										 fc:Number, fa:Number):Void
	{
		frame_param ["px"] = px;
		frame_param ["py"] = py;
		frame_param ["w"] = w;
		frame_param ["h"] = h;
		frame_param ["ls"] = ls;
		frame_param ["lc"] = lc;
		frame_param ["la"] = la;
		frame_param ["fc"] = fc;
		frame_param ["fa"] = fa;	
	}
	
	// ***************
	// get frame param
	// ***************
	public function get_frame_param ():Object
	{
		return (frame_param);
	}
}
