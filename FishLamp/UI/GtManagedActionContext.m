//
//  GtManagedActionContext.m
//  MyZen
//
//  Created by Mike Fullerton on 12/12/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtManagedActionContext.h"

#import "GtActionContextManager.h"

@implementation GtManagedActionContext

- (id) init
{
    if(self = [super init])
    {
        [[GtActionContextManager instance] addContext:self];
    }
    return self;
}

- (id) initAndActivate:(BOOL) activate
{
    if(self = [super init])
    {
        [[GtActionContextManager instance] addContext:self];
    
        if(activate)
        {
            [self activate];
        }
    }
    return self;
}

- (BOOL) deactivate
{
    if([super deactivate])
    {   
        [[GtActionContextManager instance] activatePreviousContext:self];
        return YES;
    }
    
    return NO;
}

- (BOOL) activate
{
    if(!self.isActive)
    {   
        [[GtActionContextManager instance] deactivateAllManagedContexts];
        [super activate];
        return YES;
    }
    
    return NO;
}

- (void) dealloc
{
    [super dealloc];
    
    [[GtActionContextManager instance] removeContext:self];
}

@end
