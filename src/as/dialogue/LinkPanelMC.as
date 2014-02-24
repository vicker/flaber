// *****************
// LinkPanelMC class
// *****************
class as.dialogue.LinkPanelMC extends MovieClip
{
	// MC variables
	// MovieClip				panel_mc
	
	// private variables
	private var mc_ref:MovieClip;	  				// interface for the link panel
	private var panel_ref:MovieClip;				// reference to the edit panel
	
	private var link_url:String;
	
	private var lock_flag:Boolean;				// states that user is updating, dont allow changing
  
	// ***********
	// constructor
	// ***********
	public function LinkPanelMC ()
	{
		mc_ref = this;
		panel_ref = null;
		link_url = "";
		
		build_button ();
		build_panel_mc ();
		
		close_panel_mc ();
	}
	
	// *************
	// open panel mc
	// *************
	public function open_panel_mc ():Void
	{
		lock_flag = true;
		
		mc_ref.panel_mc._visible = true;
		mc_ref.panel_mc.enabled = true;
		
		if (link_url == "")
		{
			link_url = "http://";
		}
		
		mc_ref.panel_mc.url_textinput.text = link_url;
	}
	
	// **************
	// close panel mc
	// **************
	public function close_panel_mc ():Void
	{
		lock_flag = false;
		
		mc_ref.panel_mc._visible = false;
		mc_ref.panel_mc.enabled = false;
	}
	
	// **************
	// build panel mc
	// **************
	public function build_panel_mc ():Void
	{
		// panel bg
		var temp_xml:XML;
		
		temp_xml = new XML ("<RectangleMC><x>-10</x><y>-10</y><width>300</width><height>40</height><corner>0</corner><line_style>1|0x666666|100</line_style><fill_color>0xFFFFFF</fill_color><alpha>100</alpha></RectangleMC>");
		
		mc_ref.panel_mc.attachMovie ("lib_shape_rectangle", "panel_bg", 0);
		mc_ref.panel_mc.panel_bg.set_data_xml (temp_xml.firstChild);
		
		// panel input
		mc_ref.panel_mc.createClassObject (mx.controls.TextInput, "url_textinput", 1, {_x:0, _y:0, _width:250, _height:20});
//		mc_ref.panel_mc.createClassObject (mx.controls.Button, "url_tick_button", 2, {_x:260, _y:0, _width:20, _height:20});
		mc_ref.panel_mc.attachMovie ("lib_button_mc", "url_tick_button", 2, {_x:260, _y:0});
		
		mc_ref.panel_mc.url_textinput.setStyle ("styleName", "textinput_style");
		
		mc_ref.panel_mc.url_tick_button.set_toggle_flag (false);
		mc_ref.panel_mc.url_tick_button.set_dimension (20, 20);
		mc_ref.panel_mc.url_tick_button.set_clip_mc ("lib_button_tick");
		mc_ref.panel_mc.url_tick_button.set_tooltip ("Accept");
		
		// setup tick button action
		mc_ref.panel_mc.url_tick_button ["class_ref"] = mc_ref;
		mc_ref.panel_mc.url_tick_button.onRelease = function ()
		{
			this.class_ref.link_url = this.class_ref.panel_mc.url_textinput.text;
			
			if (this.class_ref.panel_ref != null)
			{
				this.class_ref.panel_ref.link_call ();
			}
			
			this.class_ref.close_panel_mc ();
		}		
	}
	
	// ************
	// build button
	// ************
	public function build_button ():Void
	{
		mc_ref.attachMovie ("lib_button_mc", "link_button", 1, {_x:0, _y:0});
		
		mc_ref.link_button.set_toggle_flag (false);
		mc_ref.link_button.set_dimension (20, 20);
		mc_ref.link_button.set_clip_mc ("lib_button_link");
		mc_ref.link_button.set_tooltip ("Link");
		
		mc_ref.link_button ["class_ref"] = mc_ref;
		mc_ref.link_button.onRelease = function ()
		{
			if (this.class_ref.panel_mc._visible == true)
			{
				this.class_ref.close_panel_mc ();
			}
			else
			{
				this.class_ref.open_panel_mc ();
			}
		}
	}
		
	// ************
	// set link url
	// ************
	public function set_link_url (s:String):Void
	{
		link_url = s;
	}
	
	// ************
	// get link url
	// ************
	public function get_link_url ():String
	{
		return (link_url);
	}
	
	// *************
	// get lock flag
	// *************
	public function get_lock_flag ():Boolean
	{
		return (lock_flag);
	}
	
	// *************
	// set panel ref
	// *************
	// only used for textfield edit panel which requires dynamic update
	public function set_panel_ref (m:MovieClip):Void
	{
		panel_ref = m;
	}
}
