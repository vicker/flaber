// *****************
// RectangleMC class
// *****************
class as.shape.RectangleMC extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip;				// interface for the rectangle mc
	
	// rectangle parameters
	private var rect_width:Number;
	private var rect_height:Number;
	private var rect_corner:Number;
	private var fill_color:Number;

	private var edit_mode:Boolean;			// edit mode flag
	
	// ***********
	// constructor
	// ***********
	public function RectangleMC ()
	{
		mc_ref = this;
		
		edit_mode = false;
	}
	
	// *******
	// draw_it
	// *******
	public function draw_it ():Void
	{
		if (fill_color != null)
		{
			mc_ref.beginFill (fill_color);
		}
		
		mc_ref.lineTo (rect_width, 0);
		mc_ref.lineTo (rect_width, rect_height);
		mc_ref.lineTo (0, rect_height);
		mc_ref.lineTo (0, 0);
		
		if (fill_color != null)
		{
			mc_ref.endFill ();
		}
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
				// x position of the rectangle mc
				case "x":
				{
					mc_ref._x = parseInt (temp_value);
					break;
				}
				// y position of the rectangle mc
				case "y":
				{
					mc_ref._y = parseInt (temp_value);
					break;
				}
				// width of the rectangle mc
				case "width":
				{
					rect_width = parseInt (temp_value);
					break;
				}
				// height of the rectangle mc
				case "height":
				{
					rect_height = parseInt (temp_value);
					break;
				}
				// corner radius of the rectangle mc
				case "corner":
				{
					rect_corner = parseInt (temp_value);
					break;
				}
				// line style of the line of rectangle
				case "line_style":
				{
					var temp_style:Array;
					temp_style = new Array ();
					temp_style = temp_value.split ("|");
					
					mc_ref.lineStyle (parseInt (temp_style [0]), parseInt (temp_style [1]), parseInt (temp_style [2]));
					break;
				}
				// fill color of the rectangle mc
				case "fill_color":
				{
					fill_color = parseInt (temp_value);
					break;
				}
				// alpha of the whole rectangle mc
				case "alpha":
				{
					mc_ref._alpha = parseInt (temp_value);
					break;
				}
			}
			
			draw_it ();
		}		
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