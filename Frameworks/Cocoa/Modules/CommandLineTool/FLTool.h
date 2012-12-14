//
//  FLTool.h
//  FishLampCommandLineTool
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCore.h"
#import "FLCommandLineArgument.h"
#import "FLCommandLineParser.h"

extern NSString* const FLToolDefaultKey;

@class FLToolTask;
@protocol FLToolDelegate;

@interface FLTool : NSObject {
@private
    __unsafe_unretained id<FLToolDelegate> _delegate;
    NSMutableDictionary* _tasks;
    NSString* _toolName;
    NSString* _startDirectory;
    NSString* _toolPath;
}

+ (id) tool;

@property (readwrite, strong) NSString* toolName;
@property (readwrite, assign) id<FLToolDelegate> delegate;

@property (readonly, strong) NSDictionary* tasks;

- (void) setToolTask:(FLToolTask*) task forKeys:(NSArray*) keys;
- (void) addToolTask:(FLToolTask*) task;
- (void) setDefaultToolTask:(FLToolTask*) task;

- (FLToolTask*) toolTaskForKey:(NSString*) key;

// utils

@property (readwrite, strong) NSString* toolPath;
@property (readonly, strong) NSString* toolDirectory;

@property (readwrite, strong) NSString* startDirectory;
@property (readwrite, strong) NSString* currentDirectory;

- (void) openURL:(NSString *)url inBackground:(BOOL)background;
- (void) openFileInDefaultEditor:(NSString*) path;

- (NSError*) runToolWithParameters:(NSArray*) parameters;

@end

@protocol FLToolDelegate <NSObject>
- (id<FLCommandLineParser>) toolWillRun:(FLTool*) tool;

@optional
- (void) tool:(FLTool*) tool willRunWithArguments:(NSArray*) commandLineArgumentArray;
- (void) tool:(FLTool*) tool didRunWithArguments:(NSArray*) commandLineArgumentArray;
- (void) tool:(FLTool*) tool didFailWithError:(NSError*) error;

@end

//extern FLErrorDomain* FLToolApplicationErrorDomain;
