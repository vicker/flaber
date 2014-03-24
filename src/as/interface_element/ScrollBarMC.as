// *****************
// ScrollBarMC class
// *****************
class as.interface_element.ScrollBarMC extends MovieClip
{
	// MC variables
	// MovieClip		up_mc
	// MovieClip		down_mc
	// Button			trail_mc				using button not mc becos of the sensitive hit area
	// MovieClip		box_mc
	
	private var scroll_height:Number;			// height of the scrolling area
	private var box_displacement:Number;		// displacement of the box per scroll
	private var original_box_mc_y:Number;		// same usage as the name
	
	private var temp_interval:Number;			// temporary interval several listeners
	
	private var mc_ref:MovieClip;					// reference back to the scroll bar mc
	private var scroll_ref:TextField;			// reference back to the scroll area
	
	// ***********
	// constructor
	// ***********
	public function ScrollBarMC ()
	{
		mc_ref = this;
		setup_up_mc ();
		setup_down_mc ();
		setup_box_mc ();
		setup_trail_mc ();
		
		original_box_mc_y = mc_ref.box_mc._y;
	}
	
	// ***********
	// setup up mc
	// ***********
	private function setup_up_mc ():Void
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
			
			// stop the continuous movement
			clearInterval (this.class_ref.temp_interval);
		}
	}
	
	// *************
	// setup down mc
	// *************
	private function setup_down_mc ():Void
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
			
			// stop the continuous movement
			clearInterval (this.class_ref.temp_interval);
		}
	}
	
	// ************
	// setup box mc
	// ************
	private function setup_box_mc ():Void
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
			
			var temp_box_y:Number = 0;
			var temp_scroll:Number = 0;
			
			temp_box_y = _root._ymouse;
			temp_scroll = this.class_ref.scroll_ref.scroll;
			
			this.class_ref.onMouseMove = function ()
			{
				box_track_mouse (temp_box_y, temp_scroll);
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
	private function setup_trail_mc ():Void
	{	
		// tell the mc about the class mc...
		mc_ref.trail_mc.class_ref = mc_ref;
		
		// trail_mc handcursor setting
		mc_ref.trail_mc.useHandCursor = false;
		
		// trail_mc onpress listener
		mc_ref.trail_mc.onPress = function ()
		{
			var scroll_height:Number = 0;
			var text_height:Number = 0;
			var max_scroll:Number = 0;
			
			var temp_scroll_amount:Number = 0;
			
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
		
		// trail_mc onrelease listener
		mc_ref.trail_mc.onRelease = function ()
		{
			clearInterval (this.class_ref.temp_interval);
		}
		
		// trail_mc onreleaseoutside listener
		mc_ref.trail_mc.onReleaseOutside = function ()
		{
			this.onRelease ();
		}
	}
	
	// ****************
	// setup_scroll_ref
	// ****************
	private function setup_scroll_ref ():Void
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
			// when scroll, have to move the box too
			this.class_ref.check_box ();
		}
	}
	
	// **************************
	// scroll step wise countdown
	// **************************
	private function scroll_step_countdown (n:Number):Void
	{
		clearInterval (temp_interval);
		temp_interval = setInterval (this, "scroll_step", 75, n);
		// CAUTION: dont let the interval timer down to 50, it will have certain bug becos of the event handler cant catch up
	}
	
	// *************************
	// scroll step wise function
	// *************************
	private function scroll_step (n:Number):Void
	{
		scroll_ref.scroll = scroll_ref.scroll + n;
	}

	// ************
	// check_scroll
	// ************
	private function check_scroll ():Void
	{
		var current_height:Number = 0;
		var total_height:Number = 0;
		var new_height:Number = 0;
		var temp_scale:Number = 0;
		
		// defining the box height and scroll status
		current_height = mc_ref.trail_mc._height;
		total_height = scroll_ref.textHeight;
		new_height = current_height * (scroll_ref._height / total_height);
		
		if (new_height > current_height)
		{
			// actually this means no need to scroll
			new_height = current_height;
			
			mc_ref.up_mc.enabled = false;
			mc_ref.down_mc.enabled = false;
			mc_ref.trail_mc.enabled = false;
			mc_ref.box_mc.enabled = false;
			
			mc_ref.up_mc._alpha = 50;
			mc_ref.down_mc._alpha = 50;
			mc_ref.trail_mc._alpha = 0;
			mc_ref.box_mc._alpha = 50;
			
			// making the box_mc back to original position
			mc_ref.box_mc._y = original_box_mc_y;
		}
		else
		{
			// bring back the scroll online
			mc_ref.up_mc.enabled = true;
			mc_ref.down_mc.enabled = true;
			mc_ref.trail_mc.enabled = true;
			mc_ref.box_mc.enabled = true;
			
			mc_ref.up_mc._alpha = 100;
			mc_ref.down_mc._alpha = 100;
			mc_ref.trail_mc._alpha = 100;
			mc_ref.box_mc._alpha = 100;
		}
		
		mc_ref.box_mc._height = new_height;
		
		// defining the displacement per scroll
		box_displacement = (mc_ref.trail_mc._height - mc_ref.box_mc._height) / (scroll_ref.maxscroll - 1);
	}
	
	// *********
	// check_box
	// *********
	private function check_box ():Void
	{
		var temp_position:Number = 0;
		
		temp_position = (mc_ref.scroll_ref.scroll - 1) * box_displacement;
		mc_ref.box_mc._y = mc_ref.original_box_mc_y + temp_position;
	}
	
	// ***************
	// box_track_mouse
	// ***************
	private function box_track_mouse (n:Number, s:Number):Void
	{
		var temp_distance:Number = 0;
		temp_distance = _root._ymouse - n;
		
		scroll_ref.scroll = s + Math.round (temp_distance / box_displacement);
		check_box ();
	}
	
	// ****************************
	// scroll_ref setter and getter
	// ****************************
	public function set_scroll_ref (t:TextField):Void
	{
		scroll_ref = t;
		
		// modifying the buttons and handle in order to fit the content
		var temp_width:Number = 0;
		var temp_height:Number = 0;
		var new_height:Number = 0;
		
		// saving the preset height in order to shrink the handles in proportion
		var preset_height:Number = 400;
		
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
		mc_ref.trail_mc._height = new_height;
		mc_ref.box_mc._height = new_height;
		
		// first time checking
		mc_ref.check_scroll ();
		
		// setup scroll ref listeners
		setup_scroll_ref ();
	}
		
	public function get_scroll_ref ():TextField
	{
		return scroll_ref;
	}
}
