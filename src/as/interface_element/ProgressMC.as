// ****************
// ProgressMC class
// ****************
class as.interface_element.ProgressMC extends MovieClip
{
	private var mc_ref:MovieClip;							// interface for the color box
	
	private var frame_width:Number;
	private var frame_height:Number;
	private var progress_percentage:Number;
  
	// ***********
	// constructor
	// ***********
	public function ProgressMC ()
	{
		mc_ref = this;
		
		progress_percentage = 0;
		
		mc_ref.attachMovie ("lib_frame_mc", "bg_frame_mc", 1);
		mc_ref.attachMovie ("lib_frame_mc", "bar_frame_mc", 2);
	}

	// *************
	// set dimension
	// *************
	public function set_dimension (w:Number, h:Number):Void
	{
		frame_width = w;
		frame_height = h;
		
		draw_bg_frame ();
		draw_bar_frame ();
	}
	
	// ***********************
	// set progress percentage
	// ***********************
	public function set_progress_percentage (n:Number):Void
	{
		progress_percentage = Math.max (Math.min (n, 100), 0);
		draw_bar_frame ();
	}
	
	// *************
	// draw bg frame
	// *************
	private function draw_bg_frame ():Void
	{
		mc_ref.bg_frame_mc.clear_frame ();
		mc_ref.bg_frame_mc.draw_rect (0, 0, frame_width, frame_height, 1, 0x999999, 100, 0xFFFFFF, 100);
	}
	
	// **************
	// draw bar frame
	// **************
	private function draw_bar_frame ():Void
	{
		var temp_length:Number = 0;
		temp_length = (frame_width - 4) * progress_percentage / 100;
		
		mc_ref.bar_frame_mc.clear_frame ();
		mc_ref.bar_frame_mc.draw_rect (2, 2, temp_length, frame_height - 4, 1, 0x666666, 100, 0x666666, 100);
	}
}
