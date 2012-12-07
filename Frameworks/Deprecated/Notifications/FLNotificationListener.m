//
//  FLNotificationListener.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/8/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import "FLNotificationListener.h"

@implementation FLNotificationListener

@synthesize callback = _callback;

- (id) initWithTarget:(id) target action:(SEL) action
{
    if((self = [super init]))
    {
        _callback = FLCallbackMake(target, action);
    }
    
    return self;
}

- (id) init
{
    return [self initWithTarget:nil action:nil];
}

+ (id) notificationListener
{
    return FLAutorelease([[[self class] alloc] init]);
}

+ (id) notificationListener:(id) target action:(SEL) action
{
    return FLAutorelease([[[self class] alloc] initWithTarget:target action:action]);
}

- (void) didReceiveEvent:(NSNotification*) notification
{
    FLInvokeCallback(_callback, notification);
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
    self.callback = FLCallbackZero;
}

- (void) dealloc 
{
    [self removeAllObservers];
    super_dealloc_();
}


@end
