//
//  FLCommandLineTool.h
//  FishLampCommandLineTool
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLCommandLineArgument.h"
#import "FLResult.h"
#import "FLStringFormatter.h"
#import "FLCommandLineParser.h"
#import "FLToolTask.h"

extern NSString* const FLToolDefaultKey;

@class FLToolTask;
@protocol FLCommandLineToolDelegate;

@interface FLCommandLineTool : NSObject {
@private
    NSMutableDictionary* _tasks;
    NSString* _toolName;
    NSString* _startDirectory;
    NSString* _toolPath;
    FLStringFormatter* _output;
    id<FLCommandLineParser> _parser;
}

+ (id) commandLineTool;

// set these as needed
@property (readwrite, strong) id<FLCommandLineParser> parser;
@property (readwrite, strong) NSString* toolPath;
@property (readwrite, strong) FLStringFormatter* output;

// tasks.
@property (readonly, strong) NSDictionary* tasks;
- (void) addToolTask:(FLToolTask*) task;
- (void) setDefaultToolTask:(FLToolTask*) task;
- (FLToolTask*) toolTaskForKey:(NSString*) key;

- (void) runTaskWithArgument:(FLCommandLineArgument*) argument ;

// utils
- (void) openURL:(NSString *)url inBackground:(BOOL)background;
- (void) openFileInDefaultEditor:(NSString*) path;

- (FLResult) processString:(NSString*) string 
                withOutput:(FLStringFormatter*) formatter;

- (FLResult) processStringArray:(NSArray*) inputStrings 
                withOutput:(FLStringFormatter*) formatter;

// these are only really relevant for a shell tool
@property (readwrite, strong) NSString* toolName;
@property (readonly, strong) NSString* toolDirectory;
@property (readwrite, strong) NSString* currentDirectory;

+ (NSString*) startDirectory;

// optional overrides. or have your tasks execute your stuff.

- (void) willRunWithArguments:(NSArray*) commandLineArgumentArray;

- (void) didRunWithArguments:(NSArray*) commandLineArgumentArray;

- (void) didFailWithError:(NSError*) error;

@end

// std help task. not automatically added.

@interface FLHelpTask : FLToolTask
@end

@interface FLUsageTask : FLToolTask
@end

