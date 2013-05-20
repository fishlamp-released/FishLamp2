//
//	GtManagedActionContext.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/12/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtActionContext.h"

extern NSString* const GtActionContextWasActivated;
extern NSString* const GtActionContextWillBeginActionNotification;
extern NSString* const GtActionContextDidFinishAllActionsNotification;

@interface GtManagedActionContext : GtActionContext {
}
@end
