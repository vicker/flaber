// *****************
// ScrollBarMC class
// *****************
class as.global.ScrollBarMC extends MovieClip
{
	// MC variables
	// MovieClip		up_mc
	// MovieClip		down_mc
	// Button			trail_button				using button not mc becos of the sensitive hit area
	// MovieClip		box_mc
	
	private var root_y:Number;						// the _y value of this mc counting from root
	private var original_box_mc_y:Number;		// same usage as the name
	
	private var scroll_height:Number;			// height of the scrolling area
	private var box_displacement:Number;		// displacement of the box per scroll
	
	private var temp_interval:Number;			// temporary interval several listeners
	
	private var mc_ref:MovieClip;					// reference back to the scroll bar mc
	private var scroll_ref:TextField;			// reference back to the scroll area
	
	// ***********
	// constructor
	// ***********
	public function ScrollBarMC ()
	{
		mc_ref = this;
		find_root_y ();
		setup_up_mc ();
		setup_down_mc ();
		setup_box_mc ();
		setup_trail_button ();
		
		original_box_mc_y = mc_ref.box_mc._y;
	}
	
	// ***********
	// find root y
	// ***********
	public function find_root_y ()
	{
		var temp_ref:MovieClip;
		
		root_y = mc_ref._y;
		
		temp_ref = mc_ref._parent;
		while (temp_ref != _root)
		{
			root_y = root_y + temp_ref._y;
			temp_ref = temp_ref._parent;
		}
	}
	
	// ***********
	// setup up mc
	// ***********
	public function setup_up_mc ():Void
	{
		// tell the mc about the class mc...
		mc_ref.up_mc.class_ref = mc_ref;
		
		// up_mc handcursor setting
		mc_ref.up_mc.useHandCursor = false;
		
		// up_mc onrollover listener
		mc_ref.up_mc.onRollOver = function ()
		{
			this.gotoAndStop ("over");
		}
		
		// up_mc onrollout listener
		mc_ref.up_mc.onRollOut = function ()
		{
			this.gotoAndStop ("normal");
		}
		
		// up_mc onpress listener
		mc_ref.up_mc.onPress = function ()
		{
			this.gotoAndStop ("down");
			
			// move the very first step and then set the countdown for continuous movement
			this.class_ref.scroll_step (-1);
			
			clearInterval (this.class_ref.temp_interval);
			this.class_ref.temp_interval = setInterval (this.class_ref, "scroll_step_countdown", 500, -1);
		}
		
		// up_mc onrelease listener
		mc_ref.up_mc.onRelease = function ()
		{
			this.gotoAndStop ("normal");
			
			// stop the continuous movement
			clearInterval (this.class_ref.temp_interval);
		}
		
		// up_mc onreleaseoutside listener
		mc_ref.up_mc.onReleaseOutside = function ()
		{
			this.gotoAndStop ("normal");
		}
	}
	
	// *************
	// setup down mc
	// *************
	public function setup_down_mc ():Void
	{
		// tell the mc about the class mc...
		mc_ref.down_mc.class_ref = mc_ref;
		
		// down_mc handcursor setting
		mc_ref.down_mc.useHandCursor = false;
		
		// down_mc onrollover listener
		mc_ref.down_mc.onRollOver = function ()
		{
			this.gotoAndStop ("over");
		}
		
		// down_mc onrollout listener
		mc_ref.down_mc.onRollOut = function ()
		{
			this.gotoAndStop ("normal");
		}
		
		// down_mc onpress listener
		mc_ref.down_mc.onPress = function ()
		{
			this.gotoAndStop ("down");
			
			// move the very first step and then set the countdown for continuous movement
			this.class_ref.scroll_step (1);
			clearInterval (this.class_ref.temp_interval);
			this.class_ref.temp_interval = setInterval (this.class_ref, "scroll_step_countdown", 500, 1);
		}
		
		// down_mc onrelease listener
		mc_ref.down_mc.onRelease = function ()
		{
			this.gotoAndStop ("normal");
			
			// stop the continuous movement
			clearInterval (this.class_ref.temp_interval);
		}
		
		// down_mc onreleaseoutside listener
		mc_ref.down_mc.onReleaseOutside = function ()
		{
			this.gotoAndStop ("normal");
		}
	}
	
