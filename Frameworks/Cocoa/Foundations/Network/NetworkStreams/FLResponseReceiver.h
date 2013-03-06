//
//  FLResponseReceiver.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/4/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FLReadStream;

@protocol FLResponseReceiver <NSObject>
@property (readonly, strong, nonatomic) NSData* data;
@property (readonly, strong, nonatomic) NSInputStream* readStream;
@property (readonly, strong, nonatomic) NSURL* fileURL;

// internal, don't call these.
- (NSError*) closeWithResult:(id) result;
- (void) readBytesFromStream:(FLReadStream*) stream;

@end
@interface FLResponseReceiver : NSObject<FLResponseReceiver> {
@private
}
- (void) appendBytes:(const void *)bytes length:(NSUInteger)length;
@end

@interface FLDataResponseReceiver : FLResponseReceiver {
@private
    NSMutableData* _responseData;
    NSData* _data;
}
+ (id) dataResponseReceiver;
@end

@interface FLFileResponseReceiver : FLResponseReceiver {
@private
    NSURL* _fileURL;
    NSOutputStream* _outputStream;
}

- (id) initWithFileURL:(NSURL*) fileURL;
+ (id) fileResponseReceiver:(NSURL*) fileURL;

@end

