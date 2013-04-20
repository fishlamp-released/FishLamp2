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
    NSString* _filePath;
    NSString* _outputPath;
    NSOutputStream* _outputStream;
    BOOL _open;
}

- (id) initWithFilePath:(NSString*) filePath;
+ (id) fileSink:(NSString*) filePath;
@end