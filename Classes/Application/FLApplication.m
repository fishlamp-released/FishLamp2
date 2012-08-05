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

- (void) applyTheme:(FLTheme*) theme {
    [[UIApplication sharedApplication] setStatusBarStyle:DeviceIsPad() ? UIStatusBarStyleBlackOpaque : UIStatusBarStyleBlackTranslucent animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

+ (FLApplication*) sharedApplication {
	return (FLApplication*) [UIApplication sharedApplication];
}

- (void) didInitializeApp {
    self.wantsApplyTheme = YES;
}

- (void) dealloc {
    FLRelease(_eventInterceptors);
	FLSuperDealloc();
}

- (void) addEventInterceptor:(id<FLEventInterceptor>) interceptor {
	if(!_addList) {
		_addList = [[NSMutableArray alloc] init];
	}
	[_addList addObject:[NSValue valueWithNonretainedObject:interceptor]];
}

- (void) removeEventInterceptor:(id<FLEventInterceptor>) interceptor {
	if(!_removeList) {
		_removeList = [[NSMutableArray alloc] init];
	}
    [_removeList addObject:[NSValue valueWithNonretainedObject:interceptor]];
}

- (void) _removeInterceptor:(id<FLEventInterceptor>) interceptor {
	for(NSUInteger i = 0; i < _eventInterceptors.count; i++) {
		if([[_eventInterceptors objectAtIndex:i] nonretainedObjectValue] == interceptor) {
			[_eventInterceptors removeObjectAtIndex:i];
			break;
		}
	}
}

- (void) _updateList {
    if(_removeList && _removeList.count) {
        for(id<FLEventInterceptor> obj in _removeList) {
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

- (BOOL) hasEventInterceptor:(id<FLEventInterceptor>) interceptor
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
