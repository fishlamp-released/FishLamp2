//
//  FLToolArgument.h
//  FishLampCommandLineTool
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWorker.h"
#import "FLCommandLineArgument.h"

@class FLTool;

@interface FLToolTask : FLWorker {
@private
    __unsafe_unretained FLTool* _parentTool;
}

@property (readonly, assign) FLTool* parentTool;

// array of strings of input parameters
@property (readonly, strong) NSString* helpDescription;

- (NSArray*) parameterKeys;

+ (id) toolTask;

// utils


//// do we own input parameters (this is case insensitive)
//- (BOOL) hasInputParameter:(NSString*) parm;
//
//// add required parameters
//- (void) addRequiredParameter:(NSString*) parm;

//
// help (shown when usage is invoked.
// 

//
// compatible parameters, by default not compatible with other argumentHandlers
//
// compatible parameters list
//@property (readonly, strong) NSArray* compatibleInputKeys;
//
//
//// use FLInputHandlerCompatableWithAll to be compatabile with all, for example in a --verbose key
//- (void) addCompatibleParameter:(NSString*) parameter; 
//
//// check both for compatibility with each other
//- (BOOL) isCompatibleWithTask:(FLToolTask*) task;
//
//// just check if inputParameter (for another argumentHandler) is compatible with self
//- (BOOL) isCompatibleWithParameter:(NSString*) argument;
//
//
//- (id<FLPromisedResult>) startTaskWithArgument:(FLCommandLineArgument*) argument 
//                                           completion:(FLCompletionBlock) completionBlock;


@end


@interface FLToolTaskFinisher : FLFinisher {
@private
    FLCommandLineArgument* _commandLineArgument;
}

@property (readwrite, strong) FLCommandLineArgument* commandLineArgument;


@end