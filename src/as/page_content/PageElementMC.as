// *******************// PageElementMC class// *******************class as.page_content.PageElementMC extends MovieClip{	// private variables	private var mc_ref:MovieClip;				// interface for the page element	// ***********	// constructor	// ***********	public function PageElementMC ()	{		mc_ref = this;		mc_ref.menu = new ContextMenu (_root.custom_context.menu_builder);	}		// *******************	// onrollover override	// *******************	private function onRollOver_event ():Void	{		_root.mc_filters.set_brightness_filter (mc_ref);		_root.tooltip_mc.set_content (mc_ref._name);	}	// ******************	// onrollout override	// ******************	private function onRollOut_event ():Void	{		_root.mc_filters.remove_filter (mc_ref);		_root.tooltip_mc.throw_away ();	}	// ****************	// onpress override	// ****************	private function onPress_event ():Void	{		_root.mc_filters.remove_filter (mc_ref);		_root.handler_mc.set_target_ref (mc_ref);		pull_handler ("first");		_root.handler_mc.frame_mc.onPress ();	}		// ******************	// onrelease override	// ******************	private function onRelease_event ():Void	{		_root.handler_mc.frame_mc.onRelease ();	}			// *****************	// broadcaster event	// *****************	public function broadcaster_event (o:Object):Void	{		if (o == true)		{			mc_ref.onRollOver = function ()			{				onRollOver_event ();			}						mc_ref.onRollOut = function ()			{				onRollOut_event ();			}						mc_ref.onPress = function ()			{				onPress_event ();			}						mc_ref.onRelease = function ()			{				onRelease_event ();			}		}		else		{			delete mc_ref.onRollOver;			delete mc_ref.onRollOut;			delete mc_ref.onPress;			delete mc_ref.onRelease;		}	}	// ***************	// pull edit panel	// ***************	private function pull_handler (s:String):Void	{		// to be defined by the extending elements	}		// ***************	// resize function	// ***************	public function resize_function (n:Number):Void	{		// calling to go		if (n == 1)		{			mc_ref.onMouseMove = function ()			{				resize_interval_function ();				// since the resize function depends on the handler position				// that is why handler mc chasing is necessary				pull_handler ("not first");			}		}		// calling to stop		else		{			delete mc_ref.onMouseMove;		}	}		// ************************	// resize interval function	// ************************	private function resize_interval_function ():Void	{		// to be defined in the extended objects	}	// ***************	// rotate function	// ***************	public function rotate_function (n:Number):Void	{		// calling to go		if (n == 1)		{			mc_ref.onMouseMove = function ()			{				var temp_rotation:Number = Math.round (_root.sys_func.get_mouse_degree (mc_ref._x, mc_ref._y) - 180);				rotate_interval_function (temp_rotation);			}		}		// calling to stop		else		{			delete mc_ref.onMouseMove;		}	}		// ************************	// rotate interval function	// ************************	private function rotate_interval_function (r:Number):Void	{		// to be defined in the extended objects	}			// ***************	// delete function	// ***************	public function delete_function ():Void	{		_root.page_mc.destroy_one (mc_ref);	}}