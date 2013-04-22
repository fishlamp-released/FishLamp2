//
//  ZFTransferState.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFTransferState.h"

@interface ZFTransferState ()
//@property (readwrite, assign, nonatomic) ZFTransferState_t values;
//
//@property (readonly, assign) NSUInteger videoCount;
//@property (readonly, assign) NSUInteger videoTotal;
//@property (readonly, assign) NSUInteger photoCount;
//@property (readonly, assign) NSUInteger photoTotal;
//@property (readonly, assign) NSUInteger photoSetCount;
//@property (readonly, assign) NSUInteger photoSetTotal;
//@property (readonly, assign) unsigned long long byteTotal;
//@property (readonly, assign) unsigned long long byteCount;
//@property (readonly, assign) NSTimeInterval startedTime;
//@property (readonly, assign) NSTimeInterval transferTime;
//@property (readonly, assign) unsigned long long transferredBytes;
//@property (readonly, assign) unsigned long long currentPhotoBytes;

@end

@implementation ZFTransferState  

@synthesize videoCount = _videoCount ;
@synthesize videoTotal = _videoTotal;
@synthesize photoCount = _photoCount;
@synthesize photoTotal = _photoTotal;
@synthesize photoSetCount = _photoSetCount;
@synthesize photoSetTotal = _photoSetTotal;
@synthesize byteTotal = _byteTotal;
@synthesize byteCount = _byteCount;
@synthesize startedTime = _startedTime;
@synthesize transferTime = _transferTime;
@synthesize transferredBytes = _transferredBytes;
@synthesize currentPhotoBytes = _currentPhotoBytes;

FLSynthesizeModelObjectMethods();

//- (id) copyWithZone:(NSZone*) zone {
//    ZFTransferState* copy = [[ZFTransferState alloc] init];
//    copy.videoCount = self.videoCount ;
//    copy.videoTotal = self.videoTotal;
//    copy.photoCount = self.photoCount;
//    copy.photoTotal = self.photoTotal;
//    copy.photoSetCount = self.photoSetCount;
//    copy.photoSetTotal = self.photoSetTotal;
//    copy.byteTotal = self.byteTotal;
//    copy.byteCount = self.byteCount;
//    copy.startedTime = self.startedTime;
//    copy.transferTime = self.transferTime;
//    copy.transferredBytes = self.transferredBytes;
//    copy.currentPhotoBytes = self.currentPhotoBytes;
//    copy.identifier = self.identifier;
//    return copy;
//}

//- (void)encodeWithCoder:(NSCoder *)aCoder {
//
//}
//
//- (id)initWithCoder:(NSCoder *)aDecoder {
//
//
//    return self;
//}

//- (id) initWithState:(ZFTransferState_t) state {	
//	self = [super init];
//	if(self) {
//		_values = state;
//	}
//	return self;
//}

//- (id) init {	
//	self = [super init];
//	if(self) {
////		memset(&_values, 0, sizeof(ZFTransferState_t));
//	}
//	return self;
//}

//+ (id) transferState:(ZFTransferState_t) state {
//    return FLAutorelease([[[self class] alloc] initWithState:state]);
//}

+ (id) transferState {
    return FLAutorelease([[[self class] alloc] init]);
}

//#if FL_MRC
//- (void) dealloc {
//	[_identifier release];
//	[super dealloc];
//}
//#endif

@end
