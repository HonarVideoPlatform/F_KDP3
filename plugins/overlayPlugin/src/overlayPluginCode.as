package
{
	import com.kaltura.kdpfl.plugin.IPlugin;
	import com.kaltura.kdpfl.plugin.component.OverlayMC;
	import com.kaltura.kdpfl.plugin.component.OverlayMediator;
	
	import fl.core.UIComponent;
	
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IFacade;

	/**
	 * Overlay Plugin. The Plugin handles the appearance and removal of the overlay ad on the screen, according to data received from the 
	 * Vast plugin. It creates a sprite in a suitable size for the loaded image/swf and displays it at regular intervals. The ad is clickable if so configured in 
	 * the Vast XML, dispatches statistics both to the Kaltura Management Console and to the ad provider and all of its parameters are cofigurable.
	 */	
	public class overlayPluginCode extends UIComponent implements IPlugin
	{
		
		private var _swfUrls : Object;
		private var _displayDuration : Number;
		private var _overlayStartAt : Number;
		private var _overlayInterval : Number;
		private var _currentOverlay : Object;
		
//		public var overlay : OverlayMC;
		
		private var _overlayMediator : OverlayMediator;
		
		/**
		 * Constructor. 
		 */		
		public function overlayPluginCode()
		{
		}
		
	

		/**
		 * create and intialize the mediator and view component 
		 * @param facade 	KDP application facade
		 */		
		public function initializePlugin ( facade : IFacade ) : void
		{
				
			var overlayMc : OverlayMC = new OverlayMC();
			
			var overlayConfig : Object = generateAdConfig();
			
			_overlayMediator = new OverlayMediator(overlayConfig, null, overlayMc);
			
			addChild(overlayMc);
			
			facade.registerMediator(_overlayMediator);
			
		}
		
		private function generateAdConfig () : Object
		{
			var config : Object = {overlayInterval : _overlayInterval,
				overlayStartAt : _overlayStartAt,
				overlayDisplayDuration : _displayDuration,
				currentOverlayParams : _currentOverlay}
			return config;					   
		}
		
		/**
		 * Do nothing. 
		 * This is not a visual Plugin and it doesn't have a skin. 
		 * @param styleName
		 * @param setSkinSize
		 */			
		public function setSkin ( styleName : String , setSkinSize : Boolean = false ) : void {}
		
		/**
		 * @inheritDoc
		 */		
		override public function set height (value : Number) : void
		{
			this._height = value;
			_overlayMediator.updateBannerLocation(_width, _height);
			
		}
		
		
		
		/**
		 * @inheritDoc
		 */
		override public function set width (value : Number) : void
		{
			this._width = value;
			_overlayMediator.updateBannerLocation(_width, _height);
		}
		
		[Bindable]
		/**
		 * @private
		 */				
		public function set swfUrls (value : Object) : void
		{
			_swfUrls = value;
			_currentOverlay = _swfUrls[0];
			_overlayMediator.overlayConfig.currentOverlayParams = _currentOverlay;
			//In case of flashvars.autoPlay=true the doPlay notification will be disptched before the vast is loaded. 
			//In this case the start event is "saved" until the vast is loaded and the overlay ads are parsed. Then it is fired.
			_overlayMediator.fireStartEvent();
		}
		
		/**
		 * urls of swf files
		 */
		public function get swfUrls () : Object
		{
			return _swfUrls;
		}
		
		
		[Bindable]
		/**
		 * @private
		 */
		public function set displayDuration(value:Number):void
		{
			_displayDuration = value;
			_overlayMediator.overlayConfig.overlayDisplayDuration = _displayDuration;
		}
		
		/**
		 * time to display overlay
		 */		
		public function get displayDuration():Number
		{
			return _displayDuration;
		}

		[Bindable]
		/**
		 * @private
		 */
		public function set overlayStartAt(value:Number):void
		{
			_overlayStartAt = value;
			_overlayMediator.overlayConfig.overlayStartAt = _overlayStartAt;
		}
		
		/**
		 * the time at which to show the first overlay
		 */
		public function get overlayStartAt():Number
		{
			return _overlayStartAt;
		}

		[Bindable]
		/**
		 * @private
		 */
		public function set overlayInterval(value:Number):void
		{
			_overlayInterval = value;
			_overlayMediator.overlayConfig.overlayInterval = _overlayInterval;
		}
		
		/**
		 * time between overlay ads
		 */
		public function get overlayInterval():Number
		{
			return _overlayInterval;
		}


		

	}
}