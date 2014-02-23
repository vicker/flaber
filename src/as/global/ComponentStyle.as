// ********************
// ComponentStyle class
// ********************
class as.global.ComponentStyle
{
	// private variables
	private var label_style:Object;
	private var textinput_style:Object;
	private var combobox_style:Object;
	private var checkbox_style:Object;
	private var list_style:Object;
	private var radiobutton_style:Object;
	private var button_style:Object;
	
	// ***********
	// constructor
	// ***********
	public function ComponentStyle ()
	{
		setup_label_style ();
		setup_textinput_style ();
		setup_combobox_style ();
		setup_checkbox_style ();
		setup_list_style ();
		setup_radiobutton_style ();
		setup_button_style ();
	}
	
	// *****************
	// setup label style
	// *****************
	public function setup_label_style ():Void
	{
		label_style = new mx.styles.CSSStyleDeclaration ();
		
		_global.styles.label_style = label_style;
		
		label_style.setStyle ("color", 0x666666);
		label_style.setStyle ("fontFamily", "_sans");
		label_style.setStyle ("fontSize", 11);
		label_style.setStyle ("fontWeight", "bold");
	}
	
	// *********************
	// setup textinput style
	// *********************
	public function setup_textinput_style ():Void
	{
		textinput_style = new mx.styles.CSSStyleDeclaration ();
		
		_global.styles.textinput_style = textinput_style;
		
		textinput_style.setStyle ("fontFamily", "_sans");
		textinput_style.setStyle ("fontSize", 11);
	}
	
	// ********************
	// setup combobox style
	// ********************
	public function setup_combobox_style ():Void
	{
		combobox_style = new mx.styles.CSSStyleDeclaration ();
		
		_global.styles.combobox_style = combobox_style;
		
		combobox_style.setStyle ("fontFamily", "_sans");
		combobox_style.setStyle ("fontSize", 11);
	}

	// ********************
	// setup checkbox style
	// ********************
	public function setup_checkbox_style ():Void
	{
		checkbox_style = new mx.styles.CSSStyleDeclaration ();
		
		_global.styles.checkbox_style = checkbox_style;
		
		checkbox_style.setStyle ("color", 0x666666);
		checkbox_style.setStyle ("fontFamily", "_sans");
		checkbox_style.setStyle ("fontSize", 11);
		checkbox_style.setStyle ("fontWeight", "bold");
	}
	
	// ****************
	// setup list style
	// ****************
	public function setup_list_style ():Void
	{
		list_style = new mx.styles.CSSStyleDeclaration ();
		
		_global.styles.list_style = list_style;
		
		list_style.setStyle ("color", 0x666666);
		list_style.setStyle ("fontFamily", "_sans");
		list_style.setStyle ("fontSize", 11);
	}
	
	// ***********************
	// setup radiobutton style
	// ***********************
	public function setup_radiobutton_style ():Void
	{
		radiobutton_style = new mx.styles.CSSStyleDeclaration ();
		
		_global.styles.radiobutton_style = radiobutton_style;
		
		radiobutton_style.setStyle ("color", 0x666666);
		radiobutton_style.setStyle ("fontFamily", "_sans");
		radiobutton_style.setStyle ("fontSize", 11);
		radiobutton_style.setStyle ("fontWeight", "bold");
	}
	
	// ******************
	// setup button style
	// ******************
	public function setup_button_style ():Void
	{
		button_style = new mx.styles.CSSStyleDeclaration ();
		
		_global.styles.button_style = button_style;
		
		button_style.setStyle ("color", 0x666666);
		button_style.setStyle ("fontFamily", "_sans");
		button_style.setStyle ("fontSize", 11);
		button_style.setStyle ("fontWeight", "bold");
	}
}