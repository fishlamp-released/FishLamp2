//
//  FLLogFileManager.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/7/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"

#import "FLFolder.h"
#import "FLLogFile.h"
#import "FLService.h"

typedef NSString* (^FLLogFileStringFormatter)(NSString* string);

@interface FLLogFileManager : FLService {
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
