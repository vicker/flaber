// ********************
// ImagePreviewMC class
// ********************
class as.dialogue.ImagePreviewMC extends MovieClip
{
	// MC variables
	// MovieClip				clip_mc
	// Dynamic textfield		clip_name_field
	
	// private variables
	private var mc_ref:MovieClip;	  				// interface for the preview mc
	private var panel_ref:MovieClip;				// reference to the edit panel~ for imageMC

	private var preview_size:Number;				// dimension of the preview mc
	private var clip_url:String;
	private var interval_id:Number;
	
	private var org_width:Number;					// original image dimensions
	private var org_height:Number;
  
	// ***********
	// constructor
	// ***********
	public function ImagePreviewMC ()
	{
		mc_ref = this;
	}
	
	// ********
	// set size
	// ********
	public function set_size (n:Number):Void
	{
		preview_size = n;
		
		mc_ref.clip_name_field._y = n + 5;
		mc_ref.clip_name_field._width = n;
		mc_ref.dimension_field._y = n + 5 + 15;
		mc_ref.dimension_field._width = n;
		mc_ref.bg_mc._width = n;
		mc_ref.bg_mc._height = n + 25;
	}
	
	// ********
	// set clip
	// ********
	public function set_clip (s:String, n:Number):Void
	{
		// make it disappear first
		mc_ref._visible = false;
		
		// remove any clip mc if presents
		if (mc_ref.clip_mc)
		{
			mc_ref.clip_mc.removeMovieClip ();
		}
		
		// create new clip mc
		mc_ref.attachMovie ("lib_empty_mc", "clip_mc", mc_ref.getNextHighestDepth ());
		
		// setting the filename
		var temp_index:Number;
		var temp_name:String;
		
		temp_index = s.lastIndexOf ("/");
		
		if (temp_index != -1)
		{
			temp_name = s.substr (temp_index + 1, 9999);
		}
		else
		{
			temp_name = s;
		}
		
		mc_ref.clip_name_field.text = temp_name;
		
		// loading the clip
		var mc_loader:MovieClipLoader;
		mc_loader = new MovieClipLoader ();
		
		var temp_listener:Object;
		temp_listener = new Object ();
		temp_listener ["n"] = n;
		temp_listener ["class_ref"] = mc_ref;
		
		temp_listener.onLoadInit = function ()
		{
			var resize_ratio:Number;
			
			this.class_ref.org_width = this.class_ref.clip_mc._width;
			this.class_ref.org_height = this.class_ref.clip_mc._height;
			
			resize_ratio = Math.min (this.class_ref.preview_size / this.class_ref.org_width, this.class_ref.preview_size / this.class_ref.org_height);
			resize_ratio = Math.min (resize_ratio, 1);
			
			this.class_ref.clip_mc._width = this.class_ref.org_width * resize_ratio;
			this.class_ref.clip_mc._height = this.class_ref.org_height * resize_ratio;
			
			this.class_ref.clip_mc._x = (this.class_ref.preview_size - this.class_ref.clip_mc._width) / 2;
			this.class_ref.clip_mc._y = (this.class_ref.preview_size - this.class_ref.clip_mc._height) / 2;
			
			this.class_ref.clip_mc._alpha = 0;
			
			this.class_ref.interval_id = setInterval (this.class_ref, "show_image_interval", 50);
			
			this.class_ref._visible = true;
			
			// dimension text
			this.class_ref.dimension_field.text = this.class_ref.org_width + " x " + this.class_ref.org_height;
			
			// panel ref thing, call back panel to update dimension
			// n means need call back
			if (this.class_ref.panel_ref != null && this.n == 1)
			{
				this.class_ref.panel_ref.width_textinput.text = this.class_ref.org_width;
				this.class_ref.panel_ref.height_textinput.text = this.class_ref.org_height;
				this.class_ref.panel_ref.rotation_textinput.text = 0;
			}
		}
		
		temp_listener.onLoadError = function ()
		{
			this.class_ref.clip_name_field.text = "File not found!";
			this.class_ref.dimension_field.text = "";
		}
		
		mc_loader.addListener (temp_listener);
		
		mc_loader.loadClip (s, mc_ref.clip_mc);
		clip_url = s;
	}
	
	// *******************
	// show image interval
	// *******************
	public function show_image_interval ():Void
	{
		mc_ref.clip_mc._alpha = mc_ref.clip_mc._alpha + 10;
		
		if (mc_ref.clip_mc._alpha >= 100)
		{
			mc_ref.clip_mc._alpha = 100;
			clearInterval (interval_id);
		}
	}
	
	// ************
	// get clip url
	// ************
	public function get_clip_url ():String
	{
		return (clip_url);
	}

	// *************
	// get org width
	// *************
	public function get_org_width ():Number
	{
		return (org_width);
	}
	
	// **************
	// get org height
	// **************
	public function get_org_height ():Number
	{
		return (org_height);
	}
	
	// *************
	// set panel ref
	// *************
	public function set_panel_ref (m:MovieClip)
	{
		panel_ref = m;
	}
}
