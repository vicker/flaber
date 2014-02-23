// SystemFunction class
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
	
	// **************
	// get movie size
	// **************
	public function get_movie_size ():Object
	{
		var temp_obj:Object;
		
		temp_obj = new Object ();
		temp_obj ["width"] = 800;
		temp_obj ["height"] = 600;
		
		return temp_obj;
	}
}
