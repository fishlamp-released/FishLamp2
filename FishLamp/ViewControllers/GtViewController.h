//
//  GtViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/8/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GtManagedActionContext.h"

#if DEBUG
#define TRACE_ACTION_CONTROLLER 0
#endif

@interface GtViewController : UIViewController {
@private
	GtManagedActionContext* m_context;
}

@property (readonly, assign, nonatomic) GtActionContext* actionContext;

- (void) onActionsCancelled:(NSArray*) actions  
                  wasTerminated:(BOOL) wasTerminated;

- (void) didBecomeActiveContext;
- (void) didBecomeInactiveContext;

- (void) onDeviceWasShaken;

@end
