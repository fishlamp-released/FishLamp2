//
//  FLLogFile.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/7/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLLogFile.h"

@implementation FLLogFile 

@synthesize filePath = _filePath;

- (id) initWithPath:(NSString*) path {
    self = [super init];
    if(self) {
        self.filePath = path;
    }
    
    return self;
}

+ (FLLogFile*) logFile:(NSString*) path {
    return FLAutorelease([[[self class] alloc] initWithFolderPath:path]);
}

- (void) dealloc {
    [self closeLogFile];

    FLRelease(_filePath);
    FLSuperDealloc();
}

- (void) openLogFile {
    
    FLAssertIsNilWithComment(_fileHandle, nil);
    
    if(!_fileHandle) {

        @try {
            if(![[NSFileManager defaultManager] fileExistsAtPath:_filePath]) {
                NSError* error = nil;
                NSString* empty = @"";
                
                [empty writeToFile:_filePath atomically:NO encoding:NSUTF8StringEncoding error:&error ];

                if(error) {
                    FLThrowIfError(FLAutorelease(error));
                }
            }

            _fileHandle = FLRetain([NSFileHandle fileHandleForWritingAtPath:_filePath]);
        }
        @catch(NSException* ex) {
            FLLog(@"Log open failed: %@", [ex description]);
        
        // TODO: recover? fail? dance a jig?
        
        }
    }
}

- (void) closeLogFile {
    if(_fileHandle) {
        @try {
            [_fileHandle synchronizeFile];
            [_fileHandle closeFile];
        }
        @catch (NSException* ex) {
            FLLog(@"Log close failed: %@", [ex description]);
        }
        
        FLReleaseWithNil(_fileHandle);
    }
}

- (void) logString:(NSString*) theString {
    if(!_fileHandle) {
        [self openLogFile];
    }
    
    @try {
        [_fileHandle seekToEndOfFile];
        [_fileHandle writeData:[theString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    @catch(NSException* ex) {
        FLLog(@"Log file write failed: %@", [ex description]);
    }
}

@end
