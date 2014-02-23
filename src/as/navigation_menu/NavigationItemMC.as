// NavigationItemMC class
class as.navigation_menu.NavigationItemMC extends MovieClip
{
	// MC variables
	// Dynamic Text Field			content_field
	
	// private variables
	private var text_format:TextFormat;				// text format of the text content
	
	private var mc_ref:MovieClip;						// interface for the navigation item mc
	private var menu_ref:MovieClip;					// reference back to the navigation menu
	private var page_ref:MovieClip;					// reference back to the page content mc
	
	private var global_flag:Boolean;					// state that this item is using global style or not
	
	// constructor
	public function NavigationItemMC ()
	{
		mc_ref = this;
		text_format = new TextFormat ();
	}
	
	// onpress override
	public function onPress ()
	{
		// react only in edit mode
		if (_root.config ["edit_mode"])
		{
			this.startDrag ();
		}
	}
	
	// onrelease override
	public function onRelease ()
	{
		// react as drag in edit mode
		if (_root.config ["edit_mode"])
		{
			this.stopDrag ();
		}
		// otherwise work as simple button
		else
		{
			// somthing
		}
	}
	
	// onreleaseoutside override
	public function onReleaseOutside ()
	{
		onRollOut ();
	}
	
	// onrollover override
	public function onRollOver ()
	{
		// react only in non editing mode
		if (!_root.config ["edit_mode"])
		{
			mc_ref.gotoAndStop ("over");
			_root.status_mc.add_message ("Navigation Item", "tooltip");
		}
	}
	
	// onrollout override
	public function onRollOut ()
	{
		// react only in non editing mode
		if (!_root.config ["edit_mode"])
		{
			mc_ref.gotoAndStop ("normal");
		}
	}
	
	// content_field setter and getter
	public function set_content_field (s:String):Void { mc_ref.content_field.text = s; }
	public function get_content_field ():String	      { return mc_ref.content_field.text; }
	
	// text_format setter and getter
	public function set_text_format (a:Array, f:TextFormat):Void
	{
		if (a)
		{
			for (var i in a)
			{
				var temp_position = a [i].indexOf ("|");
				var temp_property = a [i].substr (0, temp_position);
				var temp_value = a [i].substr (temp_position + 1);
				text_format [temp_property] = temp_value;
			}
		}
		else if (f)
		{
			text_format = f;
		}
		else
		{
			trace ("NavigationItemMC.as -> set_text_format fail.");
		}
		
		mc_ref.content_field.setTextFormat (text_format);
	}
	
	public function copy_text_format (f:TextFormat):Void
	{
		text_format = f;
		mc_ref.content_field.setTextFormat (text_format);
	}
	
	public function get_text_format ():Array	   
	{
		var temp_array = new Array ();
		
		for (var i in text_format)
		{
			temp_array.push (i + "|" + text_format [i]); 
		}
		
		trace (temp_array);
		return temp_array;
	}
	
	public function export_xml ():XMLNode
	{
		var out_xml:XML;
		
		var root_node:XMLNode;
		var temp_node:XMLNode;
		var temp_node_2:XMLNode;
		
		out_xml = new XML ();
		
		// building root node
		root_node = out_xml.createElement ("NavigationItemMC");
		
		// x of navigation item
		temp_node = out_xml.createElement ("x");
		temp_node_2 = out_xml.createTextNode (mc_ref._x.toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// y of navigation item
		temp_node = out_xml.createElement ("y");
		temp_node_2 = out_xml.createTextNode (mc_ref._y.toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// text of navigation item
		temp_node = out_xml.createElement ("text");
		temp_node_2 = out_xml.createTextNode (mc_ref.content_field.text);
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// overriding styles, if any
		if (global_flag)
		{
			//TODO if doing override style, then many things have to be added here
		}
		
		// export the xml node to whatever place need this
		return (root_node);
	}
	
	// global_flag setter and getter
	public function set_global_flag (b:Boolean):Void	{ global_flag = b; }
	public function get_global_flag ():Boolean			{ return global_flag; }
}
