// ***************
// TooltipMC class
// ***************
class as.global.TooltipMC extends MovieClip
{
	// MC variables
	// Dynamic Text Field			content_field
	// MovieClip						frame_mc
	
	// private variables
	private var mc_ref:MovieClip;						// interface for the tooltip mc
	
	// ***********
	// constructor
	// ***********
	public function TooltipMC ()
	{
		mc_ref = this;
		mc_ref.content_field.autoSize = true;
		mc_ref.attachMovie ("lib_frame_mc", "frame_mc", -16384, {_x:0, _y:20});

		// drop shadow
		_root.mc_filters.set_shadow_filter (mc_ref);

		draw_frame ();
		throw_away ();
	}
	
	// **************
	// set target ref
	// **************
	public function set_content (s:String):Void
	{
		mc_ref.content_field.text = s;
		
		draw_frame ();
		
		mc_ref.startDrag (true);
		mc_ref._visible = true;
	}

	// **********
	// draw frame
	// **********
	private function draw_frame ():Void
	{
		var frame_width:Number = 0;
		frame_width = mc_ref.content_field.textWidth + 6 * 2;
		
		// clear all frame first
		mc_ref.frame_mc.clear_frame ();
		mc_ref.frame_mc.draw_rect (0, 0, frame_width, 22, 1, 0x666666, 100, 0xFFFFFF, 100);
	}

	// **********
	// throw away
	// **********
	public function throw_away ():Void
	{
		mc_ref._visible = false;
	}
}
