// StatusMessageMC class
class as.global.StatusMessageMC extends MovieClip
{
	// MC variables
	// MovieClip							mini_mc	=>	 content_field, icon_mc
	// MovieClip							full_mc	=>  content_field

	private var display_mode:String;							// mini mode or full mode
	private var style_sheet:TextField.StyleSheet;		// stylesheet for the textfields

	private var temp_interval:Number;						// temporary interval for animations
	
	private var mc_ref:MovieClip								// reference back to the status message mc
	
	// ***********
	// constructor
	// ***********
	public function StatusMessageMC ()
	{
		mc_ref = this;
		mc_ref._alpha = 0;
		mc_ref.useHandCursor = false;
		
		display_mode = "mini";
		mc_ref.full_mc._visible = false;
		
		// setup listeners
		setup_mini_mc ();
		
		// setup textfields
		mc_ref.mini_mc.content_field.html = true;
		mc_ref.full_mc.content_field.html = true;
		
		// setup stylesheet
		style_sheet = new TextField.StyleSheet ();
		style_sheet.load ("style/StatusMessageMC.css");
		
		mc_ref.mini_mc.content_field.styleSheet = style_sheet;
		mc_ref.full_mc.content_field.styleSheet = style_sheet;
		
		// setup full mc's scroll bar
		mc_ref.full_mc.attachMovie ("lib_scroll_bar", "scroll_bar", mc_ref.full_mc.getNextHighestDepth ());
		mc_ref.full_mc.scroll_bar.set_scroll_ref (mc_ref.full_mc.content_field);
	}
	
	// ***************
	// set transparent
	// ***************
	public function set_transparent ():Void
	{
		clearInterval (temp_interval);
		temp_interval = setInterval (this, "alpha_step", 100, -10);
	}
	
	// ***************
	// alpha step wise
	// ***************
	public function alpha_step (n:Number):Void
	{
		mc_ref._alpha = mc_ref._alpha + n;
		
		// stop looping when reaching max or min
		if (mc_ref._alpha <= 0 || mc_ref._alpha >= 100)
		{
			clearInterval (temp_interval);
		}
	}
	
	// *************
	// setup mini mc
	// *************
	public function setup_mini_mc ():Void
	{
		mc_ref.mini_mc.class_ref = mc_ref;
		
		// onrollover override
		mc_ref.mini_mc.onRollOver = function ()
		{
			this.class_ref._alpha = 100;
			clearInterval (this.class_ref.temp_interval);
		}
		
		// onrollout override
		mc_ref.mini_mc.onRollOut = function ()
		{
			switch (this.class_ref.display_mode)
			{
				case "mini":
				{
					// automatically hide after a period of time
					clearInterval (this.class_ref.temp_interval);
					this.class_ref.temp_interval = setInterval (this.class_ref, "set_transparent", 5000);
					
					break;
				}
			}
		}
		
		// onrelease override
		mc_ref.mini_mc.onRelease = function ()
		{
			switch (this.class_ref.display_mode)
			{
				case "mini":
				{
					this.class_ref.display_mode = "full";
					this.class_ref.full_mc._visible = true;
					
					break;
				}
				case "full":
				{
					this.class_ref.display_mode = "mini";
					this.class_ref.full_mc._visible = false;
					
					break;
				}
			}			
		}
	}
	
	// ***********
	// add message
	// ***********
	public function add_message (s:String, t:String):Void
	{
		// make the mc appear first
		mc_ref._alpha = 100;
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
		var temp_loader:MovieClipLoader;
		
		temp_loader = new MovieClipLoader ();
		temp_loader.loadClip ("img/status_message/flash.gif", mc_ref.mini_mc.icon_mc);
	}
}