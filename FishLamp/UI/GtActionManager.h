//
//  GtActionManager.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/1/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GtAction;

#if DEBUG
// uncommenting this will make every action take at least 5 seconds
//#define GT_DELAY_ACTION 5
#endif

@interface GtActionManager : NSObject {
	NSOperationQueue* m_operations;
	NSMutableArray* m_executingActions;
	NSMutableArray* m_queue;
	
	BOOL m_inPerformNextActionInQueue;
	BOOL m_needsPerformNextAction;
}

+ (GtActionManager*) instance;
@end

@interface GtActionManager (Internal)
- (void) beginAction:(GtAction*) action; // call begin on your action
- (void) queueAction:(GtAction*) action;
- (void) actionFinished:(GtAction*) action;
@end



