//
//  GtTableViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 2/1/10.
//  Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtManagedActionContext.h"

@interface GtTableViewController : UITableViewController {
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
