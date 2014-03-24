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
		mc_ref.attachMovie ("lib_frame_mc", "normal_frame_mc", -16384);
		mc_ref.attachMovie ("lib_frame_mc", "highlight_frame_mc", -16382);
		mc_ref.highlight_frame_mc.swapDepths (mc_ref.content_field);
		
		toggle_flag = false;
		toggle_state = false;
		tooltip_string = "missing tooltip";
		
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
			mc_ref.normal_frame_mc._visible = false;
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
			
			// show the correct frames
			if (toggle_state == true)
			{
				mc_ref.highlight_frame_mc._visible = true;
			}
			else
			{
				mc_ref.highlight_frame_mc._visible = false;
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
		
		draw_frames ();
		
		mc_ref.highlight_frame_mc._visible = false;
		if (toggle_flag != true)
		{
			mc_ref.normal_frame_mc._visible = true;
		}
		
		mc_ref.content_field._width = w;
		mc_ref.content_field._y = h / 2 - mc_ref.content_field._height / 2;
	}
	
	// ***********
	// set tooltip
	// ***********
	public function set_tooltip (s:String):Void
	{
		tooltip_string = s;
	}
	
	// ********
	// set text
	// ********
	public function set_text (s:String):Void
	{
		mc_ref.content_field.text = s;
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
	
	// ***********
	// draw frames
	// ***********
	private function draw_frames ():Void
	{
		mc_ref.normal_frame_mc.clear_frame ();
		mc_ref.normal_frame_mc.draw_rect (0, 0, frame_width, frame_height, 1, 0x666666, 100, 0xFFFFFF, 100);
		mc_ref.highlight_frame_mc.clear_frame ();
		mc_ref.highlight_frame_mc.draw_rect (0, 0, frame_width, frame_height, 1, 0xFF9900, 100, 0xFFFFFF, 100);
	}
	
	// *********************
	// setup normal listener
	// *********************
	private function setup_normal_listener ():Void
	{
		mc_ref.onRollOver = function ()
		{
			this.highlight_frame_mc._visible = true;
			
			if (tooltip_string != "missing tooltip")
			{
				_root.tooltip_mc.set_content (tooltip_string);
			}
		}
		
		mc_ref.onRollOut = function ()
		{
			this.highlight_frame_mc._visible = false;
			
			_root.tooltip_mc.throw_away ();
		}
	}
	
	// *********************
	// setup toggle listener
	// *********************
	private function setup_toggle_listener ():Void
	{
		mc_ref.onRollOver = function ()
		{
			if (this.toggle_state == false)
			{
				this.highlight_frame_mc._visible = true;
			}
			_root.tooltip_mc.set_content (tooltip_string);
		}
		
		mc_ref.onRollOut = function ()
		{
			if (this.toggle_state == false)
			{
				this.highlight_frame_mc._visible = false;
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
