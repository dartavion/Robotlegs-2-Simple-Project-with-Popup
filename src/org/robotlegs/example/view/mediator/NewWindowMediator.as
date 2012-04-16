package org.robotlegs.example.view.mediator {
    import org.robotlegs.example.model.event.ExampleModelUpdate;
    import org.robotlegs.example.view.api.INewWindow;
    import org.robotlegs.example.view.events.GetSomeTextEvent;
    import org.robotlegs.example.view.events.OpenPopupEvent;

    import robotlegs.bender.bundles.mvcs.impl.Mediator;
	import robotlegs.bender.framework.logging.api.ILogger;

	public class NewWindowMediator extends Mediator{
        [Inject]
        public var view:INewWindow;

		[Inject]
		public var logger:ILogger;

        override public function initialize():void {
			logger.debug("initialize");
            addViewListener(GetSomeTextEvent.GET_SOME_TEXT, onGetSomeText, GetSomeTextEvent);
            addContextListener(ExampleModelUpdate.MODEL_UPDATED, handleModelUpdate, ExampleModelUpdate);
        }

        override public function destroy():void {
			logger.debug("destroy");
            super.destroy();
        }

        private function onGetSomeText(event:GetSomeTextEvent):void {
			logger.debug("We made it into the NewWindowMediator and are mediated!");
            dispatch(event);
        }

        private function handleModelUpdate(event:ExampleModelUpdate):void {
			logger.debug("We're have now received the update from the model.");
            view.helloMessage = event.model.answer;
        }
    }
}
