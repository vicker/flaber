// *****************
// broadcaster class
// *****************
class as.datatype.Broadcaster
{
	private var broadcaster_type:Number;						// the type of broadcaster
	private var changed_flag:Boolean;							// state that if the value is changed
	private var observers_array:Array;							// an array of all the observers
	
	// ***********
	// constructor
	// ***********
	public function Broadcaster (t:Number)
	{
		broadcaster_type = t;
		changed_flag = false;
		observers_array = new Array ();
	}
	
	// ************
	// add observer
	// ************
	public function add_observer (o:as.datatype.Observer):Boolean
	{
		// preventing null observer
		if (o == null)
		{
			return false;
		}
		
		// preventing already registered observer
		for (var i in observers_array)
		{
			if (observers_array [i] == o)
			{
				return false;
			}
		}
		
		// putting observer into the array
		observers_array.push (o);
		return true;
	}
	
	// ***************
	// remove observer
	// ***************
	public function remove_observer (o:as.datatype.Observer):Boolean
	{
		for (var i in observers_array)
		{
			if (observers_array [i] == o)
			{
				observers_array.splice (i, 1);
				return true;
			}
		}
		
		return false;
	}
	
	// *********
	// broadcast
	// *********
	public function broadcast (o:Object):Void
	{
		// if nothing... make it null
		if (o == undefined)
		{
			o = null;
		}
		
		// if not changed, skip it
		if (!changed_flag)
		{
			return;
		}
		
		// invoke the changer
		for (var i in observers_array)
		{
			switch (broadcaster_type)
			{
				case 1:
				{
					// edit mode broadcaster
					observers_array [i].broadcaster_event (o);
					break;
				}
				case 2:
				{
					// save broadcaster
					observers_array [i].save_xml ();
					break;
				}
			}
		}
		
		// flag down
		changed_flag = false;
	}
	
	// ***************
	// clear observers
	// ***************
	public function clear_observers ():Void
	{
		observers_array = new Array ();
	}
	
	// ****************
	// set changed flag
	// ****************
	public function set_changed_flag ():Void
	{
		changed_flag = true;
	}
}
