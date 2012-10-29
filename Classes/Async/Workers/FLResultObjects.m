//
//  FLResultObjects
//  FishLampCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLResultObjects.h"

@implementation FLSuccessfullResult

- (BOOL) didSucceed { 
    return YES;
}

- (NSError*) error {
    return nil;
}

- (id) output {
    return nil;
}

FLSynthesizeSingleton(FLSuccessfullResult);
 
@end

@implementation FLFailedResult

- (BOOL) didSucceed { 
    return NO;
}

- (NSError*) error {
    return nil;
}

- (id) output {
    return nil;
}

FLSynthesizeSingleton(FLFailedResult);

 
@end

@interface FLErrorResult ()
@property (readwrite, strong, nonatomic) NSError* error;
@end

@implementation FLErrorResult
@synthesize error = _error;

- (id) initWithError:(NSError*) error {
    self = [super init];
    if(self) {
        self.error = error;
    }
    return self;
}

+ (id) errorResult:(NSError*) error {
    return FLReturnAutoreleased([[[self class] alloc] initWithError:error]);
}

#if FL_NO_ARC
- (void) dealloc {
    [_error release];
    [super dealloc];
}
#endif

@end

@interface FLOutputResult ()
@property (readwrite, strong, nonatomic) id output;
@end

@implementation FLOutputResult

- (id) initWithOutput:(id) output {
    self = [super init];
    if(self) {
        self.output = output;
    }
    return self;
}

+ (id) outputResult:(id) output {
    return FLReturnAutoreleased([[[self class] alloc] initWithOutput:output]);
}

@synthesize output = _output;
#if FL_NO_ARC
- (void) dealloc {
    [_output release];
    [super dealloc];
}
#endif

@end
