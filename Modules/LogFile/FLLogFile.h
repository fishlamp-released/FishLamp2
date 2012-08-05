//
//  FLLogFile.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/7/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//
#import "FishLampCocoa.h"

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
