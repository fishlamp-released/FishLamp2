//
//  FLToolArgument.h
//  FishLampCommandLineTool
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampCore.h"
#import "FLCommandLineArgument.h"

@class FLCommandLineTool;

typedef void (^FLToolTaskBlock)(FLCommandLineArgument* argument, FLCommandLineTool* tool);

@interface FLToolTask : NSObject {
@private
    NSMutableSet* _argumentKeys;
    NSString* _taskDescription; 
    NSString* _taskName;
    FLToolTaskBlock _taskBlock;
}

@property (readwrite, strong, nonatomic) NSString* taskDescription;

@property (readwrite, copy, nonatomic) FLToolTaskBlock taskBlock;

// by default, the name is the first key.
@property (readwrite, strong, nonatomic) NSString* taskName;

@property (readonly, strong, nonatomic) NSSet* taskArgumentKeys;

- (id) initWithKeys:(NSString*) name;
+ (id) toolTask:(NSString*) keys;
+ (id) toolTask;

- (void) addKeys:(NSString*) keys; // space and/or comma delimited.

- (void) runWithArgument:(FLCommandLineArgument*) argument 
                  inTool:(FLCommandLineTool*) tool;

- (NSString*) buildUsageString;
- (void) printHelpToStringFormatter:(FLStringFormatter*) formatter;

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

