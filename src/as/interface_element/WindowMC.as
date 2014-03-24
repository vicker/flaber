// **************
// WindowMC class
// **************
class as.interface_element.WindowMC extends MovieClip
{
	// MC variables
	// MovieClip					frame_mc
	// Button						min_button
	// Button						max_button
	// Button						close_button
	// Dynamic Text Field		window_name_field
	
	// private variables
	private var mc_ref:MovieClip;				// interface for the window
	private var org_height:Number;			// frame's original height
	private var frame_width:Number;			// frame's width
	private var frame_height:Number;			// frame's height
	
	// ***********
	// constructor
	// ***********
	public function WindowMC ()
	{
		mc_ref = this;
		mc_ref.attachMovie ("lib_frame_mc", "frame_mc", -16384, {_x:0, _y:0});
		
		org_height = -1;
		
		setup_min_button ();
		setup_max_button ();
		setup_close_button ();
		setup_frame ();
	}

	// *******************
	// draw frame function
	// *******************
	public function draw_frame ():Void
	{
		// clear all frame first
		mc_ref.frame_mc.clear_frame ();
		mc_ref.frame_mc.draw_rect (0, 20, frame_width, frame_height, 1, 0x666666, 100, 0xFFFFFF, 100);
		mc_ref.frame_mc.draw_rect (0, 0, frame_width, 20, 1, 0x666666, 100, 0xFFFFFF, 100);
		
		// drop shadow
		_root.mc_filters.set_shadow_filter (mc_ref);
	}
  
	// ************************
	// minimize window function
	// ************************
	public function minimize_window ():Void
	{
		mc_ref.content_mc._visible = false;
		mc_ref.content_mc.enabled = false;
		
		mc_ref.max_button.enabled = true;
		mc_ref.max_button._alpha = 100;
		
		mc_ref.min_button.enabled = false;
		mc_ref.min_button._alpha = 25;
		
		frame_height = 0;
		draw_frame ();
	}

	// ************************
	// maximize window function
	// ************************
	public function maximize_window ():Void
	{
		mc_ref.content_mc._visible = true;
		mc_ref.content_mc.enabled = false;
		
		mc_ref.max_button.enabled = false;
		mc_ref.max_button._alpha = 25;
		
		mc_ref.min_button.enabled = true;
		mc_ref.min_button._alpha = 100;
		
		frame_height = org_height;
		draw_frame ();
	}

	// *********************
	// close window function
	// *********************
	public function close_window ():Void
	{
		mc_ref.removeMovieClip ();
	}

	// ***************
	// set window data
	// ***************
	public function set_window_data (n:String, w:Number, h:Number, l:String):Void
	{
		mc_ref.window_name_field.text = n;
		
		frame_width = w;
		frame_height = h;
		
		if (org_height == -1)
		{
			org_height = h;
		}
		
		draw_frame ();
		
		mc_ref.min_button._x = w - 50;
		mc_ref.max_button._x = w - 35;
		mc_ref.close_button._x = w - 20;
		
		centering_window ();
		
		mc_ref.attachMovie (l, "content_mc", mc_ref.getNextHighestDepth ());
		mc_ref.content_mc._x = 10;
		mc_ref.content_mc._y = 30;
	}

	// ****************
	// centering window
	// ****************
	public function centering_window ():Void
	{
		mc_ref._x = (Stage.width - frame_width) / 2;
		mc_ref._y = (Stage.height - frame_height) / 2;
	}

	// ****************
	// setup min button
	// ****************
	public function setup_min_button ():Void
	{
		mc_ref.min_button ["class_ref"] = mc_ref;
		mc_ref.min_button.onRelease = function ()
		{
			this.class_ref.minimize_window ();
		}
	}
	
	// ****************
	// setup max button
	// ****************
	public function setup_max_button ():Void
	{
		mc_ref.max_button ["class_ref"] = mc_ref;
		mc_ref.max_button.onRelease = function ()
		{
			this.class_ref.maximize_window ();
		}
		
		// default maximum, so it can be disabled
		mc_ref.max_button.enabled = false;
		mc_ref.max_button._alpha = 25;
	}
	
	// ******************
	// setup close button
	// ******************
	public function setup_close_button ():Void
	{
		mc_ref.close_button ["class_ref"] = mc_ref;
		mc_ref.close_button.onRelease = function ()
		{
			this.class_ref.close_window ();
		}
	}
	
	// ***********
	// setup frame
	// ***********
	public function setup_frame ():Void
	{
		mc_ref.frame_mc ["class_ref"] = mc_ref;
		
		mc_ref.frame_mc.onPress = function ()
		{
			this.class_ref.startDrag ();
			this.class_ref._alpha = 50;
		}
		
		mc_ref.frame_mc.onRelease = function ()
		{
			this.class_ref.stopDrag ();
			this.class_ref._alpha = 100;
		}
	}
}
