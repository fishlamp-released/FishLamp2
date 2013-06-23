//
//  FLLogFileManager.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/7/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLLogFileManager.h"
#import "FLAsyncQueue.h"
#import "NSFileManager+FLExtras.h"
#import "FLAppInfo.h"
#import "FishLampAsync.h"

@interface FLLogFileManager ()
@property (readwrite, strong, nonatomic) FLLogFile* logFile;
@property (readwrite, strong, nonatomic) NSString* userName;
@property (readwrite, strong, nonatomic) NSString* appName;

@end

@implementation FLLogFileManager

@synthesize logFile = _logFile;
@synthesize userName = _userName;
@synthesize appName = _appName;
@synthesize stringFormatter = _stringFormatter;

@synthesize deleteIfOlderThanSeconds = _deleteIfOlderThanSeconds;
@synthesize reuseIfNewerThanSeconds = _reuseIfNewerThanSeconds;

FLSynthesizeSingleton(FLLogFileManager);

- (void) _close {
    if(_logFile) {
        FLLogFile* closeMe = _logFile;

        [[FLDispatchQueue fifoQueue] queueBlock:^{
            [closeMe closeLogFile];
        }
        completion:nil];

        FLReleaseWithNil(_logFile);
    }

    FLReleaseWithNil(_userName);
}

// TODO: decouple this 
   
- (void) _setUserName {
//    self.userName = [FLUserService instance].userLogin.userName;
}

- (FLFolder*) _userLogFolder {
// return [FLUserService instance].logFolder;

    return nil;
}
   
- (void) openService {
    [super openService];

    [self _close];
    [self _setUserName];
}

- (void) closeService {
    [self _close];
}

- (id) init {
    self = [super init];
    if(self) {
//        [self _subscribeToEvents];
    
        self.appName = [FLAppInfo appName];
        
        self.stringFormatter = ^(NSString* input) {
            return [NSString stringWithFormat:@"%@:%@\n", [NSDate date], input];
        };

        _deleteIfOlderThanSeconds = 60 * 60 * 24 * 14;
        _reuseIfNewerThanSeconds = 60 * 60 * 24;
#if IOS        
        NSArray* cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString* userCacheFolder = [cachePaths objectAtIndex: 0];

        _appLogsFolder = [[FLFolder alloc] initWithFolderPath:[userCacheFolder stringByAppendingPathComponent:@"logs"]];
#else 
// TODO: implement me
#endif        
    }
    
    return self;
}

- (void) dealloc {
    [self _close];

    FLRelease(_appLogsFolder);
    FLRelease(_appName);
    FLRelease(_stringFormatter);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    FLSuperDealloc();
}


- (FLLogFile*) findNewestAndDeleteOldestInFolder:(FLFolder*) inFolder {
    
    NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
    __block NSString* outFilePath = nil;
    __block NSTimeInterval newest = 0;
    
    [inFolder visitAllFiles:^(NSString* fileName, BOOL* stop) {
    
        NSDate* date = [inFolder dateModifiedForFile:fileName];

        NSTimeInterval modDate = date.timeIntervalSinceReferenceDate;

        if(modDate < (now - _deleteIfOlderThanSeconds)) {
            [inFolder deleteFile:fileName];
        }
        else if(modDate > newest && 
                modDate > (now - _reuseIfNewerThanSeconds)) {
                
            FLSetObjectWithRetain(outFilePath, fileName);
            newest = modDate;
        }
    
    }];
    
    return outFilePath ? [FLLogFile logFile:[inFolder pathForFile:outFilePath]] : nil;
}

- (void) _openLogFile {
  
// TODO: be smarter about reusing/appending to existing files, e.g. new file every 24 hours, etc..  
    
    if(!_logFile) {
        if(_userName) {
        
            self.logFile = [self findNewestAndDeleteOldestInFolder:[self _userLogFolder]];
            if(!self.logFile) {
                NSString* filePath = [[self _userLogFolder] pathForFile:[NSString stringWithFormat:@"%@.%@.%f.txt", 
                    _appName,
                    _userName,
                    [NSDate timeIntervalSinceReferenceDate]]];
            
                self.logFile = [FLLogFile logFile:filePath];
            }
        }
        else {
            [_appLogsFolder createIfNeeded]; 
            
            self.logFile = [self findNewestAndDeleteOldestInFolder:_appLogsFolder];
            if(!self.logFile) {
                NSString* filePath = [_appLogsFolder pathForFile:[NSString stringWithFormat:@"%@.%f.txt", 
                    _appName,
                    [NSDate timeIntervalSinceReferenceDate]]];
            
                self.logFile = [FLLogFile logFile:filePath];
            }
        }
    }
}

- (void) logString:(NSString*) string {

    [[FLDispatchQueue fifoQueue] queueBlock:^{
        if(!_logFile) {
            [self _openLogFile];
        }
        
        [self.logFile logString:_stringFormatter(string)];
    }
    completion:nil];
}

- (NSArray*) allUserLogFilePaths {
    return _userName ? [[self _userLogFolder] allPathsInFolder] : 0;
}

- (NSArray*) allAppLogFilePaths {
    return [_appLogsFolder allPathsInFolder];
}

@end
