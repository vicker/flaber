// ***************
// XMLExtend class
// ***************
class as.datatype.XMLExtend extends XML
{
	private var interval_id:Number;
	
	private var stored_percentage:Number;
	
	private var interval_date:Date;
	private var interval_time:Number;

	// **************
	// check progress
	// **************
	public function check_progress (s:String):Void
	{
		interval_id = setInterval (this, "check_progress_interval", 100, s);
		
		stored_percentage = 0;
		
		interval_date = new Date ();
		interval_time = interval_date.getTime ();
	}
	
	// *************
	// stop progress
	// *************
	public function stop_progress ():Void
	{
		clearInterval (interval_id);
	}
	
	// ***********************
	// check progress interval
	// ***********************
	public function check_progress_interval (s:String):Void
	{
		var temp_loaded:Number = 0;
		var temp_total:Number = 0;
		var temp_percentage:Number = 0;
		var temp_string:String = "";
		
		temp_loaded = this.getBytesLoaded ();
		temp_total = this.getBytesTotal ();
		
		if (temp_total == undefined || temp_total == 0)
		{
			temp_total = 99999999;
		}
		
		temp_percentage = Math.round (temp_loaded / temp_total * 10000) / 100;
		temp_string = s + " " + temp_percentage + "%";
		
		_root.status_mc.add_message (temp_string, "tooltip");
		
		if (temp_percentage >= 100)
		{
			clearInterval (interval_id);
		}
		
		// timeout in 30 seconds
		// and if the percentage is not changing
		interval_date = new Date ();
		if (interval_date.getTime () - interval_time > 30000)
		{
			// random checking because the repeat interval is too short
			if (Math.random () <= 0.075)
			{
				if (temp_percentage == stored_percentage)
				{
					_root.status_mc.add_message ("<critical>" + temp_string + " failed (30 seconds timeout)</critical>", "");
					clearInterval (interval_id);
				}
				else
				{
					stored_percentage = temp_percentage;
				}
			}
		}
	}
}
