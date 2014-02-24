// *************
// FrameMC class
// *************
class as.interface_element.FrameMC extends MovieClip
{
	private var mc_ref:MovieClip;
  
	// ***********
	// constructor
	// ***********
	public function FrameMC ()
	{
		mc_ref = this;
	}
	
	// ***********
	// clear frame
	// ***********
	public function clear_frame ():Void
	{
		mc_ref.clear ();
	}
	
	// **********
	// draw frame
	// **********
	// px py : padding
	public function draw_frame (px:Number, py:Number, w:Number, h:Number,
										 ls:Number, lc:Number, la:Number,
										 fc:Number, fa:Number):Void
	{
		mc_ref.clear ();
		
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
	}
}
