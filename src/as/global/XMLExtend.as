// ***************
// XMLExtend class
// ***************
class as.global.XMLExtend extends XML
{
	private var interval_id:Number;

	// **************
	// check progress
	// **************
	public function check_progress (s:String):Void
	{
		interval_id = setInterval (this, "check_progress_interval", 100, s);
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
		var temp_loaded:Number;
		var temp_total:Number;
		var temp_percentage:Number;
		var temp_string:String;
		
		temp_loaded = this.getBytesLoaded ();
		temp_total = this.getBytesTotal ();
		
		if (temp_total == undefined)
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
	}
}
