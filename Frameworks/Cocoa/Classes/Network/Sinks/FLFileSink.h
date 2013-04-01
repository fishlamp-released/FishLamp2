//
//  FLFileSink.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/31/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLInputSink.h"

@interface FLFileSink : NSObject<FLInputSink>  {
@private
    NSURL* _fileURL;
    NSURL* _outputURL;
    NSOutputStream* _outputStream;
}

- (id) initWithFileURL:(NSURL*) fileURL;
+ (id) fileSink:(NSURL*) fileURL;
@end