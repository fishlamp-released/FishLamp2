//
//  FLPromisedResult.m
//  FLCore
//
//  Created by Mike Fullerton on 11/16/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAsyncResult.h"
#import "FLErrorCodes.h"

#import "FLAsyncResult.h"

//@interface FLAsyncResult ()
//@property (readwrite, strong, nonatomic) id result;
//@property (readwrite, strong, nonatomic) NSError* error;
//@end
//
//@implementation FLAsyncResult 
//@synthesize result = _result;
//@synthesize error = _error;
//
//#if FL_MRC
//- (void) dealloc {
//    [_returnedObject release];
//	[_error release];
//	[super dealloc];
//}
//#endif
//
//- (id) init {	
//    return [self initWithObject:nil error:nil ];
//}
//
//- (id) initWithObject:(id) value 
//                error:(NSError*) error {	
//	self = [super init];
//	if(self) {
//		self.value = value;
//        self.error = error;
//	}
//	return self;
//}
//
//- (id) copyWithZone:(NSZone *)zone {
//    return [[[self class] alloc] initWithObject:self.value error:self.error];
//}
//
//- (id)mutableCopyWithZone:(NSZone *)zone {
//    return [[FLMutableAsyncResult alloc] initWithObject:self.value error:self.error];
//}
//
//+ (id) asyncResult {
//    FLReturnStaticObject(
//        FLAutorelease([[[self class] alloc] init]));
//}
//
//+ (id) asyncResult:(id) value {
//    return FLAutorelease([[[self class] alloc] initWithObject:value error:nil ]);
//}
//
//+ (id) failedAsyncResult {
//    FLReturnStaticObject(
//        FLAutorelease([[[self class] alloc] initWithObject:nil error:[NSError failedResultError] ]));
//}
//
//+ (id) asyncResultWithError:(NSError*) error {
//    return FLAutorelease([[[self class] alloc] initWithObject:nil error:error]);
//}
//
//+ (id) asyncResult:(id) value
//             error:(NSError*) error {
//    return FLAutorelease([[[self class] alloc] initWithObject:value error:error ]);
//}
//
//- (FLPromisedResult) asAsyncResult {
//    return self;
//}
//@end
//
//
//@implementation FLMutableAsyncResult 
//@dynamic error;
//@dynamic result;
//
//+ (id) asyncResult {
//    return FLAutorelease([[[self class] alloc] init]);
//}
//
//+ (id) failedAsyncResult {
//    return FLAutorelease([[[self class] alloc] initWithObject:nil error:[NSError failedResultError]]);
//}
//@end

@implementation NSError (FLAsyncResult)
+ (id) failedResultError {
    FLReturnStaticObject(
     [NSError errorWithDomain:FLErrorDomain
                               code:FLErrorResultFailed
               localizedDescription:NSLocalizedString(@"An operation failed.", nil)
                           userInfo:nil
                            comment:nil]);
}

- (NSError*) error {
    return self;
}
@end

@implementation NSObject (FLAsyncResult)
- (NSError*) error {
    return nil;
}
@end





