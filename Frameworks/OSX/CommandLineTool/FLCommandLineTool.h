//
//  FLCommandLineTool.h
//  FishLampCommandLineTool
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#import "FLCocoaRequired.h"
#import "FLCommandLineProcessor.h"
#import "FLStringFormatter.h"
#import "FLStringParser.h"
#import "FLToolCommand.h"
#import "FLLogger.h"

@interface FLCommandLineTool : FLCommandLineProcessor {
@private
    NSURL* _toolPath;
    NSString* _startDirectory;
    NSString* _toolName;
}

@property (readonly, strong, nonatomic) NSURL* toolPath;
@property (readonly, strong, nonatomic) NSString* startDirectory;
@property (readwrite, strong, nonatomic) NSString* currentDirectory;

@property (readonly, strong, nonatomic) NSString* toolName;

- (id) initWithToolName:(NSString*) name;

// call this from your main.
- (int) runFromMain:(int) argc argv:(const char*[]) argv;
// or
- (int) runWithArguments:(NSArray*) arguments;

- (NSString*) getInputString:(NSString*) prompt maxLength:(NSUInteger) maxLength;
- (NSString*) getPassword:(NSString*) prompt;
@end


