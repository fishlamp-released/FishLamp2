//
//  FLLogFileManager.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/7/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#import "FLFolder.h"
#import "FLLogFile.h"

typedef NSString* (^FLLogFileStringFormatter)(NSString* string);

@interface FLLogFileManager : NSObject {
@private
    FLFolder* _appLogsFolder;
    FLLogFile* _logFile;
    NSString* _userName;
    NSString* _appName;
    
    FLLogFileStringFormatter _stringFormatter;
    
    NSTimeInterval _deleteIfOlderThanSeconds;
    NSTimeInterval _reuseIfNewerThanSeconds;
}

@property (readwrite, assign, nonatomic) NSTimeInterval deleteIfOlderThanSeconds;

@property (readwrite, assign, nonatomic) NSTimeInterval reuseIfNewerThanSeconds;


@property (readwrite, copy, nonatomic) FLLogFileStringFormatter stringFormatter; // by default "[DATE]: String\n"

FLSingletonProperty(FLLogFileManager);

- (void) logString:(NSString*) string;

- (NSArray*) allUserLogFilePaths;

@end
