//
//  ZFTransferState.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFTransferState.h"

@interface ZFTransferState ()
@property (readwrite, assign, nonatomic) ZFTransferState_t values;
@end

@implementation ZFTransferState  
@synthesize values = _values;

- (id) copyWithZone:(NSZone*) zone {
    ZFTransferState* copy = [[ZFTransferState alloc] init];
    copy.values = self.values;
    return copy;
}

- (id) initWithState:(ZFTransferState_t) state {	
	self = [super init];
	if(self) {
		_values = state;
	}
	return self;
}

- (id) init {	
	self = [super init];
	if(self) {
		memset(&_values, 0, sizeof(ZFTransferState_t));
	}
	return self;
}

+ (id) transferState:(ZFTransferState_t) state {
    return FLAutorelease([[[self class] alloc] initWithState:state]);
}

+ (id) transferState {
    return FLAutorelease([[[self class] alloc] init]);
}

@end
