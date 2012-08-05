//
//	FLManagedActionContext.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/12/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLActionContext.h"

extern NSString* const FLActionContextWasActivated;
extern NSString* const FLActionContextWillBeginActionNotification;
extern NSString* const FLActionContextDidFinishAllActionsNotification;

@interface FLManagedActionContext : FLActionContext {
}
@end
