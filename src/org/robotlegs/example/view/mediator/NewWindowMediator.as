/**
 * Created by IntelliJ IDEA.
 * User: rranke
 * Date: 3/28/12
 * Time: 1:31 PM
 * To change this template use File | Settings | File Templates.
 */
package org.robotlegs.example.view.mediator {
    import org.robotlegs.example.model.event.ExampleModelUpdate;
    import org.robotlegs.example.view.api.INewWindow;
    import org.robotlegs.example.view.events.GetSomeTextEvent;
    import org.robotlegs.example.view.events.OpenPopupEvent;

    import robotlegs.bender.bundles.mvcs.impl.Mediator;

    public class NewWindowMediator extends Mediator{
        [Inject]
        public var view:INewWindow;

        override public function initialize():void {
            addViewListener(GetSomeTextEvent.GET_SOME_TEXT, onGetSomeText, GetSomeTextEvent);
            addContextListener(ExampleModelUpdate.MODEL_UPDATED, handleModelUpdate, ExampleModelUpdate);
        }

        override public function destroy():void {
            removeViewListener(GetSomeTextEvent.GET_SOME_TEXT, onGetSomeText, GetSomeTextEvent);
        }

        private function onGetSomeText(event:GetSomeTextEvent):void {
            trace("We made it into the NewWindowMediator and are mediated!");
            dispatch(event);
        }

        private function handleModelUpdate(event:ExampleModelUpdate):void {
            trace("We're have now received the update from the model.");
            view.helloMessage = event.model.answer;
        }
    }
}
