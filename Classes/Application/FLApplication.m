//
//	FLApplication.m
//	FishLamp
//
//	Created by Mike Fullerton on 4/12/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLApplication.h"
#import "FLTheme.h"

@implementation FLApplication

+ (FLApplication*) instance {
    return (FLApplication*) [UIApplication sharedApplication];
}

@synthesize lastActivateTime = _lastActivateTime;
@synthesize operationContextManager = _operationContextManager;

- (void) _appWillBecomeActive:(id) sender {
    _lastActivateTime = [NSDate timeIntervalSinceReferenceDate];
}

- (id) init {
    self = [super init];
    if(self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                selector:@selector(_appWillBecomeActive:) 
                name: UIApplicationDidBecomeActiveNotification // UIApplicationDidBecomeActiveNotification
                object: [UIApplication sharedApplication]];
    
        _operationContextManager = [[FLOperationContextManager alloc] init];
    }
    
    return self;
}

- (void) applyTheme:(FLTheme*) theme {
    [[UIApplication sharedApplication] setStatusBarStyle:DeviceIsPad() ? UIStatusBarStyleBlackOpaque : UIStatusBarStyleBlackTranslucent animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

+ (FLApplication*) sharedApplication {
	return (FLApplication*) [UIApplication sharedApplication];
}

- (void) finishInitializing {
    self.wantsApplyTheme = YES;
}

- (void) dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];

#if FL_MRC
    [_operationContextManager release];
    mrc_release_(_eventInterceptors);
	mrc_super_dealloc_();
#endif
}

- (void) addEventInterceptor:(id<FLApplicationEventInterceptor>) interceptor {
	if(!_addList) {
		_addList = [[NSMutableArray alloc] init];
	}
	[_addList addObject:[NSValue valueWithNonretainedObject:interceptor]];
}

- (void) removeEventInterceptor:(id<FLApplicationEventInterceptor>) interceptor {
	if(!_removeList) {
		_removeList = [[NSMutableArray alloc] init];
	}
    [_removeList addObject:[NSValue valueWithNonretainedObject:interceptor]];
}

- (void) _removeInterceptor:(id<FLApplicationEventInterceptor>) interceptor {
	for(NSUInteger i = 0; i < _eventInterceptors.count; i++) {
		if([[_eventInterceptors objectAtIndex:i] nonretainedObjectValue] == interceptor) {
			[_eventInterceptors removeObjectAtIndex:i];
			break;
		}
	}
}

- (void) _updateList {
    if(_removeList && _removeList.count) {
        for(id<FLApplicationEventInterceptor> obj in _removeList) {
            [self _removeInterceptor:obj];
        }
        
        [_removeList removeAllObjects];
    }
    
    if(_addList && _addList.count) {
        if(!_eventInterceptors) {
            _eventInterceptors = _addList;
            _addList = nil;
        }
        else {
            [_eventInterceptors addObjectsFromArray:_addList];
            [_addList removeAllObjects];
        }
    }
}

- (BOOL) hasEventInterceptor:(id<FLApplicationEventInterceptor>) interceptor
{
	for(NSValue* receiver in _removeList) {
		if([receiver nonretainedObjectValue] == interceptor) {
            return NO;
        }
	}
	for(NSValue* receiver in _eventInterceptors) {
		if([receiver nonretainedObjectValue] == interceptor) {
            return YES;
        }
	}
	for(NSValue* receiver in _addList) {
		if([receiver nonretainedObjectValue] == interceptor) {
            return YES;
        }
	}
    
    return NO;
}

- (BOOL) didInterceptEvent:(UIEvent*) event {
    [self _updateList];

    if(_eventInterceptors && _eventInterceptors.count) {
		for(NSValue* receiver in _eventInterceptors) {
			if([receiver.nonretainedObjectValue didInterceptEvent:event]) {
				return YES;
			}
		}
	}
    
    return NO;
}

- (void)sendEvent:(UIEvent *)event {
    if(![self didInterceptEvent:event]) {
		[super sendEvent:event];
	}
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (event.type == UIEventSubtypeMotionShake) {
        [[NSNotificationCenter defaultCenter] postNotificationName:FLDeviceWasShakenNotification object:[UIApplication sharedApplication]];
    }
	
	if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] ) {
		[super motionEnded:motion withEvent:event];
	}
}





@end
