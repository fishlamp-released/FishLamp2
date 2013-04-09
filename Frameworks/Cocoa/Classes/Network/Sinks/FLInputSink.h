//
//  FLInputSink.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/31/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

@protocol FLInputSink <NSObject>

// results, once the stream is closed.
@property (readonly, strong, nonatomic) NSData* data;
@property (readonly, strong, nonatomic) NSURL* fileURL;

- (void) openSink;
- (void) closeSinkWithError:(NSError*) error;

- (void) commit;

- (void) appendBytes:(const void *)bytes 
              length:(NSUInteger)length;

@end
