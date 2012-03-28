/**
 * Created by IntelliJ IDEA.
 * User:
 * Date: 2/21/12
 * Time: 2:04 PM
 * To change this template use File | Settings | File Templates.
 */
package org.robotlegs.example.base {
    import flash.events.Event;
    import flash.events.IEventDispatcher;

    public class BaseActor {
        [Inject]
        public var eventDispatcher:IEventDispatcher;

        protected function dispatch(e:Event):void {
            if (eventDispatcher.hasEventListener(e.type))
                eventDispatcher.dispatchEvent(e);
        }
    }
}
