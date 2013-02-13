//
//  FLCommandLineTool.h
//  FishLampCommandLineTool
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLStringFormatter.h"
#import "FLParseableInput.h"
#import "FLToolCommand.h"
#if OSX

@interface FLCommandLineTool : NSObject {
@private
    NSURL* _toolPath;
    NSString* _startDirectory;
    NSString* _toolName;
//    NSMutableArray* _listeners;
    
    NSMutableDictionary* _commands;
}
@property (readonly, strong, nonatomic) NSString* toolName;

- (id) initWithToolName:(NSString*) name;

+ (id) commandLineTool;
+ (id) commandLineTool:(NSString*) toolName;

//@property (readonly, strong, nonatomic) NSArray* listeners;
//
//@property (readonly, strong, nonatomic) id rootListener;
//@property (readonly, strong, nonatomic) id listener;
//
//- (void) pushListener:(id<FLParseable>) task;
//
//- (id<FLParseable>) popListener; 
//- (void) popListenerToListener:(id<FLParseable>) task;
//- (void) popListenerToRootListener;

@property (readonly, strong, nonatomic) NSDictionary* commands;
- (void) addCommand:(FLToolCommand*) command;
- (void) parseInput:(FLParseableInput*) input output:(FLStringFormatter*) output;

// utils
- (void) openURL:(NSString *)url inBackground:(BOOL)background;
- (void) openFileInDefaultEditor:(NSString*) path;
@end

@interface FLCommandLineTool (ShellUtils)
// these are only really relevant for a shell tool
@property (readonly, strong, nonatomic) NSURL* toolPath;
@property (readonly, strong, nonatomic) NSString* startDirectory;
@property (readwrite, strong, nonatomic) NSString* currentDirectory;

- (void) setExecutingInShellAtPath:(NSURL*) url;
@end

#endif