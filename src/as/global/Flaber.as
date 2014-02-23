// ******************************
// Flaber class (central control)
// ******************************
class as.global.Flaber
{
	// private variables
	var page_dir_array:Array;					// array storing all the files in the page directory
	
	// ***********
	// constructor
	// ***********
	public function Flaber ()
	{
		page_dir_array = new Array ();
		
		build_root ();
		config_broadcaster ();
		preload_page_dir_array ();
		flaber_startup ();
		load_content ();
	}
	
	// ***********************
	// build up root variables
	// ***********************
	private function build_root ():Void
	{
		_root.sys_func = new as.global.SystemFunction ();				// system function
		_root.mode_broadcaster = new as.global.Broadcaster (1);		// change mode broadcaster
		_root.export_broadcaster = new as.global.Broadcaster (2);	// export broadcaster
		_root.mc_filters = new as.global.MCFilters ();					// movieclip filters
		_root.component_style = new as.global.ComponentStyle ();		// component styles
	}
	
	// ******************
	// config broadcaster
	// ******************
	private function config_broadcaster ():Void
	{
		//TODO I think not every web will need a navigation menu... maybe should depends on a global web config file...
		_root.mode_broadcaster.add_observer (_root.navigation_menu);
		_root.export_broadcaster.add_observer (_root.navigation_menu);
		
		// this line is a must
		_root.export_broadcaster.add_observer (_root.page_mc);
	}
	
	// **************
	// flaber startup
	// **************
	private function flaber_startup ():Void
	{
		_root.status_mc.add_message ("<flaber_f>F</flaber_f><flaber_l>L</flaber_l><flaber_a>A</flaber_a><flaber_b>B</flaber_b><flaber_e>E</flaber_e><flaber_r>R</flaber_r> Prototype version 0.4.7 night build Jan 27", "flaber");
	}
	
	// ************
	// load content
	// ************
	private function load_content ():Void
	{
		_root.navigation_menu.load_root_xml ("NavigationMenu.xml");
		_root.page_mc.load_root_xml ("index.xml");
	}
	
	// ****************
	// preload page dir
	// ****************
	private function preload_page_dir_array ():Void
	{
		var dir_xml:XML;
		
		dir_xml = new XML ();
		dir_xml.ignoreWhite = true;
		dir_xml ["class_ref"] = this;
		dir_xml.sendAndLoad ("http://www.flysforum.net/vicatfyp/release/1_0/function/get_dir.php?target_dir=../page", dir_xml);
		
		dir_xml.onLoad = function (b:Boolean)
		{
			if (b)
			{
				for (var i in this.firstChild.childNodes)
				{
					var temp_value:String;
					
					temp_value = this.firstChild.childNodes [i].firstChild.nodeValue;
					
					this.class_ref.page_dir_array.push (temp_value);
				}
				
				this.class_ref.page_dir_array.sort ();
			}
		}
	}
	
	// ******************
	// get page dir array
	// ******************
	public function get_page_dir_array ():Array
	{
		return (page_dir_array);
	}
}