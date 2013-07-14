//
//  FLPromisedResult.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/23/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLPromisedResult.h"

//@interface FLPromisedResult : NSObject<FLPromisedResult> {
//@private
//    id _value;
//    NSError* _error;
//}
//@property (readonly, strong, nonatomic) NSError* resultError;
//@property (readonly, strong, nonatomic) id resultValue;
//
//- (id) initWithValue:(id) value error:(NSError*) error;
//+ (id) promisedResult:(id) value error:(NSError*) error;
//
//@end
//
//
//@interface FLPromisedResult ()
//@property (readwrite, strong, nonatomic) NSError* resultError;
//@property (readwrite, strong, nonatomic) id resultValue;
//@end
//
//@implementation FLPromisedResult
//
//@synthesize resultValue = _resultValue;
//@synthesize resultError = _resultError;
//
//- (id) initWithValue:(id) resultValue error:(NSError*) resultError {
//	self = [super init];
//	if(self) {
//		self.resultValue = resultValue;
//        self.resultError = resultError;
//	}
//	return self;
//}
//
//+ (id) promisedResult:(id) resultValue error:(NSError*) resultError {
//    return FLAutorelease([[[self class] alloc] initWithValue:resultValue error:resultError]);
//}
//
//#if FL_MRC
//- (void)dealloc {
//	[_resultValue release];
//    [_resultError release];
//
//	[super dealloc];
//}
//#endif
//
//
//@end

@implementation NSObject (FLPromisedResult)
- (BOOL) isError {
    return NO;
}

+ (id) fromPromisedResult:(FLPromisedResult) promisedResult {

    FLThrowIfError(promisedResult);

    FLConfirmWithComment(
        [promisedResult isKindOfClass:[self class]],
        @"Result expected to be a \"%@\" instead it's a \"%@\"",
            NSStringFromClass([self class]),
            NSStringFromClass([promisedResult class]));

    return promisedResult;

}

@end

@implementation NSError (FLPromisedResult)
- (BOOL) isError {
    return YES;
}

+ (id) fromPromisedResult:(FLPromisedResult) promisedResult {
    FLConfirmWithComment(
        [promisedResult isKindOfClass:[self class]],
        @"Result expected to be a \"%@\" instead it's a \"%@\"",
            NSStringFromClass([self class]),
            NSStringFromClass([promisedResult class]));

    return promisedResult;

}
@end
