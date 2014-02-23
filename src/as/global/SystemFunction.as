// ********************
// SystemFunction class
// ********************
class as.global.SystemFunction
{
	// private variables
	var edit_mode:Boolean;
	
	// ***********
	// constructor
	// ***********
	public function SystemFunction ()
	{
		// actually nothing is necessary for system function
		edit_mode = false;
	}
	
	// *************
	// get edit mode
	// *************
	public function get_edit_mode ():Boolean
	{
		return edit_mode;
	}
	
	// *************
	// set edit mode
	// *************
	public function set_edit_mode (b:Boolean):Void
	{
		edit_mode = b;
	}
	
	// ****************
	// get current time
	// ****************
	public function get_time ():String
	{
		var temp_time:Date;
		var temp_string:String;
		
		temp_time = new Date ();
		temp_string = temp_time.getMinutes ().toString ();
		
		if (temp_time.getMinutes () < 10)
		{
			temp_string = "0" + temp_string;
		}
		
		temp_string = temp_time.getHours ().toString () + ":" + temp_string;
		
		if (temp_time.getHours () < 10)
		{
			temp_string = "0" + temp_string;
		}
		
		return (temp_string);
	}
	
	// ************
	// popup window
	// ************
	public function build_popup (w:Number, h:Number, n:String, u:String, t:Number):Void
	{
		var temp_properties:String;
		
		if (t == 0)
		{
			temp_properties = "toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=yes, width=" + w + ", height=" + h;
		}
		else
		{
			temp_properties = "toolbar=yes, location=yes, status=yes, menubar=yes, scrollbars=yes, resizable=yes, width=" + w + ", height=" + h;
		}
		
		var temp_script:String;
		temp_script = "javascript:popup ('" + u + "','" + n + "','" + temp_properties + "')";
		getURL (temp_script);
	}

	// ****************
	// get mouse degree
	// ****************
	public function get_mouse_degree (x:Number, y:Number):Number
	{
		var atan2_value:Number;
				atan2_value = Math.atan2 (_root._ymouse - y, _root._xmouse - x);
		
		return (atan2_value / (Math.PI / 180) + 90);
	}
	
	// *****************
	// color code to num
	// *****************
	public function color_code_to_num (s:String):Number
	{
		if (s.charAt (0) == "#")
		{
			s = s.substr (1, 6);
		}
		
		s = "0x" + s;
		
		if (isNaN (parseInt (s)))
		{
			return 0;
		}
		else
		{
			return parseInt (s);
		}
	}
	
	// ********************
	// color code to string
	// ********************
	public function color_code_to_string (s:String):String
	{
		if (s.charAt (0) == "#")
		{
			s = s.substr (1, 6);
		}
		
		s = "0x" + s;
		
		if (s.length == 8)
		{
			return (s);
		}
		else
		{
			return (null);
		}
	}
	
	// *****************
	// color num to code
	// *****************
	public function color_num_to_code (n:Number):String
	{
		var temp_string:String;
		
		temp_string = n.toString (16).toUpperCase ();
		
		while (temp_string.length != 6)
		{
			temp_string = "0" + temp_string;
		}
		temp_string = "#" + temp_string;
		
		return temp_string; 
	}

	// ********************
	// combobox select item
	// ********************
	public function combobox_select_item (c:mx.controls.ComboBox, s:String):Number
	{
		// find inside the combobox
		for (var i = 0; i < c.length; i++)
		{
			if (s == c.getItemAt (i).data)
			{
				c.selectedIndex = i;
				return (i);
			}
		}
		
		// if not found but editable
		if (c.editable == true)
		{
			c.text = s;
			return (null);
		}
		
		// if not found and not editable
		return (-1);
	}

	// ****************
	// list select item
	// ****************
	public function list_select_item (l:mx.controls.List, s:String):Number
	{
		// find inside the list
		for (var i = 0; i < l.length; i++)
		{
			if (s == l.getItemAt (i).data)
			{
				l.selectedIndex = i;
				return (i);
			}
		}
		
		// if not found
		return (-1);
	}

	// **********************
	// button toggle selected
	// **********************
	public function button_toggle_selected (b:mx.controls.Button)
	{
		if (b.toggle == true)
		{
			if (b.selected == true)
			{
				b.selected = false;
			}
			else
			{
				b.selected = true;
			}
		}
	}

	// *****************
	// string to boolean
	// *****************
	public function string_to_boolean (s:String):Boolean
	{
		if (s.toLowerCase () == "true")
		{
			return true;
		}
		
		if (s.toLowerCase () == "false")
		{
			return false;
		}
		
		return null;
	}

	// ****************
	// remove window mc
	// ****************
	public function remove_window_mc ():Void
	{
		if (_root.window_mc)
		{
			_root.window_mc.removeMovieClip ();
		}
	}
	
	// ***************
	// get break cache
	// ***************
	public function get_break_cache ():String
	{
		// because break cache method will prevent local testing
		// so using this approach
		// reference http://www.shockwave-india.com/blog/actionscript/?asfile=skipCache.as
		
		if (_url.indexOf ("file") == 0)
		{
			return ("");
		}
		else
		{
			return ("?break_cache=" + new Date ().getTime ().toString ());
		}
	}
}
