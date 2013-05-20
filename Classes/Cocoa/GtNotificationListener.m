//
//  GtNotificationListener.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/8/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtNotificationListener.h"

@implementation GtNotificationListener

@synthesize callback = m_callback;

- (id) initWithTarget:(id) target action:(SEL) action
{
    if((self = [super init]))
    {
        m_callback = GtCallbackMake(target, action);
    }
    
    return self;
}

- (id) init
{
    return [self initWithTarget:nil action:nil];
}

+ (id) notificationListener
{
    return GtReturnAutoreleased([[[self class] alloc] init]);
}

+ (id) notificationListener:(id) target action:(SEL) action
{
    return GtReturnAutoreleased([[[self class] alloc] initWithTarget:target action:action]);
}

- (void) didReceiveEvent:(NSNotification*) notification
{
    GtInvokeCallback(m_callback, notification);
}

- (void) addObserverForEvent:(NSString*) event object:(id) object
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveEvent:) name:event object:object];
}

- (void) addObserverForEvent:(NSString*) event
{
    [self addObserverForEvent:event];
}

- (void) removeAllObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) clear
{   
    [self removeAllObservers];
    self.callback = GtCallbackZero;
}

- (void) dealloc 
{
    [self removeAllObservers];
    GtSuperDealloc();
}


@end
