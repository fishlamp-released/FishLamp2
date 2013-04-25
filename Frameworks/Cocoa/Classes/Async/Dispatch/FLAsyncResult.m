//
//  id<FLAsyncResult>.m
//  FLCore
//
//  Created by Mike Fullerton on 11/16/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAsyncResult.h"
#import "FLErrorCodes.h"

#import "FLAsyncResult.h"

@interface FLAsyncResult ()
@property (readwrite, strong, nonatomic) id returnedObject;
@property (readwrite, assign, nonatomic) NSInteger hint;
@property (readwrite, strong, nonatomic) NSError* error;
@end

@implementation FLAsyncResult 
@synthesize hint = _hint;
@synthesize returnedObject = _returnedObject;
@synthesize error = _error;

#if FL_MRC
- (void) dealloc {
    [_returnedObject release];
	[_error release];
	[super dealloc];
}
#endif

- (id) init {	
    return [self initWithObject:nil error:nil hint:0];
}

- (id) initWithObject:(id) returnedObject 
                error:(NSError*) error 
                 hint:(NSInteger) hint {	
	self = [super init];
	if(self) {
		self.returnedObject = returnedObject;
        self.hint = hint;
        self.error = error;
	}
	return self;
}

- (BOOL) didFail {
    return self.error != nil;
}

- (BOOL) didSucceed {
    return self.error == nil;
}

- (id) copyWithZone:(NSZone *)zone {
    return [[[self class] alloc] initWithObject:self.returnedObject error:self.error hint:self.hint];
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return [[FLMutableAsyncResult alloc] initWithObject:self.returnedObject error:self.error hint:self.hint];
}

+ (id) asyncResult {
    FLReturnStaticObject(
        FLAutorelease([[[self class] alloc] init]));
}

+ (id) asyncResult:(id) returnedObject {
    return FLAutorelease([[[self class] alloc] initWithObject:returnedObject error:nil hint:0]);
}

+ (id) asyncResult:(id) returnedObject 
                   hint:(NSInteger) hint {
    
    return FLAutorelease([[[self class] alloc] initWithObject:returnedObject error:nil hint:hint]);
}

+ (id) asyncResultWithHint:(NSInteger) hint {
    return FLAutorelease([[[self class] alloc] initWithObject:nil error:nil hint:hint]);
}

+ (id) failedAsyncResult {
    FLReturnStaticObject(
        FLAutorelease([[[self class] alloc] initWithObject:nil error:[NSError failedResultError] hint:0]));
}

+ (id) failedAsyncResult:(NSError*) error {
    return FLAutorelease([[[self class] alloc] initWithObject:nil error:error hint:0]);
}

+ (id) failedAsyncResult:(NSError*) error
                returnedObject:(id) returnedObject {
    return FLAutorelease([[[self class] alloc] initWithObject:returnedObject error:error hint:0]);
}

+ (id) failedAsyncResult:(NSError*) error
                  hint:(NSInteger) hint {
    return FLAutorelease([[[self class] alloc] initWithObject:nil error:error hint:hint]);
}

+ (id) failedAsyncResult:(NSError*) error
                returnedObject:(id) returnedObject
                  hint:(NSInteger) hint {
    return FLAutorelease([[[self class] alloc] initWithObject:returnedObject error:error hint:hint]);
}

+ (id) failedAsyncResultWithHint:(NSInteger) hint {
    return FLAutorelease([[[self class] alloc] initWithObject:nil error:nil hint:hint]);
}

- (id<FLAsyncResult>) asAsyncResult {
    return self;
}
@end


@implementation FLMutableAsyncResult 
@dynamic error;
@dynamic returnedObject;
@dynamic hint;

+ (id) asyncResult {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (id) failedAsyncResult {
    return FLAutorelease([[[self class] alloc] initWithObject:nil error:[NSError failedResultError] hint:0]);
}
@end

@implementation NSError (FLAsyncResult)
+ (id) failedResultError {
    FLReturnStaticObject(
     [NSError errorWithDomain:FLErrorDomain
                               code:FLErrorResultFailed
               localizedDescription:NSLocalizedString(@"An operation failed.", nil)
                           userInfo:nil
                            comment:nil]);
}

- (id<FLAsyncResult>) asAsyncResult {
    return [FLAsyncResult failedAsyncResult:self];
}

- (id<FLAsyncResult>) asAsyncResultWithHint:(NSInteger) hint {
    return [FLAsyncResult failedAsyncResult:self hint:hint];
}

@end

@implementation NSObject (FLAsyncResult)

- (id<FLAsyncResult>) asAsyncResult {
    return [FLAsyncResult asyncResult:self];
}

- (id<FLAsyncResult>) asAsyncResultWithHint:(NSInteger) hint {
    return [FLAsyncResult asyncResult:self hint:hint];
}

@end





