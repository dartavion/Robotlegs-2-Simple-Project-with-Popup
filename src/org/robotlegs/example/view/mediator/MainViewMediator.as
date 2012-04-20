/**
 * Created by IntelliJ IDEA.
 * User:
 * Date: 2/21/12
 * Time: 2:19 PM
 * To change this template use File | Settings | File Templates.
 */
package org.robotlegs.example.view.mediator {
    import flash.display.DisplayObject;

    import mx.core.FlexGlobals;
    import mx.managers.PopUpManager;

    import org.robotlegs.example.model.event.ExampleModelUpdate;
    import org.robotlegs.example.view.NewWindow;
    import org.robotlegs.example.view.api.IMainView;
    import org.robotlegs.example.view.events.GetSomeTextEvent;
    import org.robotlegs.example.view.events.OpenPopupEvent;

    import robotlegs.bender.bundles.mvcs.Mediator;
    import robotlegs.bender.extensions.viewManager.api.IViewManager;

    import spark.components.TitleWindow;

    public class MainViewMediator extends Mediator {

        [Inject]
        public var view:IMainView;

        [Inject]
        public var viewManager:IViewManager;

        public function MainViewMediator() {
            super();
        }

        override public function initialize():void {
            addViewListener(GetSomeTextEvent.GET_SOME_TEXT, handleGetText, GetSomeTextEvent);
            addContextListener(ExampleModelUpdate.MODEL_UPDATED, handleModelUpdate, ExampleModelUpdate);
            addViewListener(OpenPopupEvent.OPEN, onOpenPopup, OpenPopupEvent);
        }

        private function handleGetText(event:GetSomeTextEvent):void {
            trace("2. Dispatch::::: ");
            dispatch(event);
        }

        private function onOpenPopup(event:OpenPopupEvent):void {
            var newReportWindow:TitleWindow = new NewWindow();
            viewManager.addContainer(newReportWindow);

            //context.addConfigHandler(instanceOf(DisplayObject), handleContextView);

            PopUpManager.addPopUp(newReportWindow, FlexGlobals.topLevelApplication as DisplayObject);
            PopUpManager.centerPopUp(newReportWindow);
        }

        private function handleModelUpdate(event:ExampleModelUpdate):void {
            trace("8. Listen to the Context for changes in the event map. " +
                    "Then lets catch the answer in the Main View Mediator and pass it to the Main View::::: " + event.model.answer);
            view.returnText = event.model.answer;
        }

        override public function destroy():void {
            removeViewListener(GetSomeTextEvent.GET_SOME_TEXT, handleGetText, GetSomeTextEvent);
            removeContextListener(ExampleModelUpdate.MODEL_UPDATED, handleModelUpdate, ExampleModelUpdate);
            removeViewListener(OpenPopupEvent.OPEN, onOpenPopup, OpenPopupEvent);
        }
    }
}
