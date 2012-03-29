/**
 * Created by IntelliJ IDEA.
 * User:
 * Date: 2/21/12
 * Time: 1:36 PM
 * To change this template use File | Settings | File Templates.
 */
package org.robotlegs.example
{
	import flash.display.DisplayObjectContainer;
	import org.robotlegs.example.controller.GetSomeTextCommand;
	import org.robotlegs.example.model.ExampleModel;
	import org.robotlegs.example.service.ExampleService;
	import org.robotlegs.example.service.IExampleService;
	import org.robotlegs.example.view.MainView;
	import org.robotlegs.example.view.api.IMainView;
	import org.robotlegs.example.view.api.INewWindow;
	import org.robotlegs.example.view.events.GetSomeTextEvent;
	import org.robotlegs.example.view.mediator.MainViewMediator;
	import org.robotlegs.example.view.mediator.NewWindowMediator;
	import org.swiftsuspenders.Injector;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import spark.components.Application;

	public class AppConfig
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		[Inject]
		public var injector:Injector;

		[Inject]
		public var mediatorMap:IMediatorMap;

		[Inject]
		public var commandMap:IEventCommandMap;

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		[PostConstruct]
		public function init():void
		{
			// View
			mediatorMap.mapView(IMainView).toMediator(MainViewMediator);
			mediatorMap.mapView(INewWindow).toMediator(NewWindowMediator);

			// Model
			injector.map(ExampleModel);

			// service
			injector.map(IExampleService).toSingleton(ExampleService);

			// controller
			commandMap.map(GetSomeTextEvent.GET_SOME_TEXT, GetSomeTextEvent).toCommand(GetSomeTextCommand);
		}
	}
}
