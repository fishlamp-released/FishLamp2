//
//  FLToolArgument.m
//  FishLampCommandLineTool
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLToolTask.h"
#import "FLToolTask_Internal.h"
#import "FLTool.h"

@implementation FLToolTask

synthesize_(parentTool)

+ (id) toolTask {
    return autorelease_([[[self class] alloc] init]);
}

- (NSArray*) parameterKeys {
    return nil;
}

- (NSString*) helpDescription {
    return nil;
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

@implementation FLToolTaskFinisher 
synthesize_(commandLineArgument)
dealloc_(
    [_commandLineArgument release];
    )

@end

