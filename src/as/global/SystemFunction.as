import mx.controls.*;

// ********************
// SystemFunction class
// ********************
class as.global.SystemFunction
{
	// ****************
	// get current time
	// ****************
	public function get_time ():String
	{
		var temp_time:as.datatype.DateExtend = new as.datatype.DateExtend ();
		var temp_string:String = "";		
		temp_string = temp_time.get_full_hours () + ":" + temp_time.get_full_minutes ();
		return (temp_string);
	}
	
	// ************
	// popup window
	// ************
	public function build_popup (w:Number, h:Number, n:String, u:String, t:Number):Void
	{
		var temp_properties:String = "";
		
		if (t == 0)
		{
			temp_properties = "toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=yes, width=" + w + ", height=" + h;
		}
		else
		{
			temp_properties = "toolbar=yes, location=yes, status=yes, menubar=yes, scrollbars=yes, resizable=yes, width=" + w + ", height=" + h;
		}
		
		var temp_script:String = "";
		temp_script = "javascript:popup ('" + u + "','" + n + "','" + temp_properties + "')";
		getURL (temp_script);
	}

	// ****************
	// get mouse degree
	// ****************
	public function get_mouse_degree (x:Number, y:Number):Number
	{
		var atan2_value:Number = 0;
		atan2_value = Math.atan2 (_root._ymouse - y, _root._xmouse - x);
		atan2_value = atan2_value / (Math.PI / 180) + 90;
		return (atan2_value);
	}
	
	// *****************
	// color code to num
	// *****************
	// #FFFFFF => 16777215
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
	// #FFFFFF => 0xFFFFFF
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
	// 16777215 => #FFFFFF
	public function color_num_to_code (n:Number):String
	{
		var temp_string:String = "";
		temp_string = n.toString (16).toUpperCase ();
		
		while (temp_string.length != 6)
		{
			temp_string = "0" + temp_string;
		}
		temp_string = "#" + temp_string;
		
		return temp_string; 
	}

	// *******************
	// color num to string
	// *******************
	// 16777215 => 0xFFFFFF
	public function color_num_to_string (n:Number):String
	{
		var temp_string:String = "";
		temp_string = n.toString (16).toUpperCase ();
		
		while (temp_string.length != 6)
		{
			temp_string = "0" + temp_string;
		}
		temp_string = "0x" + temp_string;
		
		return temp_string; 
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
