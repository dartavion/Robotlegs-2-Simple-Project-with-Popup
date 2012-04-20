package org.robotlegs.example.service {
    import com.adobe.serialization.json.JSON;

    import org.robotlegs.example.base.BaseActor;
    import org.robotlegs.example.model.ExampleModel;

    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;

	import robotlegs.bender.framework.logging.api.ILogger;

	public class ExampleService extends BaseActor implements IExampleService{
        private var urlLoader:URLLoader;

        [Inject]
        public var exampleModel:ExampleModel;

		[Inject]
		public var logger:ILogger;

        public function ExampleService() {
            super();
        }

        public function load():void {
            var urlRequest:URLRequest = new URLRequest("./assets/json/example.json");
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE, onLoadTreeComplete);
            urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onLoadTreeIOError);
            urlLoader.load(urlRequest);

        }

        private function onLoadTreeComplete(event:Event):void {
            if (urlLoader.data) {
				logger.debug("4. We're now in the service onComplete::::::::");
                // this import collides with the Flex SDK's implementation of JSON support for AIR apps
                // we're using as3corelib to support json
                var jsonObject:Object = com.adobe.serialization.json.JSON.decode(urlLoader.data);
                exampleModel.createMessage(jsonObject);
            }
        }

        private function onLoadTreeIOError(event:IOErrorEvent):void {
			logger.error("ERROR")
        }

    }
}
