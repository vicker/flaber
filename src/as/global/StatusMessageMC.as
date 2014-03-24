// *********************
// StatusMessageMC class
// *********************
class as.global.StatusMessageMC extends MovieClip
{
	// MC variables
	// MovieClip							mini_mc	=>	 content_field, icon_mc
	// MovieClip							full_mc	=>  content_field

	private var display_mode:String;						// mini mode or full mode
	private var style_sheet:TextField.StyleSheet;			// stylesheet for the textfields

	private var temp_interval:Number;						// temporary interval for animations
	
	private var mc_ref:MovieClip							// reference back to the status message mc
	
	// ***********
	// constructor
	// ***********
	public function StatusMessageMC ()
	{
		mc_ref = this;
		mc_ref._alpha = 0;
		mc_ref.full_mc._visible = false;

		mc_ref.mini_mc.attachMovie ("lib_frame_mc", "frame_mc", -16384, {_x:0, _y:0});
		mc_ref.full_mc.attachMovie ("lib_frame_mc", "frame_mc", -16384, {_x:0, _y:0});
		
		draw_frame ();
		
		display_mode = "mini";
		
		// setup stylesheet
		style_sheet = new TextField.StyleSheet ();
		style_sheet.load ("style/StatusMessageMC.css");
		
		// setup interface and listeners
		setup_mini_mc ();
		setup_full_mc ();
	}
	
	// ************
	// chase window
	// ************
	public function chase_window ():Void
	{
		mc_ref._x = 0;
		mc_ref._y = Stage.height - 184;
	}
	
	// **********
	// throw away
	// **********
	public function throw_away ():Void
	{
		mc_ref._x = 0;
		mc_ref._y = Stage.height;
	}
	
	// *******************
	// draw frame function
	// *******************
	private function draw_frame ():Void
	{
		// clear all frame first
		mc_ref.mini_mc.frame_mc.clear ();
		mc_ref.full_mc.frame_mc.clear ();
		
		// draw frames
		var frame_width:Number = 0;
		frame_width = Stage.width - 1;
		
		mc_ref.mini_mc.frame_mc.draw_rect (0, 0, frame_width, 22, 1, 0x666666, 100, 0xFFFFFF, 100);
		mc_ref.full_mc.frame_mc.draw_rect (0, 0, frame_width, 160, 1, 0x666666, 100, 0xFFFFFF, 100);
	}
	
	// ***************
	// set transparent
	// ***************
	private function set_transparent ():Void
	{
		switch (display_mode)
		{
			case "mini":
			{
				clearInterval (temp_interval);
				temp_interval = setInterval (mc_ref, "alpha_step", 100, -10);
					
				break;
			}
		}
	}
	
	// ***************
	// alpha step wise
	// ***************
	private function alpha_step (n:Number):Void
	{
		mc_ref._alpha = mc_ref._alpha + n;
		
		// stop looping when reaching max or min
		if (mc_ref._alpha <= 0 || mc_ref._alpha >= 100)
		{
			clearInterval (temp_interval);
		}
		
		// hide the mini mc text when transparent reach a certain amount
		if (mc_ref._alpha < 40 && n < 0)
		{
			mc_ref.mini_mc.content_field._visible = false;
		}
	}
	
	// *************
	// setup mini mc
	// *************
	private function setup_mini_mc ():Void
	{
		var temp_width:Number = 0;
		temp_width = Stage.width;
		
		mc_ref.mini_mc.max_button._x = temp_width - 20;
		mc_ref.mini_mc.min_button._x = temp_width - 35;
		mc_ref.mini_mc.content_field.html = true;
		mc_ref.mini_mc.content_field.styleSheet = style_sheet;

		mc_ref.mini_mc.frame_mc ["class_ref"] = mc_ref;
		mc_ref.mini_mc.frame_mc.useHandCursor = false;
		
		// onrollover override
		mc_ref.mini_mc.frame_mc.onRollOver = function ()
		{
			this.class_ref._alpha = 100;
			this.class_ref.mini_mc.content_field._visible = true;
			clearInterval (this.class_ref.temp_interval);
		}
		
		// onrollout override
		mc_ref.mini_mc.frame_mc.onRollOut = function ()
		{
			// automatically hide after a period of time
			clearInterval (this.class_ref.temp_interval);
			this.class_ref.temp_interval = setInterval (this.class_ref, "set_transparent", 5000);
		}
		
		// maximum button onrelease override
		mc_ref.mini_mc.max_button ["class_ref"] = mc_ref;
		mc_ref.mini_mc.max_button.onRelease = function ()
		{
			clearInterval (this.class_ref.temp_interval);
			this.class_ref.display_mode = "full";
			this.class_ref.full_mc._visible = true;
			
			this.class_ref.mini_mc.min_button.enabled = true;
			this.class_ref.mini_mc.min_button._alpha = 100;
			
			this.class_ref.mini_mc.max_button.enabled = false;
			this.class_ref.mini_mc.max_button._alpha = 25;
		}
		
		// minimum button onrelease override
		mc_ref.mini_mc.min_button ["class_ref"] = mc_ref;
		mc_ref.mini_mc.min_button.onRelease = function ()
		{
			this.class_ref.display_mode = "mini";
			this.class_ref.full_mc._visible = false;
			
			this.class_ref.mini_mc.min_button.enabled = false;
			this.class_ref.mini_mc.min_button._alpha = 25;
			
			this.class_ref.mini_mc.max_button.enabled = true;
			this.class_ref.mini_mc.max_button._alpha = 100;
		}
		
		// default minimized, so can disable min button
		mc_ref.mini_mc.min_button.enabled = false;
		mc_ref.mini_mc.min_button._alpha = 25;
	}
	
	// *************
	// setup full mc
	// *************
	private function setup_full_mc ():Void
	{
		mc_ref.full_mc.content_field.html = true;
		mc_ref.full_mc.content_field._width = Stage.width - 60;
		mc_ref.full_mc.content_field.styleSheet = style_sheet;
		mc_ref.full_mc.attachMovie ("lib_scroll_bar", "scroll_bar", mc_ref.full_mc.getNextHighestDepth ());
		mc_ref.full_mc.scroll_bar.set_scroll_ref (mc_ref.full_mc.content_field);
	}
	
	// ***********
	// add message
	// ***********
	public function add_message (s:String, t:String):Void
	{
		// make the mc appear first
		mc_ref._alpha = 100;
		mc_ref.mini_mc.content_field._visible = true;
		clearInterval (temp_interval);
		temp_interval = setInterval (this, "set_transparent", 5000);
		
		// adding tags
		if (t != "")
		{
			mc_ref.mini_mc.content_field.htmlText = "<" + t + ">" + s + "</" + t + ">";
			
			if (t != "tooltip")
			{
				mc_ref.full_mc.content_field.htmlText = "<" + t + ">" + _root.sys_func.get_time () + " - " + s + "</" + t + ">" + mc_ref.full_mc.content_field.htmlText;
			}
		}
		else
		{
			mc_ref.mini_mc.content_field.htmlText = s;
			mc_ref.full_mc.content_field.htmlText = _root.sys_func.get_time () + " - " + s + mc_ref.full_mc.content_field.htmlText;
		}
		mc_ref.full_mc.scroll_bar.check_scroll ();
		
		// placing mini icon
		var temp_loader:MovieClipLoader = new MovieClipLoader ();
		temp_loader.loadClip ("img/status_message/flash.gif", mc_ref.mini_mc.icon_mc);
	}
}
