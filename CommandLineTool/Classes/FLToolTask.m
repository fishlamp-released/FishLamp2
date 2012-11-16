//
//  FLToolArgument.m
//  FishLampCommandLineTool
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLToolTask.h"
#import "FLTool.h"

@interface FLToolTask ()
@property (readwrite, strong) FLCommandLineArgument* argument;
@end

@implementation FLToolTask

synthesize_(argument);

- (id) init {
    self = [super init];
    if(self){
//        _inputKeys = [[NSMutableArray alloc] init];
//        _compatibleParameters = [[NSMutableArray alloc] init];
    }
    return self;
}

//- (id) initWithInputKeys:(NSString*) spaceDelimitedList {
//    self = [self init];
//    if(self) {
//        [self addInputKeys:spaceDelimitedList];
//    }
//    return self;
//}

+ (id) toolTask {
    return autorelease_([[[self class] alloc] init]);
}

- (void) willBeginWorkingWithArgument:(FLCommandLineArgument*) argument {
    self.argument = argument;
}

//- (id<FLPromisedResult>) startTaskWithArgument:(FLCommandLineArgument*) argument 
//                                    completion:(FLCompletionBlock) completionBlock {
//                                           
//    self.argument = argument;
//}                                           

dealloc_(
//    [_inputKeys release];
//    [_compatibleParameters release];
    [_argument release];
    );
 
//- (void) addInputKeys:(NSString*) spaceDelimitedList {
//    NSArray* keys = [spaceDelimitedList componentsSeparatedByString:@" "];
//    for(NSString* key in keys) {
//        [self addInputKey:key];
//    }
//}

+ (NSArray*) defaultInputKeys {
    return nil;
}

- (NSString*) helpDescription {
    return nil;
}

- (FLTool*) parentTool {
    return (FLTool*) self.parentWorker;
}

//- (void) addCompatibleParameter:(NSString*) parameter {
//    
//    FLAssertIsNotNil_(parameter);
//
//    if(!_compatibleParameters) {
//        _compatibleParameters = [[NSMutableArray alloc] init];
//    }
//    
//    [_compatibleParameters addObject:parameter];
//}
//
//- (void) addRequiredParameter:(NSString*) parm {
//
//}
//
//- (void) addInputKey:(NSString*) parm {
//    [_inputKeys addObject:parm];
//}
//
//- (BOOL) hasInputParameter:(NSString*) parm {
//    for(NSString* p in self.inputKeys) {
//        if(FLStringsAreEqualCaseInsensitive(p, parm)) {
//            return YES;
//        }
//    }
//
//    return NO;
//}
//
//- (BOOL) isCompatibleWithParameter:(NSString*) argument {
//    
//    if(FLStringsAreEqual(@"*", argument) || self.compatibleInputKeys.count == 0) {
//        return YES;
//    }
//
//    for(NSString* p in self.compatibleInputKeys) {
//        if(FLStringsAreEqualCaseInsensitive(p, argument) || FLStringsAreEqual(p, @"*")) {
//            return YES;
//        }
//    }
//    
//    return NO;
//}
//
//- (BOOL) isCompatibleWithTask:(FLToolTask*) task {
//    
//    for(NSString* p in self.inputKeys) {
//        if([task isCompatibleWithParameter:p]) {
//            return YES;
//        }
//    }
//    
//    for(NSString* p in task.inputKeys) {
//        if([self isCompatibleWithParameter:p]) {
//            return YES;
//        }
//    }
//    
//    return NO;
//}


@end

