//
//  FLLogFile.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/7/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#import "FishLampCore.h"

#import "FLFolderFile.h"

@interface FLLogFile : NSObject {
@private
    NSString* _filePath;
    NSFileHandle* _fileHandle;
}
@property (readwrite, strong, nonatomic) NSString* filePath;

- (id) initWithPath:(NSString*) path;

- (void) openLogFile;
- (void) closeLogFile;

- (void) logString:(NSString*) string;

+ (FLLogFile*) logFile:(NSString*) path;

@end
