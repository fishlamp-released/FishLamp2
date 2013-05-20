//
//	GtActionContextManager.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/9/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtActionContext.h"


@interface GtActionContextManager : NSObject {
	NSMutableArray* m_contextStack;
	struct {
		unsigned int disableActivatePrevious:1;
	} m_flags;
}

GtSingletonProperty(GtActionContextManager);

- (GtActionContext*) activeContext;

- (void) addContext:(GtActionContext*) context;
- (void) removeContext:(GtActionContext*) context;

- (void) deactivateAllManagedContexts;
- (void) activatePreviousContext:(GtActionContext*) context;

@end

