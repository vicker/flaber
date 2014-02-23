// **************
// WindowMC class
// **************
class as.global.WindowMC extends MovieClip
{
	// MC variables
	// MovieClip					frame_mc
	// Button						min_button
	// Button						max_button
	// Button						close_button
	// Dynamic Text Field		window_name_field
	
	// private variables
	private var mc_ref:MovieClip;				// interface for the window
	
	private var frame_width:Number;			// frame's width
	private var frame_height:Number;			// frame's height
	private var org_height:Number;			// frame's original height
	
	private var resize_flag:Boolean;			// state whether resize is finished or not
	
	// ***********
	// constructor
	// ***********
	public function WindowMC ()
	{
		mc_ref = this;
		
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
		mc_ref.frame_mc.clear ();
		
		// draw the outer border
		mc_ref.frame_mc.lineStyle (1, 0x666666, 100);
		mc_ref.frame_mc.beginFill (0xFFFFFF, 100);
		mc_ref.frame_mc.moveTo (0, 20);
		mc_ref.frame_mc.lineTo (frame_width, 20);
		mc_ref.frame_mc.lineTo (frame_width, frame_height);
		mc_ref.frame_mc.lineTo (0, frame_height);
		mc_ref.frame_mc.lineTo (0, 20);
		mc_ref.frame_mc.endFill ();
		
		// draw the header
		mc_ref.frame_mc.lineStyle (1, 0x666666, 100);
		mc_ref.frame_mc.beginFill (0xFFFFFF, 100);
		mc_ref.frame_mc.lineTo (0, 0);
		mc_ref.frame_mc.lineTo (frame_width, 0);
		mc_ref.frame_mc.lineTo (frame_width, 20);
		mc_ref.frame_mc.lineTo (0, 20);
		mc_ref.frame_mc.endFill ();
		
		// draw the shadow
		mc_ref.frame_mc.lineStyle (0, 0x000000, 0);
		mc_ref.frame_mc.beginFill (0x000000, 30);
		mc_ref.frame_mc.moveTo (frame_width, 10);
		mc_ref.frame_mc.lineTo (frame_width + 5, 10);
		mc_ref.frame_mc.lineTo (frame_width + 5, frame_height + 5);
		mc_ref.frame_mc.lineTo (0 + 10, frame_height + 5);
		mc_ref.frame_mc.lineTo (0 + 10, frame_height);
		mc_ref.frame_mc.lineTo (frame_width, frame_height);
		mc_ref.frame_mc.lineTo (frame_width, 10);
		mc_ref.frame_mc.endFill ();
	}
  
	// ************************
	// minimize window function
	// ************************
	public function minimize_window ()
	{
		mc_ref.content_mc._visible = false;
		mc_ref.content_mc.enabled = false;
		
		frame_height = 20;
		draw_frame ();
	}

	// ************************
	// maximize window function
	// ************************
	public function maximize_window ()
	{
		mc_ref.content_mc._visible = true;
		mc_ref.content_mc.enabled = false;
		
		frame_height = org_height;
		draw_frame ();
	}

	// *********************
	// close window function
	// *********************
	public function close_window ()
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
		}
		
		mc_ref.frame_mc.onRelease = function ()
		{
			this.class_ref.stopDrag ();
		}
	}
}
