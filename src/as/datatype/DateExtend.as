// ****************
// DateExtend class
// ****************
class as.datatype.DateExtend extends Date
{
	// ****************
	// get full minutes
	// ****************
	public function get_full_minutes ():String
	{
		var temp_minute:Number = 0;
		temp_minute = this.getMinutes ();
		
		if (temp_minute < 10)
		{
			return ("0" + temp_minute.toString ());
		}
		else
		{
			return (temp_minute.toString ());
		}
	}
	
	// **************
	// get full hours
	// **************
	public function get_full_hours ():String
	{
		var temp_hour:Number = 0;
		temp_hour = this.getHours ();
		
		if (temp_hour < 10)
		{
			return ("0" + temp_hour.toString ());
		}
		else
		{
			return (temp_hour.toString ());
		}
	}
}
