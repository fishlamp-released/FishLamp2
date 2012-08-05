//
//	FLActionContextManager.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/9/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FishLampCore.h"

#import <Foundation/Foundation.h>

#import "FLActionContext.h"


@interface FLActionContextManager : NSObject {
	NSMutableArray* _contextStack;
	struct {
		unsigned int disableActivatePrevious:1;
	} _flags;
}

FLSingletonProperty(FLActionContextManager);

- (FLActionContext*) activeContext;

- (void) addContext:(FLActionContext*) context;
- (void) removeContext:(FLActionContext*) context;

- (void) deactivateAllManagedContexts;
- (void) activatePreviousContext:(FLActionContext*) context;

@end

