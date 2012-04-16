package org.robotlegs.example.view.mediator {
    import flash.display.DisplayObject;

    import mx.core.FlexGlobals;

    import mx.managers.PopUpManager;

    import org.robotlegs.example.model.event.ExampleModelUpdate;
    import org.robotlegs.example.view.NewWindow;
    import org.robotlegs.example.view.api.IMainView;
    import org.robotlegs.example.view.events.GetSomeTextEvent;
    import org.robotlegs.example.view.events.OpenPopupEvent;

    import robotlegs.bender.bundles.mvcs.impl.Mediator;
    import robotlegs.bender.extensions.viewManager.api.IViewManager;
	import robotlegs.bender.framework.logging.api.ILogger;

	import spark.components.TitleWindow;


    public class MainViewMediator extends Mediator {

        [Inject]
        public var view:IMainView;

        [Inject]
        public var viewManager:IViewManager;

		[Inject]
		public var logger:ILogger;

        public function MainViewMediator() {
            super();
        }

        override public function initialize():void {
			logger.debug("initialize");
            addViewListener(GetSomeTextEvent.GET_SOME_TEXT, handleGetText, GetSomeTextEvent);
            addContextListener(ExampleModelUpdate.MODEL_UPDATED, handleModelUpdate, ExampleModelUpdate)
            addViewListener(OpenPopupEvent.OPEN, onOpenPopup, OpenPopupEvent);
        }

		override public function destroy():void
		{
			logger.debug("destroy");
			super.destroy();
		}

		private function onOpenPopup(event:OpenPopupEvent):void {
            var newReportWindow:TitleWindow = new NewWindow();
            viewManager.addContainer(newReportWindow);
            PopUpManager.addPopUp(newReportWindow, FlexGlobals.topLevelApplication as DisplayObject);
            PopUpManager.centerPopUp(newReportWindow);
        }

        private function handleGetText(event:GetSomeTextEvent):void {
            logger.debug("2. Redundant dispatch it seems::::: ");
            dispatch(event);
        }

        private function handleModelUpdate(event:ExampleModelUpdate):void {
			logger.debug("8. Listen to the Context for changes in the event map. " +
                    "Then lets catch the answer in the Main View Mediator and pass it to the Main View::::: " + event.model.answer);
            view.returnText = event.model.answer;
        }
    }
}
