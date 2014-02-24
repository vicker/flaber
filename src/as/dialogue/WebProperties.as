// *******************
// WebProperties class
// *******************
class as.dialogue.WebProperties extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip;					// reference to the movie clip
	private var navigation_added:Boolean;
	
	// ***********
	// constructor
	// ***********
	public function WebProperties ()
	{
		mc_ref = this;
		navigation_added = null;
		
		setup_component_object ();
	}
	
	// **********************
	// setup component object
	// **********************
	public function setup_component_object ():Void
	{
		mc_ref.createClassObject (mx.controls.ComboBox, "index_combobox", 1, {_x:30, _y:35, _width:150, _height:20});
		mc_ref.createClassObject (mx.controls.CheckBox, "navigation_checkbox", 2, {_x:30, _y:80, _width:120, _height:20});
		mc_ref.createClassObject (mx.controls.TextInput, "navigation_textinput", 3, {_x:30, _y:105, _width:150, _height:20});
		mc_ref.createClassObject (mx.controls.CheckBox, "transition_checkbox", 4, {_x:30, _y:150, _width:120, _height:20});
		mc_ref.createClassObject (mx.controls.ComboBox, "transition_combobox", 5, {_x:30, _y:175, _width:150, _height:20});
		
		setup_component_style ();
		
		setup_index_combobox ();
		setup_navigation_checkbox ();
		setup_navigation_textinput ();
		setup_transition_checkbox ();
		setup_transition_combobox ();
		setup_ok_button ();
		setup_cancel_button ();
	}
	
	// *********************
	// setup component style
	// *********************
	public function setup_component_style ():Void
	{
		mc_ref.index_label.setStyle ("styleName", "label_style");
		
		mc_ref.navigation_textinput.setStyle ("styleName", "textinput_style");
		
		mc_ref.index_combobox.setStyle ("styleName", "combobox_style");
		mc_ref.transition_combobox.setStyle ("styleName", "combobox_style");
		
		mc_ref.navigation_checkbox.setStyle ("styleName", "checkbox_style");
		mc_ref.transition_checkbox.setStyle ("styleName", "checkbox_style");
	}
	
	// ********************
	// setup index combobox
	// ********************
	public function setup_index_combobox ():Void
	{
		var temp_array:Array;
		
		temp_array = _root.flaber.get_page_dir_array ();
		
		for (var i = 0; i < temp_array.length; i++)
		{
			mc_ref.index_combobox.addItem ({label:temp_array [i], data:temp_array [i]});
		}
		
		_root.sys_func.combobox_select_item (mc_ref.index_combobox, _root.flaber.get_index_page ());
	}
	
	// *************************
	// setup navigation checkbox
	// *************************
	public function setup_navigation_checkbox ():Void
	{
		mc_ref.navigation_checkbox.label = " Navigation Menu"
		
		// current status
		if (_root.navigation_menu != null)
		{
			mc_ref.navigation_checkbox.selected = true;
			navigation_added = false;
		}
		
		// listener
		var temp_listener:Object;
		
		temp_listener = new Object ();
		temp_listener ["class_ref"] = mc_ref;
		
		temp_listener.click = function ()
		{
			this.class_ref.navigation_textinput.enabled = this.class_ref.navigation_checkbox.selected;
		}
		
		mc_ref.navigation_checkbox.addEventListener ("click", temp_listener);
	}

	// **************************
	// setup navigation textinput
	// **************************
	public function setup_navigation_textinput ():Void
	{
		// current status
		if (_root.navigation_menu != null)
		{
			mc_ref.navigation_textinput.text = _root.navigation_menu.get_loaded_file ();
		}
		else
		{
			mc_ref.navigation_textinput.enabled = false;
		}
	}
	
	// *************************
	// setup transition checkbox
	// *************************
	public function setup_transition_checkbox ():Void
	{
		mc_ref.transition_checkbox.label = " Transition Effect"
		
		// current status
		if (_root.mc_transitions != null)
		{
			mc_ref.transition_checkbox.selected = true;
		}
		
		// listener
		var temp_listener:Object;
		
		temp_listener = new Object ();
		temp_listener ["class_ref"] = mc_ref;
		
		temp_listener.click = function ()
		{
			this.class_ref.transition_combobox.enabled = this.class_ref.transition_checkbox.selected;
		}
		
		mc_ref.transition_checkbox.addEventListener ("click", temp_listener);
	}

	// *************************
	// setup transition combobox
	// *************************
	public function setup_transition_combobox ():Void
	{
		var name_array:Array;
		var value_array:Array;
		
		name_array = new Array ("Wipe", "Pixel Dissolve", "Fly", "Fade", "Iris");
		value_array = new Array ("wipe", "pixel", "fly", "fade", "iris");
		
		for (var i in name_array)
		{
			mc_ref.transition_combobox.addItem ({label:name_array [i], data:value_array [i]});
		}
		
		// current status
		if (_root.mc_transitions != null)
		{
			_root.sys_func.combobox_select_item (mc_ref.transition_combobox, _root.mc_transitions.get_transition_style ());
		}
		else
		{
			mc_ref.transition_combobox.enabled = false;
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
			// immediate update to environment
			
			// index page
			_root.flaber.set_index_page (this.class_ref.index_combobox.value);
			
			// navigation menu
			if (this.class_ref.navigation_checkbox.selected == true)
			{
				// if the navigation menu is not in there originally
				// then we have to build back the navigation menu before doing anything
				if (this.class_ref.navigation_added == null)
				{
					_root.attachMovie ("lib_navigation_menu", "navigation_menu", 2, {_x:20, _y:20});
					_root.mode_broadcaster.add_observer (_root.navigation_menu);
					_root.save_broadcaster.add_observer (_root.navigation_menu);
				}
				
				var page_xml:XML;
				
				page_xml = new XML ();
				page_xml.ignoreWhite = true;
				page_xml ["target_file"] = this.class_ref.navigation_textinput.text;
				
				page_xml.sendAndLoad ("function/check_file_exists.php?target_file=" + this.class_ref.navigation_textinput.text, page_xml);
				
				page_xml.onLoad = function (b:Boolean)
				{
					if (b)
					{
						// if the file already exists
						// which means the original file should be used
						if (this.firstChild.nodeName == "exists")
						{
							_root.status_mc.add_message ("Updating navigation menu...", "normal");
							_root.navigation_menu.load_root_xml (this.target_file);
						}
						
						// if the file not exists
						// which means a dummy navigation menu is necessary
						else if (this.firstChild.nodeName == "not_exists")
						{
							_root.status_mc.add_message ("Creating navigation menu...", "normal");
							
							var out_xml:XML;
							var return_xml:XML;
							
							out_xml = new XML ("<?xml version='1.0'?><NavigationMenu xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns='http://www.w3schools.com'><config><x>20</x><y>20</y><menu_style><name>lib_navigation_item_3</name></menu_style><text_format><display>block</display><underline>false</underline><italic>false</italic><bold>true</bold><color>0</color><size>10</size><font>Verdana</font></text_format></config><data><NavigationItemMC style='global'><x>20</x><y>20</y><text>Dummy 1</text></NavigationItemMC><NavigationItemMC style='global'><x>130</x><y>20</y><text>Dummy 2</text></NavigationItemMC></data></NavigationMenu>");
							out_xml.contentType = "text/xml";
							
							return_xml = new XML ();
							return_xml ["target_file"] = this.target_file;
							return_xml.onLoad = function (b: Boolean)
							{
								if (b)
								{
									_root.status_mc.add_message (this.toString (), "");									
									_root.navigation_menu.load_root_xml (this.target_file);
								}
							}
							
							out_xml.sendAndLoad ("function/update_xml.php?target_file=" + this.target_file, return_xml);
						}
						
						_root.navigation_menu.broadcaster_event (_root.menu_mc.get_edit_mode ());
					}
				}
			}
			else
			{
				_root.navigation_menu.removeMovieClip ();
			}
			
			// transition
			if (this.class_ref.transition_checkbox.selected == true)
			{
				_root.mc_transitions = new as.global.MCTransitions ();
				_root.mc_transitions.set_transition_ref (_root.page_mc);
				_root.mc_transitions.set_transition_style (this.class_ref.transition_combobox.value);
			}
			else
			{
				_root.mc_transitions = null;
			}
			
			
			// writing XML
			_root.status_mc.add_message ("Saving web properties...", "normal");
			
			var out_string:String;
			
			var out_xml:XML;
			var return_xml:XML;
			
			var root_node:XMLNode;
			var temp_node:XMLNode;
			var temp_node_2:XMLNode;
			
			out_string = "<?xml version='1.0'?>";
			
			out_xml = new XML ();
			
			root_node = out_xml.createElement ("Flaber");
			root_node.attributes ["xmlns"] = "http://www.w3schools.com";
			root_node.attributes ["xmlns:xsi"] ="http://www.w3.org/2001/XMLSchema-instance";
			out_xml.appendChild (root_node);
			
			temp_node = out_xml.createElement ("index_page");
			temp_node_2 = out_xml.createTextNode (this.class_ref.index_combobox.value);
			temp_node.appendChild (temp_node_2);
			root_node.appendChild (temp_node);
			
			if (this.class_ref.navigation_checkbox.selected == true)
			{
				temp_node = out_xml.createElement ("NavigationMenu");
				temp_node_2 = out_xml.createTextNode (this.class_ref.navigation_textinput.text);
				temp_node.appendChild (temp_node_2);
				root_node.appendChild (temp_node);
			}
			
			if (this.class_ref.transition_checkbox.selected == true)
			{
				temp_node = out_xml.createElement ("MCTransitions");
				temp_node_2 = out_xml.createTextNode (this.class_ref.transition_combobox.value);
				temp_node.appendChild (temp_node_2);
				root_node.appendChild (temp_node);
			}
			
			return_xml = new XML ();
			return_xml.onLoad = function (b: Boolean)
			{
				if (b)
				{
					_root.status_mc.add_message (return_xml.toString (), "");
				}
			}
			
			// append those string contents to the xml and rebuild it
			out_string = out_string + out_xml.toString ();
			out_xml = new XML (out_string);
			out_xml.contentType = "text/xml";
			
			out_xml.sendAndLoad ("function/update_xml.php?target_file=Flaber.xml", return_xml);
			
			this.class_ref._parent.close_window ();
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