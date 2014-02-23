// ****************
// AdminLogin class
// ****************
class as.dialogue.AdminLogin extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip;					// reference to the movie clip
	
	// ***********
	// constructor
	// ***********
	public function AdminLogin ()
	{
		mc_ref = this;
		
		setup_component_object ();
		setup_component_style ();
		
		build_enter_listener ();
	}
	
	// ***********************
	// build up enter listener
	// ***********************
	public function build_enter_listener ():Void
	{
		// is kinder funny here... textinput.enter will not work until the user
		// try to click on the window mc... which is really not preferable
		// so key listener is used instead although it is not the best approach
		
		// reference http://www.macromedia.com/cfusion/knowledgebase/index.cfm?id=tn_15586
		
		var temp_listener:Object;
		
		temp_listener = new Object ();
		temp_listener ["class_ref"] = mc_ref;
		temp_listener.onKeyDown = function ()
		{
			if (Key.getCode () == Key.ENTER)
			{
				this.class_ref.login ();
				Key.removeListener (this);
			}
		}
		
		Key.addListener (temp_listener);
	}
	
	
	// **********************
	// setup component object
	// **********************
	public function setup_component_object ():Void
	{
		mc_ref.createClassObject (mx.controls.TextInput, "password_textinput", 1, {_x:35, _y:35, _width:125, _height:20});
		
		setup_password_textinput ();
		
		setup_ok_button ();
		setup_cancel_button ();
	}
	
	// *********************
	// setup component style
	// *********************
	public function setup_component_style ():Void
	{
		mc_ref.instruction_label.setStyle ("styleName", "label_style");
		
		mc_ref.password_textinput.setStyle ("styleName", "textinput_style");
	}
	
	// ***************
	// data validation
	// ***************
	public function data_validation ():Boolean
	{
		return true;
	}

	// ************************
	// setup password textinput
	// ************************
	public function setup_password_textinput ():Void
	{
		mc_ref.password_textinput.password = true;
		
		Selection.setFocus (mc_ref.password_textinput.label);
	}
	
	// *****
	// login
	// *****
	public function login ():Void
	{
		if (data_validation () == true)
		{		
			var img_xml:XML;
			
			img_xml = new XML ();
			img_xml.ignoreWhite = true;
			img_xml ["class_ref"] = mc_ref;
			img_xml.sendAndLoad ("http://www.flysforum.net/vicatfyp/release/1_0/function/admin_login.php?password=" + mc_ref.password_textinput.text, img_xml);
			
			img_xml.onLoad = function (b:Boolean)
			{
				if (b)
				{
					// if the data retrieved correctly
					if (this.firstChild.nodeName == "login")
					{
						_root.menu_mc.show_menu ();
						this.class_ref._parent.close_window ();
					}
					// if have error
					else
					{
						_root.status_mc.add_message (this.toString (), "");
					}
				}
			}
		}
	}
	
	// ***************
	// setup ok button
	// ***************
	public function setup_ok_button ():Void
	{
		mc_ref.ok_button ["class_ref"] = mc_ref;
		mc_ref.ok_button.onRelease = function ()
		{
			this.class_ref.login ();
		}
	}
	
	// *******************
	// setup cancel button
	// *******************
	public function setup_cancel_button ():Void
	{
		mc_ref.cancel_button ["class_ref"] = mc_ref;
		mc_ref.cancel_button.onRelease = function ()
		{
			this.class_ref._parent.close_window ();
		}
	}
}