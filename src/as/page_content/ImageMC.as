// *************
// ImageMC class
// *************
class as.page_content.ImageMC extends MovieClip
{
	// MC variables
	// MovieClip			clip_mc
	
	// private variables
	private var mc_ref:MovieClip;						// interface for the image mc
	private var mc_loader:MovieClipLoader;			// loader for the image mc

	private var mc_url:String;

	private var edit_mode:Boolean;					// edit mode flag
	
	// constructor
	public function ImageMC ()
	{
		mc_ref = this;
		mc_loader = new MovieClipLoader ();
		
		edit_mode = false;
	}
	
	// ***************
	// data_xml setter
	// ***************
	public function set_data_xml (x:XMLNode):Void
	{
		for (var i in x.childNodes)
		{
			var temp_node:XMLNode;
			var temp_name:String;
			var temp_value:String;
			
			temp_node = x.childNodes [i];
			temp_name = temp_node.nodeName;
			temp_value = temp_node.firstChild.nodeValue;
			
			switch (temp_name)
			{
				// x position of the image
				case "x":
				{
					mc_ref._x = parseInt (temp_value);
					break;
				}
				// y position of the image
				case "y":
				{
					mc_ref._y = parseInt (temp_value);
					break;
				}
				// path of the image
				case "url":
				{
					mc_url = temp_value;
					break;
				}
			}			
		}
		
		mc_loader.loadClip (mc_url, mc_ref.clip_mc);
	}

	// *******************
	// onrollover override
	// *******************
	public function onRollOver ()
	{
		// react only in edit mode
		if (edit_mode == true)
		{
			_root.mc_filters.set_brightness_filter (mc_ref);
			
			pull_edit_panel ();
		}
	}

	// ******************
	// onrollout override
	// ******************
	public function onRollOut ()
	{
		// react only in edit mode
		if (edit_mode == true)
		{
			_root.mc_filters.remove_filter (mc_ref);
		}
	}

	// ***************
	// pull edit panel
	// ***************
	public function pull_edit_panel ():Void
	{
		var temp_x:Number;
		var temp_y:Number;
		
		temp_x = mc_ref._x;
		temp_y = mc_ref._y + mc_ref._height;
		
		_root.edit_panel_mc.set_target_ref (mc_ref);
		_root.edit_panel_mc.set_position (temp_x, temp_y);
	}

	// *****************
	// broadcaster event
	// *****************
	public function broadcaster_event (o:Object):Void
	{
		edit_mode = new Boolean (o);
	}
}
