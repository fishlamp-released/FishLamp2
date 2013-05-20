//
//  GtAsyncEventHandler.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/30/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtAsyncEventHandler.h"
#import "NSObject+Blocks.h"

@implementation GtAsyncEventHandler

@synthesize configureActionBlock = m_configureAction;
@synthesize didCompleteBlock = m_didComplete;
@synthesize didLoadDataBlock = m_didLoadData;
@synthesize userData = m_userData; 
@synthesize actionContext = m_actionContext;
@synthesize transactionID = m_transactionID;

+ (GtAsyncEventHandler*) asyncEventHandler:(GtActionContext*) context
{
    return GtReturnAutoreleased([[GtAsyncEventHandler alloc] initWithActionContext:context]);
}

- (id) initWithActionContext:(GtActionContext*) context
{
    if((self = [super init]))
    {
        m_actionContext = GtRetain(context);
    }
    return self;
}

- (void) dealloc
{
    GtRelease(m_configureAction);
    GtRelease(m_didComplete);
    GtRelease(m_didLoadData);
    GtRelease(m_userData); 
    GtRelease(m_actionContext);
    GtRelease(m_transactionID);
    GtSuperDealloc();
}

- (void) invokeConfigureActionBlock:(id<GtAction>) action
{
    if(m_configureAction)
    {
        m_configureAction(action);
    }
}

- (void) invokeDidLoadDataBlock:(GtAsyncEventHandlerResult) result error:(NSError*) error data:(id) data
{
    if(m_didLoadData)
    {   
        [self performBlockOnMainThread:^{ 
            if(m_didLoadData)
            {   
                m_didLoadData(result, error, data);
            }
        }];
    }
}
    
- (void) invokeDidCompleteBlock:(NSError*) error
{
    if(m_didLoadData)
    {   
        [self performBlockOnMainThread:^{ 
            if(m_didComplete)
            {
                m_didComplete(error);
            }
        }];
    }
}

@end

