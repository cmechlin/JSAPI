/*
* File: JSAPI.as 
* Description:
*   Library: Flash Actionscript 3.0 class written to assist in interfacing the JSFL (JSAPI) within flash used when creating swf panels for extending Flash
*   File: This is a custom that exposes all of the interface to the JSFL environment to the flash panel (swf). This is not neccesary, but if was always a PitA to me to
*		write these manually.
* Version: 1.0
* Author: Curtis Mechling, cmechlin<at>gmail<dot>com
* Copyright: Copyright (c) Curtis Mechling 2023
* 
* License: BSD License?
* 
*/
package twobit.jsapi {
	
	import Object;
	import adobe.utils.MMExecute;
	import flash.external.ExternalInterface;
	import flash.events.EventDispatcher;
	
	public class JSAPI {

		private static var _dispatcher:EventDispatcher = new EventDispatcher();
		
		public function JSAPI() {
			// Constructor isn't needed at the moment because everything is currently static
		}
		
		// This method wires up the events inside of the JSFL to custom events for this class
		// See JSFLEvent.as for all of the availabe events
		// TODO: currently the swf panel name is hard coded to "Panel". this needs to be changed to be dynamic
		public static function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void {
			_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
			ExternalInterface.addCallback("triggerEvent", eventTriggered);
			var jsfl:String = "";
			jsfl += "	fl.addEventListener('" + String(type) + "', function (evt){";
			jsfl += "		for(var i = 0; i < fl.swfPanels.length; i ++){";
			jsfl += "			if(fl.swfPanels[i].name == 'Panel'){";
			jsfl += "				fl.swfPanels[i].call('triggerEvent', '" + String(type) + "');";
			jsfl += "				break;";
			jsfl += "			}";
			jsfl += "		}";
			jsfl += "	});";
			var evtID:int = int(MMExecute(jsfl));
		}
		
        public static function dispatchEvent(event:Event):Boolean {
            return _dispatcher.dispatchEvent(event);
        }
        public static function hasEventListener(type:String):Boolean {
            return _dispatcher.hasEventListener(type);
        }
        public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
            _dispatcher.removeEventListener(type, listener, useCapture);
        }
        public static function willTrigger(type:String):Boolean {
            return _dispatcher.willTrigger(type);
        }
		
		private static function eventTriggered(type):void{
			try{
				dispatchEvent(new Event(type));
			} catch(e:Error){
				tr(e);
			}
		}
		
		// JSFL Interface Methods

		// this is a trace helper function 
		public static function tr(... args):void{
			trace(args); // this trace will not work when running as a flash tool panel
			MMExecute("fl.trace('" + args + "');");
		}
		
		// you could go crazy with the following methods and expose everything in the JSFL API, but lets not. Just add whats useful
		public static function getDocumentDom():Object{
			return Object(MMExecute("fl.getDocumentDom;"));
		}
		
		public static function getSelectionLength():int{
			return int(MMExecute("fl.getDocumentDOM().selection.length;"));
		}
		
		public static function getDocumentName():String{
			return String(MMExecute("fl.getDocumentDOM().name;"));
		}
		
		public static function getSelectionName():String{
			return String(MMExecute("fl.getDocumentDOM().selection[0].name;"));
		}
	}
	
}
