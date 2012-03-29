//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package org.robotlegs.example
{
	import robotlegs.bender.extensions.logging.LoggingExtension;
	import robotlegs.bender.framework.context.api.IContext;
	import robotlegs.bender.framework.context.api.IContextExtension;
	import robotlegs.bender.framework.logging.api.LogLevel;

	public class LoggerConfig implements IContextExtension
	{

		public function extend(context:IContext):void
		{
			context.extend(LoggingExtension);
			context.logLevel = LogLevel.DEBUG;
		}
	}
}
