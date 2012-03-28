package org.robotlegs.example.model.event {

    import org.robotlegs.example.model.vo.AnswerVO;

    import flash.events.Event;

    public class ExampleModelUpdate extends Event {

        public static const MODEL_UPDATED:String = "modelUpdated";

        public var model:AnswerVO;

        public function ExampleModelUpdate(type:String, model:AnswerVO, bubbles:Boolean = false, cancelable:Boolean = false) {
            super(type, bubbles, cancelable);
            this.model = model;
        }

        override public function clone():Event {
            return new ExampleModelUpdate(type, model, bubbles, cancelable);
        }
    }
}