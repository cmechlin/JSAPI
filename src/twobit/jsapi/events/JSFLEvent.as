/*
* File: JSFLEvent.as 
* Description:
*   Library: Flash Actionscript 3.0 class written to assist in interfacing the JSFL (JSAPI) within flash used when creating swf panels for extending Flash
*   File: This is a custom event class to dispatch events to the flash tool panel (swf) whenever an event occurs in the JSFL environment.
* Version: 1.0
* Author: Curtis Mechling, cmechlin<at>gmail<dot>com
* Copyright: Copyright (c) Curtis Mechling 2023
* 
* License: BSD License?
* 
*/
package twobit.jsapi.events {
	import flash.events.Event;

	public class JSFLEvent extends Event
	{
		// Custom Events
		public static const DOCUMENT_NEW:String = "documentNew";
		public static const DOCUMENT_OPENED:String = "documentOpened";
		public static const DOCUMENT_CLOSED:String = "documentClosed";
		public static const DOCUMENT_CHANGED:String = "documentChanged";
		public static const MOUSE_MOVE:String = "mouseMove";
		public static const LAYER_CHANGED:String = "layerChanged";
		public static const TIMELINE_CHANGED:String = "timelineChanged";
		public static const FRAME_CHANGED:String = "frameChanged";
		public static const PRE_PUBLISH:String = "prePublish";
		public static const POST_PUBLISH:String = "postPublish";
		public static const DPI_CHANGED:String = "dpiChanged";		
		public static const SELECTION_CHANGED:String = "selectionChanged";

		protected var _success: Boolean;

		public function JSFLEvent( type: String, success: Boolean )
		{
			super( type, false, false );
			_success = success;
		}

		public function get success(): Boolean
		{
			return _success;
		}
		
		override public function clone():Event
		{
			return new ElementEvent( type, success );
		}
	}
}