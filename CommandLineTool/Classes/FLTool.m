//
//  FLToolApplication.m
//  FishLampTools
//
//  Created by Fullerton Mike on 5/5/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLTool.h"
#import "NSFileManager+FLExtras.h"
#import "FLStringUtils.h"
#import "FLErrorDomain.h"
//FLDeclareErrorDomain(FLToolApplicationErrorDomain);

FLDeclareErrorDomain(FLToolApplicationErrorDomain);

FLSynthesizeErrorDomain(FLToolApplicationErrorDomain, @"com.fishlamp.commandlinetool");

NSString* const FLToolDefaultKey = @"--default-task";

@interface FLTool ()
@property (readwrite, strong) id<FLCommandLineParser> parser;
@property (readonly, strong) NSDictionary* tasks;
@end

@interface FLToolTask (Internal)
+ (void) setStartDirectory:(NSString*) directory;
@end

@implementation FLTool

synthesize_(tasks)
synthesize_(parser);

- (id) init {
    self = [super init];
    if(self) {
        _tasks = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (id) initWithCommandLineParser:(id<FLCommandLineParser>) parser {
    
    self = [super init];
    if(self) {
        self.parser = parser;
        _tasks = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

dealloc_(
    [_parser release];
    [_tasks release];
)

- (FLToolTask*) taskForKey:(NSString*) key {
    return [_tasks objectForKey:key];
}

- (NSString*) toolName {
    return nil;
}

- (void) setDefaultTask:(FLToolTask*) task {
    [self setTask:task forKeys:[NSArray arrayWithObject:FLToolDefaultKey]];
}

- (void) setTask:(FLToolTask*) task forKeys:(NSArray*) keys {
    
    FLAssertIsNotNil_(task);
    FLAssertIsNotNil_(keys);
    
    for(NSString* key in keys) {
        id existing = [_tasks objectForKey:key];
        FLConfirmIsNil_v(existing, @"task already installed for key: %@", key);
        [_tasks setObject:task forKey:key];
    }
    
    [self willAddWorker:task];
}

- (void) runToolTasksWithArguments:(NSArray*) arguments {
    for(FLCommandLineArgument* arg in arguments) {
        FLToolTask* task = [_tasks objectForKey:arg.key];
        FLConfirmIsNotNil_v(task, @"Unknown argument: %@", arg.key);
        
//        task.argument = arg;
//        [task runSynchronously];
//        FLThrowError(task.error);
    }

    if(!arguments || arguments.count == 0) {
        FLToolTask* task = [self taskForKey:FLToolDefaultKey];
        if(task) {
//            [task runSynchronously];
//            FLThrowError(task.error);
        }
    }
}


- (int) runWithParameters:(NSArray*) parameters {
    @try {
        [FLToolTask setStartDirectory:parameters.firstObject];
        NSArray* args = [self.parser parseArguments:[parameters subarrayWithRange:NSMakeRange(1, parameters.count - 1)]];
        [self runToolTasksWithArguments:args];
    }
    @catch(NSException* ex) {
        FLLog(@"Failed: %@", ex.reason);
        return 1;
    }
    
    return 0;
}

@end

@implementation FLToolTask (Internal)

static NSString* s_startDirectory;

+ (void) setStartDirectory:(NSString*) directory {
    FLRetainObject_(s_startDirectory, directory);
}

@end

@implementation FLToolTask (Utils)
- (NSString*) startDirectory {
    return s_startDirectory;
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