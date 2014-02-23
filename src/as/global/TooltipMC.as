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
		
		mc_ref._visible = true;
		mc_ref.startDrag (true);
	}

	// **********
	// draw frame
	// **********
	public function draw_frame ():Void
	{
		var frame_width:Number;
		
		frame_width = mc_ref.content_field.textWidth + 6 * 2;
		
		// clear all frame first
		mc_ref.frame_mc.clear ();
		
		// draw the outer border
		mc_ref.frame_mc.lineStyle (1, 0x666666, 100);
		mc_ref.frame_mc.beginFill (0xFFFFFF, 100);
		mc_ref.frame_mc.moveTo (0, 0);
		mc_ref.frame_mc.lineTo (frame_width, 0);
		mc_ref.frame_mc.lineTo (frame_width, 22);
		mc_ref.frame_mc.lineTo (0, 22);
		mc_ref.frame_mc.lineTo (0, 0);
		mc_ref.frame_mc.endFill ();
		
		// draw the shadow
		mc_ref.frame_mc.lineStyle (0, 0x000000, 0);
		mc_ref.frame_mc.beginFill (0x000000, 30);
		mc_ref.frame_mc.moveTo (frame_width, 10);
		mc_ref.frame_mc.lineTo (frame_width + 3, 10);
		mc_ref.frame_mc.lineTo (frame_width + 3, 22 + 3);
		mc_ref.frame_mc.lineTo (0 + 10, 22 + 3);
		mc_ref.frame_mc.lineTo (0 + 10, 22);
		mc_ref.frame_mc.lineTo (frame_width, 22);
		mc_ref.frame_mc.lineTo (frame_width, 10);
		mc_ref.frame_mc.endFill ();
	}

	// **********
	// throw away
	// **********
	public function throw_away ():Void
	{
		mc_ref._visible = false;
	}
}