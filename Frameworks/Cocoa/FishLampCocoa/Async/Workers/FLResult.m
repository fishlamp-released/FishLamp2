//
//  FLResult.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/16/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLResult.h"


@interface FLResultObject : NSObject<FLResultContract> {
@private
}
//+ (id) result:(id) payload;
//+ (id) result;
@end

@interface FLSuccessfulResult : FLResultObject
@end

@implementation FLSuccessfulResult
+ (id) successfullResult {
    FLReturnStaticObject([[[self class] alloc] init]);
}
@end

//@interface FLSuccessfulResultWithPayload : FLResultObject {
//@private
//    id _payload;
//}
//+ (id) successfullResult:(id) payload;
//@property (readwrite, strong) id payload;
//@end
//
//@implementation FLSuccessfulResultWithPayload
//
//@synthesize payload = _payload;
//
//- (id) initWithPayload:(id) payload {
//    self = [super init];
//    if(self) {
//        self.payload = payload;
//    }
//    return self;
//}
//
//+ (id) successfulResult:(id) payload {
//    return autorelease_([[[self class] alloc] initWithPayload:payload]);
//}
//
//#if FL_MRC
//- (void) dealloc {
//    [_payload release];
//    [super dealloc];
//}
//#endif
//@end


@implementation FLResultObject 

//+ (id) result:(id) payload {
//    if(!payload) {
//        return [FLSuccessfulResult successfullResult];
//    }
//    
//    if([payload error]) {
//        return payload;
//    }
//    
//    return [FLSuccessfulResultWithPayload successfullResult:payload];
//}
//
//+ (id) result {
//    return autorelease_([[[self class] alloc] init]);
//}

- (NSError*) error {
    return nil;
}

- (BOOL) isFailedResult {
    return NO;
}

- (BOOL) isExpectedResult {
    return YES;
}


@end

@implementation NSObject (FLResultContract)
- (NSError*) error {
    return nil;
}

- (BOOL) isFailedResult {
    return NO;
}

- (BOOL) isExpectedResult {
    return YES;
}

//- (BOOL) isExpectedResult {
//    return NO;
//}
//
//- (BOOL) isResult {
//    return YES;
//}

@end

@implementation NSError (FLResultContract)

//- (BOOL) didSucceed {
//    return NO;
//}
//
//- (BOOL) didFail {
//    return YES;
//}

- (BOOL) isFailedResult {
    return YES;
}

- (BOOL) isExpectedResult {
    return NO;
}

- (NSError*) error {
    return self;
}

@end

id FLMakeResult(id result) {
    if(!result) {
        return [FLSuccessfulResult successfullResult];
    }
    
    if([result error]) {
        return result;
    }
    
    return result;
}


