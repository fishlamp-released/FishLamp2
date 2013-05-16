//
//  GtAsyncOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/21/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtCallback.h"

@interface GtAsyncOperation : NSOperation {
@private
	GtCallback* m_callback;
	
#if TRACE_CALLBACK
	int m_id;
#endif	
}

@property (readonly, assign, nonatomic) GtCallback* callback;

- (id) initWithCallback:(GtCallback*) callback;

#if !IPHONE
+ (GtAsyncOperation*) operationWithCallback:(GtCallback*) callback;
#endif

- (void) addParameter:(id) object;
- (void) addBoolParameter:(BOOL) isTrue;
- (void) addIntParameter:(int) value;

@end
