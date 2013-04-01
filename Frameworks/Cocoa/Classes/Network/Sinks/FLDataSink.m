//
//  FLDataSink.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/31/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDataSink.h"

@interface FLDataSink ()
@property (readwrite, strong, nonatomic) NSData* data;
@property (readwrite, strong, nonatomic) NSMutableData* responseData;
@end

@implementation FLDataSink

@synthesize data = _data;
@synthesize responseData = _responseData;

+ (id) dataSink {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) appendBytes:(const void *)bytes length:(NSUInteger)length {
    [self.responseData appendBytes:bytes length:length];
}

- (void) openSink {
    FLAssertNil(self.responseData);

    self.responseData = [NSMutableData data];
    self.data = nil;
}

- (void) closeSinkWithError:(NSError*) error {
    if(error) {
        self.data = nil;
        self.responseData = nil;
    }
}

- (void) commit {
    self.data = self.responseData;
    self.responseData = nil;
}

#if FL_MRC
- (void) dealloc {
    [_responseData release];
    [_data release];
    [super dealloc];
}
#endif

- (NSURL*) fileURL {
    return nil;
}
@end
