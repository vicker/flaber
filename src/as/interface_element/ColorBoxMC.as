// ****************
// ColorBoxMC class
// ****************
class as.interface_element.ColorBoxMC extends MovieClip
{
	// MC variables
	// MovieClip			content_mc
	// MovieClip			cross_mc
	
	// private variables
	private var color_code:Number;						// color code of the mc
	private var mc_color:Color;							// color obj of the mc
	
	private var mc_ref:MovieClip;							// interface for the color box
  
	// ***********
	// constructor
	// ***********
	public function ColorBoxMC ()
	{
		mc_ref = this;
		mc_color = new Color (mc_ref.content_mc);
		
		color_code = null;
	}

	// *******************
	// onrollover override
	// *******************
	private function onRollOver ()
	{
		mc_ref.gotoAndStop ("over");
	}
	
	// ******************
	// onrollout override
	// ******************
	private function onRollOut ()
	{
		mc_ref.gotoAndStop ("normal");
	}

	// *************************
	// onreleaseoutside override
	// *************************
	private function onReleaseOutside ()
	{
		mc_ref.onRollOut ();
	}
	
	// *************
	// set color rgb
	// *************
	public function set_color_rgb (r:Number, g:Number, b:Number):Void 
	{
		color_code = (r << 16) | (g << 8) | (b);
		mc_color.setRGB (color_code);
		
		mc_ref.cross_mc._visible = false;
	}

	// *************
	// set color num
	// *************
	public function set_color_num (n:Number):Void
	{
		color_code = n;

		if (n != null)
		{
			mc_color.setRGB (color_code);
			mc_ref.cross_mc._visible = false;
		}
		else
		{
			mc_color.setRGB (0xFFFFFF);
			mc_ref.cross_mc._visible = true;
		}
	}

	// **************
	// get color code
	// **************
	public function get_color_code ():String	   
	{
		var temp_string:String;
		
		if (color_code != null)
		{
			temp_string = color_code.toString (16).toUpperCase ();
			
			while (temp_string.length != 6)
			{
				temp_string = "0" + temp_string;
			}
			temp_string = "#" + temp_string;
		}
		else
		{
			temp_string = "No Color";
		}
		
		return temp_string; 
	}
	
	// *************
	// get color num
	// *************
	public function get_color_num ():Number
	{
		return color_code;
	}
}
