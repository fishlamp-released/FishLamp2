//
//  FLToolApplication.m
//  FishLampTools
//
//  Created by Fullerton Mike on 5/5/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLTool.h"
#import "FLStringUtils.h"
#import "FLErrorDomain.h"
#import "FLToolTask_Internal.h"

//@interface FLToolApplicationErrorDomainObject : FLErrorDomain<FLErrorDomainSubclass>
//@end
//
//
//@implementation FLToolApplicationErrorDomainObject 
//
//@end


NSString* const FLToolDefaultKey = @"--default-task";

@interface FLTool ()
//@property (readwrite, strong) NSString* startDirectory;
@end

@implementation FLTool

@synthesize toolPath = _toolPath;
@synthesize tasks = _tasks;
@synthesize delegate = _delegate;
@synthesize startDirectory = _startDirectory;
@synthesize toolName = _toolName;

- (id) init {
    self = [super init];
    if(self) {
        _tasks = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

+ (id) tool {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {

    [_tasks release];
    [_toolName release];
    [_startDirectory release];
    [super dealloc];
}
#endif

- (FLToolTask*) toolTaskForKey:(NSString*) key {
    return [_tasks objectForKey:key];
}

- (void) setDefaultToolTask:(FLToolTask*) task {
    [self setToolTask:task forKeys:[NSArray arrayWithObject:FLToolDefaultKey]];
    [self setToolTask:task forKeys:task.argumentKeys];
}

- (void) setToolTask:(FLToolTask*) task forKeys:(NSArray*) keys {
    
    FLAssertIsNotNil_(task);
    FLAssertIsNotNil_(keys);
    
    for(NSString* key in keys) {
        id existing = [_tasks objectForKey:key];
        FLConfirmIsNil_v(existing, @"task already installed for key: %@", key);
        [_tasks setObject:task forKey:key];
    }
}

- (NSString*) toolDirectory {
    return [self.toolPath stringByDeletingLastPathComponent];
}

- (void) addToolTask:(FLToolTask*) task {
    [self setToolTask:task forKeys:[task argumentKeys]];
}

- (void) runToolTasksWithArguments:(NSArray*) arguments {

    FLPerformSelector2(self.delegate, @selector(tool:willRunWithArguments:), self, arguments);

    for(FLCommandLineArgument* arg in arguments) {
        FLToolTask* task = [_tasks objectForKey:arg.key];
        [task runWithArgument:arg inTool:self];
    }

    if(!arguments || arguments.count == 0) {
        FLToolTask* task = [self toolTaskForKey:FLToolDefaultKey];
        if(task) {
            [task runWithArgument:[FLCommandLineArgument commandLineArgument:FLToolDefaultKey] inTool:self];
        }
    }

    FLPerformSelector2(self.delegate, @selector(tool:didRunWithArguments:), self, arguments);
}

- (NSArray*) parseArgumentsFromParameters:(NSArray*) parameters withParser:(id<FLCommandLineParser>) parser {
    if(parser) {
        return [parser parseArguments:parameters];
    }
    
    NSMutableArray* args = [NSMutableArray array];
    for(NSString* parm in parameters) {
        [args addObject:[FLCommandLineArgument commandLineArgument:parm]];
    }
    return args;
}

- (NSError*) runToolWithParameters:(NSArray*) parameters {

   @try {
        id<FLCommandLineParser> parser = [self.delegate toolWillRun:self];
    
        NSArray* args = [self parseArgumentsFromParameters:parameters withParser:parser];

        [self runToolTasksWithArguments:args];

    }
    @catch(NSException* ex) {
        
        FLPerformSelector2(self.delegate, @selector(tool:didFailWithError:), self, ex.error);
        FLLog(@"Failed: %@", ex.reason);
        return ex.error;
    }
    
    return nil;
}

- (void) setCurrentDirectory:(NSString*) newDirectory {

// TODO: this returns a BOOL? Check it?
    [[NSFileManager defaultManager] changeCurrentDirectoryPath:newDirectory];
}

- (NSString*) currentDirectory {
    return [[NSFileManager defaultManager] currentDirectoryPath];
}

- (void) openURL:(NSString *)url inBackground:(BOOL)background {
    if (background) {
        NSArray* urls = [NSArray arrayWithObject:[NSURL URLWithString:url]];
        [[NSWorkspace sharedWorkspace] openURLs:urls withAppBundleIdentifier:nil options:NSWorkspaceLaunchWithoutActivation additionalEventParamDescriptor:nil launchIdentifiers:nil];    
    }
    else {
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:url]];
    }
}

- (void) openFileInDefaultEditor:(NSString*) path {
    [[NSWorkspace sharedWorkspace] openFile:path];
}



@end




//- (void) _wait:(FLArgumentHandler*) handler {
//
//    NSTimeInterval pause = [handler.inputData floatValue];
//    FLLog(@"Pausing for %f seconds", pause);
//    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
//    
//    while([NSDate timeIntervalSinceReferenceDate] < (start + pause)) {
//        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];
//    }
//}

//- (void) addInputHandlers {
//    [self addInputHandler:[FLArgumentHandler argumentHandler:@"-?,--help,-h,?"
//                                            inputFlags:0
//                                           description:@"prints this help"
//                                              selector:@selector(willPrintHelp:)]];
//
//    [self addInputHandler:[FLArgumentHandler argumentHandler:@"-u,--usage"
//                                            inputFlags:0
//                                           description:@"prints usage"
//                                              selector:@selector(willPrintUsage:)]];
//    
//    [self addInputHandler:[FLArgumentHandler argumentHandler:@"--debug"
//                                            inputFlags:0
//                                           description:@"Prints debugging info during run"
//                                         callbackBlock: ^(id sender) { self.toolMode = FLToolModeSet(self.toolMode, FLToolModeDebug); }]];
//
//    [self addInputHandler:[FLArgumentHandler argumentHandler:@"--wait"
//                                            inputFlags:FLArgumentIsExpectingData
//                                           description:@"Wait for x seconds"
//                                         selector:@selector(_wait:)]];
//
//
//}

//- (void) addWthParameter {
//    
//    [self addInputHandler:[FLArgumentHandler argumentHandler:@"--wth"
//                                            inputFlags:0
//                                           description:@"Don't invoke this option. You've been warned."
//                                         callbackBlock:^(id sender) {
//                                            [self openURL:@"http://r33b.net/" inBackground:NO];
//                                            } ]];
//}



//- (void) willPrintHelp:(id) sender {
//    FLLog(@"%@ Help:", self.toolName);
//    FLLog(self.helpBlurb);
//    FLLog(@"");
//    [self willPrintUsage:sender];
//}

//- (void) willPrintUsage:(id) sender {
//    FLLog(@"%@ Usage:", self.toolName);
//    for(FLArgumentHandler* handler in _argumentHandlers) {
//        NSString* inputParms = [[NSString stringWithFormat:@"%@:", handler.inputParametersAsString] stringWithPadding:40];
//        FLLog(@"%@%@", inputParms, handler.helpDescription);
//    }
//}

//- (FLToolTask*) taskForArgument:(FLCommandLineArgument*) argument {
//
//    for(FLToolTask* task in _tasks) {
//        if([task hasInputParameter:argument.key]) {
//            return task;
//        }
//    }
//    
//    return nil;
//}

//- (NSString*) inputParametersAsString {
//    NSMutableString* string = [NSMutableString string];
//    for(NSString* str in self.inputKeys) {
//    
//        if(string.length) {
//            [string appendFormat:@", %@", str];
//        } else {
//            [string appendString:str];
//        }
//    }
//    return [NSString stringWithFormat:@"[%@]", string];
//}

//- (void) _parseParameters:(NSArray*) input {
//    
//    NSMutableDictionary* handlers = [NSMutableDictionary dictionaryWithCapacity:self.argumentHandlers.count];
//
//    self.toolDirectory = input.firstObject;
//    
//    for(int i = 1; i < input.count; i++) {
//        NSString* parm = [input objectAtIndex:i];
//        FLArgumentHandler* handler = [self argumentHandlerForParameter:parm];
//
//        if(!handler) {
//            FLThrowErrorCode_v([FLToolApplicationErrorDomain instance], FLToolApplicationErrorCodeUnknownParameter, @"Unknown parameter: %@. Try -? for help. Or -u for usage.", parm);
//        }
//        
//        id data = nil;
//
//        if(handler.flags.isExpectingData) {
//            if(i + 1 >= input.count) {
//                FLThrowErrorCode_v([FLToolApplicationErrorDomain instance], FLToolApplicationErrorCodeMissingDataForParameter, @"Expecting data following %@ parameter. Try -? for help. Or -u for usage.", parm);
//            }
//        
//            NSString* nextParm = [input objectAtIndex:++i];
//            if([self argumentHandlerForParameter:nextParm] != nil) {
//                FLThrowErrorCode_v([FLToolApplicationErrorDomain instance], FLToolApplicationErrorCodeMissingDataForParameter, @"Expecting data following %@ parameter, got parameter %@ instead. Try -? for help. Or -u for usage.", parm, nextParm);
//            }
//            
//            data = nextParm;
//        }
//   
//        //check for duplicates
//        for(NSString* aParm in handler.inputKeys) {
//            FLArgumentHandler* unwantedHandler = [handlers objectForKey:aParm];
//            if(unwantedHandler != nil) {
//                FLThrowErrorCode_v( [FLToolApplicationErrorDomain instance],
//                        FLToolApplicationErrorCodeDuplicateParameter, 
//                        @"Duplicate parameter %@ (already got %@). Try -? for help. Or -u for usage.", 
//                        aParm, 
//                        unwantedHandler.inputParametersAsString);
//            }
//        }
//
//        if(data) {
//            [handler prepare:data];
//        }
//        
//        for(NSString* key in handler.inputKeys) {
//            [handlers setObject:handler forKey:key];
//            [handlers setObject:handler forKey:[key stringByReplacingOccurrencesOfString:@"-" withString:@""]];
//        }
//        
//        handler.didFire = YES;
//    }
//
//    // check for incompatible parameters
//    FLArgumentHandler* last = nil;
//    for(FLArgumentHandler* handler in handlers.objectEnumerator) {
//        if(handler && last) {
//            if(![handler isCompatibleWithInputHandler:last]) {
//                FLThrowErrorCode_v([FLToolApplicationErrorDomain instance], FLToolApplicationErrorIncompatibleParameters,
//                @"Parameters %@ and %@ can't be used together. Try -? for help. Or -u for usage.", last.inputParametersAsString, handler.inputParametersAsString);
//            }
//        }
//        last = handler;
//    }        
//
//    for(FLArgumentHandler* handler in _argumentHandlers) {
//        if(handler.flags.isRequired && !handler.didFire) {
//            FLThrowErrorCode_v(
//                [FLToolApplicationErrorDomain instance],
//                FLToolApplicationErrorCodeMissingRequiredParameter,
//                @"Missing required parameter: %@. Try -? for help. Or -u for usage.", handler.inputParametersAsString);
//        }
//    }
//
//    
//    self.arguments = handlers;
//}

//- (BOOL) didInvokeArgument:(NSString*) argumentKey {
//    return [self.arguments objectForKey:argumentKey] != nil;
//}
//
//- (id) parameterFromArgument:(NSString*) argumentKey {
//    return [[self.arguments objectForKey:argumentKey] inputData];
//}



//- (void) willInvokeHandlers:(NSDictionary*) handlers {
//    if(handlers) {
//        for(FLArgumentHandler* handler in handlers.objectEnumerator) {
//            if(handler.prepareCallback) {
//                [handler.prepareCallback invoke:handler];
//            }
//        }
//    }
//}
//
//- (void) willFinishWithHandlers:(NSDictionary*) handlers {
//    if(handlers) {
//        for(FLArgumentHandler* handler in handlers.objectEnumerator) {
//            if(handler.finishedCallback) {
//                [handler.finishedCallback invoke:handler];
//            }
//        }
//    }
//}

//- (void) didLaunchWithParameters:(NSArray*) input {
//    
//    [self _parseParameters:input];
//    
//    if(self.toolMode.debug) {
//        FLLog([input description]);
//    }
//
//    for(FLArgumentHandler* handler in self.arguments.objectEnumerator) {
//        [handler execute];
//    }
//    
//    for(FLArgumentHandler* handler in self.arguments.objectEnumerator) {
//        [handler finish];
//    }
//
//}

//- (void) onHandleError:(NSError*) error {
//    if(FLStringIsNotEmpty(error.localizedDescription)) {
//        FLLog(@"EPIC FAIL: %@", error.localizedDescription);
//    } 
//    else { 
//        FLLog(@"EPIC FAIL: %@", [error description]);
//    }
//}