//
//  FLToolArgument.h
//  FishLampCommandLineTool
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLSimpleWorker.h"
#import "FLCommandLineArgument.h"

@class FLTool;

@interface FLToolTask : FLSimpleWorker {
@private
    NSMutableArray* _inputKeys;
    NSMutableArray* _compatibleParameters;
    FLCommandLineArgument* _argument;
}

- (id) initWithInputKeys:(NSString*) spaceDelimitedList;

+ (id) toolTask;

@property (readonly, assign) FLTool* parentTool;
@property (readonly, strong) FLCommandLineArgument* argument;

//
// input parameters
//

// array of strings of input parameters
@property (readwrite, strong) NSArray* inputKeys;

// add a input key, like -f or --file
- (void) addInputKey:(NSString*) parm;

// @"-f --file --file-action" 
- (void) addInputKeys:(NSString*) spaceDelimitedList;

// do we own input parameters (this is case insensitive)
- (BOOL) hasInputParameter:(NSString*) parm;

// add required parameters
- (void) addRequiredParameter:(NSString*) parm;

//
// help (shown when usage is invoked.
// 

//
// compatible parameters, by default not compatible with other argumentHandlers
//
// compatible parameters list
@property (readonly, strong) NSArray* compatibleInputKeys;


// use FLInputHandlerCompatableWithAll to be compatabile with all, for example in a --verbose key
- (void) addCompatibleParameter:(NSString*) parameter; 

// check both for compatibility with each other
- (BOOL) isCompatibleWithTask:(FLToolTask*) task;

// just check if inputParameter (for another argumentHandler) is compatible with self
- (BOOL) isCompatibleWithParameter:(NSString*) argument;


- (void) willBeginWorkingWithArgument:(FLCommandLineArgument*) argument;

@property (readonly, strong) NSString* helpDescription;

@end

