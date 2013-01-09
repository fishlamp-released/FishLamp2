//
//  FLToolArgument.m
//  FishLampCommandLineTool
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLToolTask.h"
#import "FLCommandLineTool.h"
#import "NSString+Lists.h"

@implementation FLToolTask

@synthesize taskName = _taskName;
@synthesize taskDescription = _taskDescription;
@synthesize taskBlock = _taskBlock;
@synthesize taskArgumentKeys = _argumentKeys;

- (id) initWithKeys:(NSString*) keys {
    self = [super init];
    if(self) {
        _argumentKeys = [[NSMutableSet alloc] init];
    
        if(keys) {
            [self addKeys:keys];
        }
        
        self.taskDescription = @"";

    }
    return self;
}

- (id) init {
    return [self initWithKeys:nil];
}

+ (id) toolTask {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (id) toolTask:(NSString*) name {
    return FLAutorelease([[[self class] alloc] initWithKeys:name]);
}

- (void) runWithArgument:(FLCommandLineArgument*) argument 
                  inTool:(FLCommandLineTool*) tool {

    if(_taskBlock) {
        _taskBlock(argument, tool);
    }
}

#if FL_MRC
- (void) dealloc {
    [_toolTaskBlock release];
    [_taskDescription release];
    [_name release];
    [_argumentKeys release];
    [super dealloc];
}
#endif

- (void) setName:(NSString*) name {
    FLSetObjectWithRetain(_taskName, [name lowercaseString]);
}

- (void) addKeys:(NSString*) keys {
    NSArray* list = [keys componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@", "]];
    
    for(NSString* key in list) {
        [_argumentKeys addObject:[key lowercaseString]];
    }
    if(!self.taskName) {
        self.taskName = [list objectAtIndex:0];
    }
}

- (NSString*) buildUsageString {
    return [NSString concatStringArray:self.taskArgumentKeys.allObjects];
}

- (void) printHelpToStringFormatter:(FLStringFormatter*) output {

    [output appendLineWithFormat:@"  %@ %@: %@",    [self.taskName stringWithPadding:20], 
                                                        [[NSString concatStringArray:self.taskArgumentKeys.allObjects] stringWithPadding:20], 
                                                        [self taskDescription]];


}

@end



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