	// ************
	// setup box mc
	// ************
	public function setup_box_mc ():Void
	{
		// tell the mc about the class mc...
		mc_ref.box_mc.class_ref = mc_ref;
		
		// box_mc handcursor setting
		mc_ref.box_mc.useHandCursor = true;
		
		// box_mc onrollover listener
		mc_ref.box_mc.onRollOver = function ()
		{
			this.gotoAndStop ("over");
		}
		
		// box_mc onrollout listener
		mc_ref.box_mc.onRollOut = function ()
		{
			this.gotoAndStop ("normal");
		}
		
		// box_mc onpress listener
		mc_ref.box_mc.onPress = function ()
		{
			this.gotoAndStop ("down")
			
			var temp_box_y:Number;
			temp_box_y = this.class_ref.box_mc._ymouse * this.class_ref.box_mc._height / 400;
			
			this.class_ref.onMouseMove = function ()
			{
				box_track_mouse (temp_box_y);
			}
		}
		
		// box_mc onrelease listener
		mc_ref.box_mc.onRelease = function ()
		{
			this.gotoAndStop ("normal");
			
			delete this.class_ref.onMouseMove;
		}
		
		// box_mc onreleaseoutside listener
		mc_ref.box_mc.onReleaseOutside = function ()
		{
			this.onRelease ();
		}
	}
	
	// ******************
	// setup trail button
	// ******************
	public function setup_trail_button ():Void
	{	
		// tell the mc about the class mc...
		mc_ref.trail_button.class_ref = mc_ref;
		
		// trail_button handcursor setting
		mc_ref.trail_button.useHandCursor = false;
		
		// trail_button onpress listener
		mc_ref.trail_button.onPress = function ()
		{
			var scroll_height:Number;
			var text_height:Number;
			var max_scroll:Number;
			
			var temp_scroll_amount:Number;
			
			scroll_height = this.class_ref.scroll_ref._height;
			text_height = this.class_ref.scroll_ref.textHeight;
			max_scroll = this.class_ref.scroll_ref.maxscroll;
			
			temp_scroll_amount = Math.floor (scroll_height / (text_height / max_scroll));
			
			// scroll according to which position it is clicked
			if (this.class_ref._ymouse > this.class_ref.box_mc._y)
			{
				// move the very first step and then set the countdown for continuous movement
				this.class_ref.scroll_step (temp_scroll_amount);
				clearInterval (this.class_ref.temp_interval);
				this.class_ref.temp_interval = setInterval (this.class_ref, "scroll_step_countdown", 500, temp_scroll_amount);
			}
			else
			{
				this.class_ref.scroll_step (0 - temp_scroll_amount);
				clearInterval (this.class_ref.temp_interval);
				this.class_ref.temp_interval = setInterval (this.class_ref, "scroll_step_countdown", 500, 0 - temp_scroll_amount);
			}
		}
		
		// trail_button onrelease listener
		mc_ref.trail_button.onRelease = function ()
		{
			clearInterval (this.class_ref.temp_interval);
		}
		
		// trail_button onreleaseoutside listener
		mc_ref.trail_button.onReleaseOutside = function ()
		{
			this.onRelease ();
		}
	}
	
	// ****************
	// setup_scroll_ref
	// ****************
	public function setup_scroll_ref ():Void
	{
		// tell the mc about the class mc...
		scroll_ref.class_ref = mc_ref;
		
		// scroll_ref onchanged listener
		scroll_ref.onChanged = function ()
		{
			this.class_ref.check_scroll ();
		}
		
		// scroll_ref onscroller listener
		scroll_ref.onScroller = function ()
		{
			var temp_position:Number;
			
			temp_position = (this.scroll - 1) * this.class_ref.box_displacement;
			this.class_ref.box_mc._y = this.class_ref.original_box_mc_y + temp_position;
		}
	}
	
	// **************************
	// scroll step wise countdown
	// **************************
	public function scroll_step_countdown (n:Number):Void
	{
		clearInterval (temp_interval);
		temp_interval = setInterval (this, "scroll_step", 75, n);
		// CAUTION: dont let the interval timer down to 50, it will have certain bug becos of the event handler cant catch up
	}
	
