// SystemFunction class
class as.global.SystemFunction
{
	// ***********
	// constructor
	// ***********
	public function SystemFunction ()
	{
		// actually nothing is necessary for system function
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
}
