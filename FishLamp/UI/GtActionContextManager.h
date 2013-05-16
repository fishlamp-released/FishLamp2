//
//  GtActionContextManager.h
//  MyZen
//
//  Created by Mike Fullerton on 12/9/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
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