	// *************************
	// scroll step wise function
	// *************************
	public function scroll_step (n:Number):Void
	{
		scroll_ref.scroll = scroll_ref.scroll + n;
	}

	// ************
	// check_scroll
	// ************
	public function check_scroll ():Void
	{
		var current_height:Number;
		var total_height:Number;
		var new_height:Number;
		var temp_scale:Number;
		
		// defining the box height and scroll status
		current_height = mc_ref.trail_button._height;
		total_height = scroll_ref.textHeight;
		new_height = current_height * (scroll_ref._height / total_height);
		
		if (new_height > current_height)
		{
			// actually this means no need to scroll
			new_height = current_height;
			
			mc_ref.up_mc.enabled = false;
			mc_ref.down_mc.enabled = false;
			mc_ref.trail_button.enabled = false;
			mc_ref.box_mc.enabled = false;
			
			mc_ref.up_mc._alpha = 50;
			mc_ref.down_mc._alpha = 50;
			mc_ref.trail_button._alpha = 0;
			mc_ref.box_mc._alpha = 50;
			
			// making the box_mc back to original position
			mc_ref.box_mc._y = original_box_mc_y;
		}
		else
		{
			// bring back the scroll online
			mc_ref.up_mc.enabled = true;
			mc_ref.down_mc.enabled = true;
			mc_ref.trail_button.enabled = true;
			mc_ref.box_mc.enabled = true;
			
			mc_ref.up_mc._alpha = 100;
			mc_ref.down_mc._alpha = 100;
			mc_ref.trail_button._alpha = 100;
			mc_ref.box_mc._alpha = 100;
		}
		
		mc_ref.box_mc._height = new_height;
		
		// defining the displacement per scroll
		box_displacement = (mc_ref.trail_button._height - mc_ref.box_mc._height) / (scroll_ref.maxscroll - 1);
	}
	
	// ***************
	// box_track_mouse
	// ***************
	public function box_track_mouse (n):Void
	{
		var current_y:Number;
		var temp_scroll_amount:Number;
		var box_adjustment:Number;
		
		current_y = _root._ymouse;
		
		// slight adjustment due to the position of mouse y within box
		box_adjustment = n;
		current_y = current_y - box_adjustment;
		
		// temp_scroll_amount = Math.floor ((current_y - original_y) / box_displacement);
		temp_scroll_amount = Math.ceil ((current_y - root_y - original_box_mc_y) / box_displacement);
		
		// for adverse situation... high speed scrolling
		if (_root._ymouse > root_y + mc_ref._height)
		{
			temp_scroll_amount = scroll_ref.maxscroll;
		}
		
		if (_root._ymouse < root_y)
		{
			temp_scroll_amount = 1;
		}

		scroll_ref.scroll = temp_scroll_amount;
	}
	
	// ****************************
	// scroll_ref setter and getter
	// ****************************
	public function set_scroll_ref (t:TextField):Void
	{
		scroll_ref = t;

		// modifying the buttons and handle in order to fit the content
		var temp_width:Number;
		var temp_height:Number;
		var new_height:Number;
		
		// saving the preset height in order to shrink the handles in proportion
		var preset_height:Number;
		preset_height = 400;
		
		// get values of the scroll content
		temp_width = scroll_ref._width;
		temp_height = scroll_ref._height;
		
		// adjusting scroller position
		mc_ref._x = scroll_ref._x + temp_width + 10;
		mc_ref._y = scroll_ref._y;
		
		// adjusting down arrow
		mc_ref.down_mc._y = temp_height;
		
		// adjusting trail and box
		new_height = temp_height - (2 * mc_ref.up_mc._height) - 6;
		mc_ref.trail_button._height = new_height;
		mc_ref.box_mc._height = new_height;

		// recheck root_y value
		find_root_y ();
		
		// first time checking
		mc_ref.check_scroll ();
		
		// setup scroll ref listeners
		setup_scroll_ref ();
	}
		
	public function get_scroll_ref ():TextField	{ return scroll_ref; }
}