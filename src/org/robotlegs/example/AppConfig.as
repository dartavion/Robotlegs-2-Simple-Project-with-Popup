/**
 * Created by IntelliJ IDEA.
 * User:
 * Date: 2/21/12
 * Time: 1:36 PM
 * To change this template use File | Settings | File Templates.
 */
package org.robotlegs.example {
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;

    import org.as3commons.logging.level.DEBUG;

    import org.hamcrest.object.instanceOf;

    import org.robotlegs.example.controller.GetSomeTextCommand;
    import org.robotlegs.example.model.ExampleModel;
    import org.robotlegs.example.service.ExampleService;
    import org.robotlegs.example.service.IExampleService;
    import org.robotlegs.example.view.MainView;
    import org.robotlegs.example.view.api.INewWindow;
    import org.robotlegs.example.view.mediator.MainViewMediator;
    import org.robotlegs.example.view.api.IMainView;
    import org.robotlegs.example.view.events.GetSomeTextEvent;
    import org.robotlegs.example.view.mediator.NewWindowMediator;

    import org.swiftsuspenders.Injector;

    import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
    import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
    import robotlegs.bender.framework.context.api.IContext;
    import robotlegs.bender.framework.context.api.IContextExtension;

    import spark.components.Application;

    use namespace DEBUG;

    public class AppConfig implements IContextExtension{
        private var injector : Injector;
        private var mediatorMap:IMediatorMap;
        private var commandMap:IEventCommandMap;

        private var _context:IContext;


        public function extend(context:IContext):void {
            _context = context;
            context.logLevel = DEBUG;
            context.addConfigHandler(instanceOf(DisplayObject), handleContextView);
        }

        private function handleContextView(contextView:DisplayObjectContainer):void {

            injector = _context.injector;
            mediatorMap = injector.getInstance(IMediatorMap);
            commandMap = injector.getInstance(IEventCommandMap);

            // View
            mediatorMap.mapView(IMainView).toMediator(MainViewMediator);
            mediatorMap.mapView(INewWindow).toMediator(NewWindowMediator);

            // Model
            injector.map(ExampleModel);

            // service
            injector.map(IExampleService).toSingleton(ExampleService);

            // controller
            commandMap.map(GetSomeTextEvent.GET_SOME_TEXT, GetSomeTextEvent).toCommand(GetSomeTextCommand);

            const main:MainView = new MainView();
            main.percentWidth = 100;
            main.percentHeight = 100;

            Application(contextView).addElement(main);
        }
    }
}
