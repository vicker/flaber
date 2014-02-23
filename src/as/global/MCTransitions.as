// *******************
// MCTransitions class
// *******************
class as.global.MCTransitions
{
	// private variables
	private var transition_style:String;
	private var transition_param:Object;
	private var transition_manager:mx.transitions.TransitionManager;
	
	private var mc_ref:MovieClip;
	
	
	// ***********
	// constructor
	// ***********
	public function MCTransitions ()
	{
		// actually nothing can be done right now until the references are stated
		transition_param = new Object ();
	}
	
	// *************************
	// setup transition listener
	// *************************
	public function setup_transition_listener ():Void
	{
		var transition_listener:Object;
		transition_listener = new Object;
		transition_listener ["class_ref"] = this;
		
		transition_listener.allTransitionsOutDone = function ():Void
		{
			this.class_ref.mc_ref.transition_out_action ();		
			this.class_ref.start_transition (0);
		}
		
		transition_manager.addEventListener ("allTransitionsOutDone", transition_listener);
	}
	
	// ****************
	// start transition
	// ********************
	public function start_transition (d:Number):Void
	{
		// 0 for in while 1 for out
		transition_param.direction = d;
		transition_manager.startTransition (transition_param);
	}
	
	// *****************
	// set caller mc ref
	// *****************
	public function set_mc_ref (m:MovieClip):Void
	{
		mc_ref = m;
	}
	
	// ******************
	// set transition ref
	// ******************
	public function set_transition_ref (m:MovieClip):Void
	{
		transition_manager = new mx.transitions.TransitionManager (m);
		
		setup_transition_listener ();
	}

	// ********************
	// set transition style
	// ********************
	public function set_transition_style (s:String):Void
	{
		transition_style = s;
		
		switch (s)
		{
			// Iris
			case "iris":
			{
				transition_param.startPoint = 5;
				transition_param.duration = 1.5;
				transition_param.type = mx.transitions.Iris;
				transition_param.shape = "CIRCLE";
				transition_param.easing = mx.transitions.easing.Bounce.easeOut;
				
				break;
			}
			
			// Fade
			case "fade":
			{
				transition_param.startPoint = 1;
				transition_param.duration = 1;
				transition_param.type = mx.transitions.Fade;
				transition_param.easing = mx.transitions.easing.Strong.easeInOut;
				
				break;
			}
			
			// Fly
			case "fly":
			{
				transition_param.startPoint = 4;
				transition_param.duration = 1;
				transition_param.type = mx.transitions.Fly;
				transition_param.easing = mx.transitions.easing.Elastic.easeOut;
				
				break;
			}
			
			// PixelDissolve
			case "pixel":
			{
				transition_param.startPoint = 1;
				transition_param.duration = 1.5;
				transition_param.type = mx.transitions.PixelDissolve;
				transition_param.xSections = Math.round (Stage.width / 30);
				transition_param.ySections = Math.round (Stage.height / 30);
				transition_param.easing = mx.transitions.easing.Strong.easeInOut;
				
				break;
			}
			
			// Wipe
			case "wipe":
			{
				transition_param.startPoint = 2;
				transition_param.duration = 1;
				transition_param.type = mx.transitions.Wipe;
				transition_param.easing = mx.transitions.easing.Strong.easeInOut;
				
				break;
			}
		}
	}
	
	// ********************
	// get transition style
	// ********************
	public function get_transition_style ():String
	{
		return (transition_style);
	}
}