// ***************
// MCFilters Class
// ***************
class as.global.MCFilters extends MovieClip
{
	// ***********
	// constructor
	// ***********
	public function MCFilters ()
	{
		// actually nothing is necessary for MCFilters
	}
	
	// *********************
	// set brightness filter
	// *********************
	public function set_brightness_filter (m:MovieClip):Void
	{
		var matrix_array:Array;
		var matrix_filter:flash.filters.ColorMatrixFilter;
		
		matrix_array = [1, 0, 0, 0, 100,
							 0, 1, 0, 0, 100,
							 0, 0, 1, 0, 100,
							 0, 0, 0, 1, 0];
		
		matrix_filter = new flash.filters.ColorMatrixFilter (matrix_array);
		m.filters = [matrix_filter];
	}
	
	// *************
	// remove filter
	// *************
	public function remove_filter (m:MovieClip):Void
	{
		m.filters = null;
	}
}