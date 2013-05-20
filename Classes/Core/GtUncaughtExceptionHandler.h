//
//	UncaughtExceptionHandler.h
//	UncaughtExceptions
//
//	Created by Matt Gallagher on 2010/05/25.
//	Copyright (c) 2013 Matt Gallagher. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
//	Permission is given to use this source code file, free of charge, in any
//	project, commercial or otherwise, entirely at your risk, with the condition
//	that any redistribution (in part or whole) of source code must retain
//	this copyright and permission notice. Attribution in compiled projects is
//	appreciated but not required.
//

#import <UIKit/UIKit.h>

@interface GtUncaughtExceptionHandler : NSObject
{
	BOOL dismissed;
}

@end

void GtInstallUncaughtExceptionHandler();
