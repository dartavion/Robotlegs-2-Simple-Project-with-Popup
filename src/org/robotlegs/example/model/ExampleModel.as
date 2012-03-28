/**
 * Created by IntelliJ IDEA.
 * User:
 * Date: 2/21/12
 * Time: 2:02 PM
 * To change this template use File | Settings | File Templates.
 */
package org.robotlegs.example.model {
    import org.robotlegs.example.base.BaseActor;
    import org.robotlegs.example.model.event.ExampleModelUpdate;
    import org.robotlegs.example.model.vo.AnswerVO;

    public class ExampleModel extends BaseActor{
        public function ExampleModel() {
        }

        public function createMessage(jsonObject:Object):void {
            trace("5. We're now in the model prepping the data::::::::");
            trace("6. We are going to pass the answer object to the Example Model Update Event::::: " + jsonObject.data.answer);
            var valueObject:AnswerVO = new AnswerVO();
            valueObject.answer = jsonObject.data.answer;
            trace("7. Dispatch event to let the ui know we've changed:::::::::::")
            dispatch(new ExampleModelUpdate(ExampleModelUpdate.MODEL_UPDATED, valueObject));
        }
    }
}
