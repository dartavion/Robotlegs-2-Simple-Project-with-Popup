/**
 * Created by IntelliJ IDEA.
 * User:
 * Date: 2/21/12
 * Time: 1:52 PM
 * To change this template use File | Settings | File Templates.
 */
package org.robotlegs.example.controller {
    import org.robotlegs.example.service.IExampleService;
    import org.robotlegs.example.view.events.GetSomeTextEvent;

    import robotlegs.bender.bundles.mvcs.Command;

    public class GetSomeTextCommand extends Command{

        [Inject]
        public var event:GetSomeTextEvent;

        [Inject]
        public var service:IExampleService;
        
        override public function execute():void{
            trace("3. Now we're in the command which will then tell the service to load data:::::::::")
            service.load();
        }
    }
}
