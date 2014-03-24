import flash.filters.*;

// ***************
// MCFilters Class
// ***************
class as.global.MCFilters
{	
	// *********************
	// set brightness filter
	// *********************
	public function set_brightness_filter (m:MovieClip):Void
	{
		// Ref: http://livedocs.macromedia.com/flash/8/main/00001493.html
		
		var matrix_array:Array;
		var matrix_filter:ColorMatrixFilter;
		
		matrix_array = [1, 0, 0, 0, 100,
							 0, 1, 0, 0, 100,
							 0, 0, 1, 0, 100,
							 0, 0, 0, 1, 0];
		
		matrix_filter = new ColorMatrixFilter (matrix_array);
		m.filters = [matrix_filter];
	}
	
	// *******************
	// set contrast filter
	// *******************
	public function set_contrast_filter (m:MovieClip):Void
	{
		// Ref: http://www.kaourantin.net/2005/09/using-flash-player-8-filters-for-good.html
		// http://www.flash-db.com/Tutorials/snapshot/snapshot.php
		
		var matrix_array:Array;
		var matrix_filter:ColorMatrixFilter;
		
		matrix_array = [1, 0, 0, 0, 0,
							 0, 1, 0, 0, 0,
							 0, 0, 1, 1, 0,
							 0, 0, 0, 25, 0];
		
		matrix_filter = new ColorMatrixFilter (matrix_array);
		m.filters = [matrix_filter];
	}
	
	// *****************
	// set shadow filter
	// *****************
	public function set_shadow_filter (m:MovieClip):Void
	{
		var distance:Number = 10;
		var angleInDegrees:Number = 45;
		var color:Number = 0x000000;
		var alpha:Number = .8;
		var blurX:Number = 8;
		var blurY:Number = 8;
		var strength:Number = 1;
		var quality:Number = 3;
		var inner:Boolean = false;
		var knockout:Boolean = false;
		var hideObject:Boolean = false;
		
		var filter:DropShadowFilter = new DropShadowFilter(distance, angleInDegrees, color, alpha, 
		                                                   blurX, blurY, strength, quality, 
		                                                   inner, knockout, hideObject);
		
		var filterArray:Array = new Array();
		filterArray.push(filter);
		m.filters = filterArray;		
	}
	
	// *************
	// remove filter
	// *************
	public function remove_filter (m:MovieClip):Void
	{
		m.filters = null;
	}
}
