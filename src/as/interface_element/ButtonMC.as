// **************
// ButtonMC class
// **************
class as.interface_element.ButtonMC extends MovieClip
{
	// MC variables
	// MovieClip			clip_mc
	// MovieClip			frame_mc
	
	// private variables
	private var mc_ref:MovieClip;

	private var frame_width:Number;
	private var frame_height:Number;

	private var toggle_flag:Boolean;						// false for normal, true for toggle
	private var toggle_state:Boolean;
	private var tooltip_string:String;

	// ***********
	// constructor
	// ***********
	public function ButtonMC ()
	{
		mc_ref = this;
		
		toggle_flag = false;
		toggle_state = false;
		tooltip_string = "missing tooltip";
		
		mc_ref.attachMovie ("lib_frame_mc", "frame_mc", 1);
		
		setup_normal_listener ();
	}

	// ***************
	// set toggle flag
	// ***************
	public function set_toggle_flag (b:Boolean):Void
	{
		toggle_flag = b;
		
		if (b == true)
		{
			setup_toggle_listener ();
		}
	}

	// ****************
	// set toggle state
	// ****************
	public function set_toggle_state (b:Boolean):Void
	{
		// do only in the case
		// i) null -> true / false
		// ii) true -> false / false -> true
		
		if (b != toggle_state)
		{
			// set the state or change the state
			if (b == null)
			{
				toggle_state = !toggle_state || false;
			}
			else
			{
				toggle_state = b;
			}
			
			// redraw the frames
			if (toggle_state == true)
			{
				draw_highlight_frame ();
			}
			else
			{
				mc_ref.frame_mc.clear_frame ();
			}
		}
	}

	// ****************
	// get toggle state
	// ****************
	public function get_toggle_state ():Boolean
	{
		return (toggle_state);
	}

	// *************
	// set dimension
	// *************
	public function set_dimension (w:Number, h:Number):Void
	{
		frame_width = w;
		frame_height = h;
		
		if (toggle_flag != true)
		{
			draw_normal_frame ();
		}
	}
	
	// ***********
	// set tooltip
	// ***********
	public function set_tooltip (s:String):Void
	{
		tooltip_string = s;
	}
	
	// ***********
	// set clip mc
	// ***********
	public function set_clip_mc (s:String):Void
	{
		mc_ref.attachMovie (s, "clip_mc", 2);
		
		mc_ref.clip_mc._x = (frame_width - mc_ref.clip_mc._width) / 2;
		mc_ref.clip_mc._y = (frame_height - mc_ref.clip_mc._height) / 2;
	}
	
	// *****************
	// draw normal frame
	// *****************
	public function draw_normal_frame ():Void
	{
		mc_ref.frame_mc.draw_frame (0, 0, frame_width, frame_height, 1, 0x666666, 100, 0xFFFFFF, 100);
	}
	
	// ********************
	// draw highlight frame
	// ********************
	public function draw_highlight_frame ():Void
	{
		mc_ref.frame_mc.draw_frame (0, 0, frame_width, frame_height, 1, 0xFF9900, 100, 0xFFFFFF, 100);
	}
	
	// *********************
	// setup normal listener
	// *********************
	public function setup_normal_listener ():Void
	{
		mc_ref.onRollOver = function ()
		{
			this.draw_highlight_frame ();
			_root.tooltip_mc.set_content (tooltip_string);
		}
		
		mc_ref.onRollOut = function ()
		{
			this.draw_normal_frame ();
			_root.tooltip_mc.throw_away ();
		}
	}
	
	// *********************
	// setup toggle listener
	// *********************
	public function setup_toggle_listener ():Void
	{
		mc_ref.onRollOver = function ()
		{
			if (this.toggle_state == false)
			{
				this.draw_highlight_frame ();
			}
			_root.tooltip_mc.set_content (tooltip_string);
		}
		
		mc_ref.onRollOut = function ()
		{
			if (this.toggle_state == false)
			{
				this.frame_mc.clear_frame ();
			}
			_root.tooltip_mc.throw_away ();
		}
		
		mc_ref.onRelease = function ()
		{
			// normally will be overrided by outside when used
			this.set_toggle_state (null);
		}
	}
}
