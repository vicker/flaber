// ******************
// ClipLoaderMC class
// ******************
class as.interface_element.ClipLoaderMC extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip;

	private var clip_width:Number;
	private var clip_height:Number;
	
	private var display_width:Number;
	private var display_height:Number;
	private var display_boundary:Number;					// used when scale is required
	
	private var temp_interval:Number;
	
	private var clip_mc_url:String;
	
	private var mc_loader:MovieClipLoader;

	// ***********
	// constructor
	// ***********
	public function ClipLoaderMC ()
	{
		mc_ref = this;
		
		mc_ref.attachMovie ("lib_empty_mc", "clip_mc", 1, {_x: 0, _y: 0});
		
		mc_ref.progress_mc.set_dimension (100, 6);
		
		mc_loader = new MovieClipLoader ();
	}

	// ***********
	// unload clip
	// ***********
	public function unload_clip ():Void
	{
		mc_loader.unloadClip (mc_ref.clip_mc);
		clip_mc_url = "";
	}

	// *********************
	// set display dimension
	// *********************
	public function set_display_dimension (w:Number, h:Number):Void
	{
		display_width = w;
		display_height = h;
	}

	// *********************
	// get display dimension
	// *********************
	public function get_display_dimension ():Object
	{
		var temp_dimension:Object = new Object ();
		temp_dimension ["width"] = display_width;
		temp_dimension ["height"] = display_height;
		
		return (temp_dimension);
	}

	// ********************
	// set display boundary
	// ********************
	public function set_display_boundary (n:Number):Void
	{
		display_boundary = n;
	}

	// ************************
	// update display dimension
	// ************************
	private function update_display_dimension ():Void
	{
		// scale approach
		if (display_boundary != null)
		{
			var resize_ratio:Number;
			
			resize_ratio = Math.min (display_boundary / clip_width, display_boundary / clip_height);
			resize_ratio = Math.min (resize_ratio, 1);
			
			display_width = clip_width * resize_ratio;
			display_height = clip_height * resize_ratio;
			
			mc_ref.clip_mc._width = display_width;
			mc_ref.clip_mc._height = display_height;
			
			mc_ref.clip_mc._x = (display_boundary - display_width) / 2;
			mc_ref.clip_mc._y = (display_boundary - display_height) / 2;
		}
		// normal set approach
		else if (display_width != undefined && display_height != undefined)
		{
			mc_ref.clip_mc._width = display_width;
			mc_ref.clip_mc._height = display_height;
		}
		// else do nothing
	}

	// ***********
	// set clip mc
	// ***********
	public function set_clip_mc (s:String):Void
	{
		// place the progress bar first
		mc_ref.attachMovie ("lib_progress_mc", "progress_mc", 2, {_x: 5, _y: 5});
		mc_ref.progress_mc.set_dimension (100, 6);

		var temp_listener:Object = new Object ();
		temp_listener ["class_ref"] = mc_ref;
		
		temp_listener.onLoadInit = function ()
		{
			// store up the original dimensions
			this.class_ref.clip_width = this.class_ref.clip_mc._width;
			this.class_ref.clip_height = this.class_ref.clip_mc._height;
			
			this.class_ref.update_display_dimension ();
			
			this.class_ref.progress_mc._visible = false;
			
			this.class_ref.clip_mc._alpha = 0;
			this.class_ref.temp_interval = setInterval (this.class_ref, "fade_in_interval", 50);

			// release CPU resources
			this.class_ref.mc_loader.removeListener (this);
			
			// remove the progress bar
			this.class_ref.progress_mc.removeMovieClip ();				
		}
		
		temp_listener.onLoadProgress = function (m:MovieClip, l:Number, t:Number)
		{
			var temp_loaded:Number = l;
			var temp_total:Number = t;

			var temp_percentage:Number = 0;
			temp_percentage = temp_loaded / temp_total * 100;
			
			this.class_ref.progress_mc.set_progress_percentage (temp_percentage);
		}
		
		temp_listener.onLoadError = function ()
		{
			_root.status_mc.add_message ("(ClipLoaderMC.as) Image doesn't exists... " + this.class_ref.clip_mc._url, "critical");
			
			// release CPU resources
			this.class_ref.mc_loader.removeListener (this);
		}
		
		mc_loader.addListener (temp_listener);
		mc_loader.loadClip (s, mc_ref.clip_mc);
				
		clip_mc_url = s;
	}
	
	// ****************
	// fade in interval
	// ****************
	private function fade_in_interval ():Void
	{
		mc_ref.clip_mc._alpha = mc_ref.clip_mc._alpha + 10;
		
		if (mc_ref.clip_mc._alpha >= 100)
		{
			mc_ref.clip_mc._alpha = 100;
			clearInterval (temp_interval);
		}
	}
	
	// ***************
	// get clip mc url
	// ***************
	public function get_clip_mc_url ():String
	{
		return (clip_mc_url);
	}
}
