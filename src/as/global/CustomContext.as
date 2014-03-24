// *******************
// CustomContext class
// *******************
class as.global.CustomContext
{
	private var admin_login_item:ContextMenuItem;
	private var properties_item:ContextMenuItem;
	private var about_item:ContextMenuItem;

	// ***********
	// constructor
	// ***********
	public function CustomContext ()
	{
		setup_menu_item ();
	}

	// ************
	// menu builder
	// ************
	// macromedia flash 8 customizingcontextmenu example
	public function menu_builder (o, m)
	{
		// menu reset
		m.customItems = [];
		m.hideBuiltInItems ();

		if (_root.menu_mc._visible != true)
		{
			m.customItems.push (_root.custom_context.get_menu_item ("admin_login_item"));
		}
		
		// if the object is page element, try to make the handler attaching it first before proceed
		if (o instanceof as.page_content.PageElementMC)
		{
			o.onPress ();
			o = _root.handler_mc;
		}
		
		// if the object is a handler, it means some page element is highlighted, push the element menu items
		if (o instanceof as.interface_element.ElementHandlerMC)
		{
			if (_root.menu_mc.get_edit_mode () == true)
			{
				m.customItems.push (_root.custom_context.get_menu_item ("properties_item"));
			}
		}
		
		m.customItems.push (_root.custom_context.get_menu_item ("about_item"));
	}
	
	// ***************
	// setup menu item
	// ***************
	private function setup_menu_item ():Void
	{
		admin_login_item = new ContextMenuItem ("Admin Login", menu_handler);
		properties_item = new ContextMenuItem ("Element Properties", menu_handler);
		about_item = new ContextMenuItem ("About FLABER", menu_handler);
	}

	// *************
	// get menu item
	// *************
	public function get_menu_item (s:String):ContextMenuItem
	{
		return (this [s]);
	}
	
	// ************
	// menu handler
	// ************
	private function menu_handler (o:Object, i:ContextMenuItem):Void
	{
		// handler fixer... fix the object o back to the handler target...
		if (o instanceof as.interface_element.ElementHandlerMC)
		{
			o = o.target_ref;
		}
	
		switch (i.caption)
		{
			case "Admin Login":
			{
				_root.flaber.pop_admin_login ();
				break;
			}
			
			case "Element Properties":
			{
				o.properties_function ();
				break;
			}
			
			case "About FLABER":
			{
				_root.menu_mc.about_flaber ();
				break;
			}
		}
	}
	
}
