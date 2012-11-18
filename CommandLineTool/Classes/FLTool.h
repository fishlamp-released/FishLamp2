//
//  FLTool.h
//  FishLampCommandLineTool
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLCommandLineArgument.h"
#import "FLCommandLineParser.h"
#import "FLToolTask.h"

extern NSString* const FLToolDefaultKey;

@protocol FLToolDelegate;

@interface FLTool : NSObject {
@private
    __unsafe_unretained id<FLToolDelegate> _delegate;
    NSMutableDictionary* _tasks;
    NSString* _toolName;
    NSString* _startDirectory;
}
FLSingletonProperty(FLTool);

@property (readwrite, strong) NSString* toolName;
@property (readwrite, assign) id<FLToolDelegate> delegate;
@property (readonly, strong) NSDictionary* tasks;

- (void) setToolTask:(FLToolTask*) task forKeys:(NSArray*) keys;
- (void) addToolTask:(FLToolTask*) task;
- (void) setDefaultToolTask:(FLToolTask*) task;

- (FLToolTask*) toolTaskForKey:(NSString*) key;

// utils

@property (readonly, strong) NSString* startDirectory;
@property (readwrite, strong) NSString* currentDirectory;

- (void) openURL:(NSString *)url inBackground:(BOOL)background;
- (void) openFileInDefaultEditor:(NSString*) path;

- (NSError*) runToolWithParameters:(NSArray*) parameters;

@end

@protocol FLToolDelegate <NSObject>
- (id<FLCommandLineParser>) toolWillRun:(FLTool*) tool;

@optional
- (void) tool:(FLTool*) tool willRunWithArguments:(NSArray*) commandLineArgumentArray;

- (void) tool:(FLTool*) tool didFinishWithError:(NSError*) error;

@end

extern int FLToolMain(int argc, const char *argv[], Class delegateClass);
