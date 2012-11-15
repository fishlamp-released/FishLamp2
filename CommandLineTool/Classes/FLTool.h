//
//  FLTool.h
//  FishLampCommandLineTool
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLSimpleWorker.h"
#import "FLCommandLineArgument.h"
#import "FLCommandLineParser.h"
#import "FLToolTask.h"

@interface FLTool : FLSimpleWorker {
@private
    id<FLCommandLineParser> _parser;
    NSMutableArray* _tasks;
}

@property (readonly, strong) NSString* toolName;

@property (readonly, strong) NSArray* tasks;
@property (readonly, strong) id<FLCommandLineParser> parser;

- (id) initWithCommandLineParser:(id<FLCommandLineParser>) parser;

- (void) addTask:(FLToolTask*) task;

- (int) runWithParameters:(NSArray*) parameters;

- (void) runToolTasksWithArguments:(NSArray*) arguments;

- (FLToolTask*) taskForArgument:(FLCommandLineArgument*) argument;
- (FLToolTask*) taskForKey:(NSString*) key;

@end

@interface FLToolTask (Utils)
@property (readwrite, strong) NSString* currentDirectory;
@property (readonly, strong) NSString* startDirectory;

- (void) openURL:(NSString *)url inBackground:(BOOL)background;
- (void) openFileInDefaultEditor:(NSString*) path;
@end
