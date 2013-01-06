//
//  FLToolArgument.h
//  FishLampCommandLineTool
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampCore.h"
#import "FLCommandLineArgument.h"
#import "FLTool.h"

@interface FLToolTask : NSObject {
@private
}

@property (readonly, strong) NSString* helpDescription;

- (NSArray*) argumentKeys;

+ (id) toolTask;

- (void) runWithArgument:(FLCommandLineArgument*) argument inTool:(FLTool*) tool;

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


@end

