//
//  FLTool.h
//  FishLampCommandLineTool
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWorker.h"
#import "FLCommandLineArgument.h"
#import "FLCommandLineParser.h"
#import "FLToolTask.h"

extern NSString* const FLToolDefaultKey;

@interface FLTool : FLWorker {
@private
    id<FLCommandLineParser> _parser;
    NSMutableDictionary* _tasks;
}

@property (readonly, strong) NSString* toolName;

@property (readonly, strong) id<FLCommandLineParser> parser;

- (id) initWithCommandLineParser:(id<FLCommandLineParser>) parser;

- (void) setTask:(FLToolTask*) task forKeys:(NSArray*) keys;
- (FLToolTask*) taskForKey:(NSString*) key;


- (int) runWithParameters:(NSArray*) parameters;

- (void) runToolTasksWithArguments:(NSArray*) arguments;

//- (FLToolTask*) taskForArgument:(FLCommandLineArgument*) argument;

@end

@interface FLToolTask (Utils)
@property (readwrite, strong) NSString* currentDirectory;
@property (readonly, strong) NSString* startDirectory;

- (void) openURL:(NSString *)url inBackground:(BOOL)background;
- (void) openFileInDefaultEditor:(NSString*) path;
@end
