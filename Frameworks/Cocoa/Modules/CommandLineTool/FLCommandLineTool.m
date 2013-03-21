//
//  FLToolApplication.m
//  FishLampTools
//
//  Created by Fullerton Mike on 5/5/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLCommandLineTool.h"
#import "FLStringUtils.h"
#import "FLErrorDomainInfo.h"
#import "FLResult.h"
#import "NSString+Lists.h"

#import "FLUsageToolTask.h"
#import "FLHelpToolTask.h"

#if OSX

@interface FLCommandLineTool ()
//@property (readwrite, strong) NSString* startDirectory;
@property (readwrite, strong, nonatomic) NSURL* toolPath;
@property (readwrite, strong, nonatomic) NSString* toolName;

//@property (readonly, strong, nonatomic) NSURL* toolPath;
@property (readwrite, strong, nonatomic) NSString* startDirectory;
@property (readwrite, strong, nonatomic) NSString* currentDirectory;



@end

//@interface FLRootToolTask : FLToolTask
//@end
//
//@implementation FLRootToolTask
//
//- (void) printHelpToStringFormatter:(FLStringFormatter*) output {
//}
//
//- (NSString*) taskName {
//    return self.tool.toolName;
//}
//
//@end

@implementation FLCommandLineTool

//@synthesize listeners = _listeners;
@synthesize toolPath = _toolPath;
@synthesize toolName = _toolName;
@synthesize startDirectory = _startDirectory;
@synthesize commands = _commands;


- (id) initWithToolName:(NSString*) name {
    self = [super init];
    if(self) {
        self.toolName = name;
//        _listeners = [[NSMutableArray alloc] init];

        _commands = [[NSMutableDictionary alloc] init];

//        [self pushListener:[FLRootToolTask toolTask:@"Root"]];
        
//        [self.listener addToolTask:[FLUsageToolTask toolTask]];
//        [self.listener addToolTask:[FLHelpToolTask toolTask]];
    }
    
    return self;
}

- (id) init {
    return [self initWithToolName:nil];
}

+ (id) commandLineTool {
    return FLAutorelease([[[self class] alloc] initWithToolName:nil]);
}

+ (id) commandLineTool:(NSString*) toolName {
    return FLAutorelease([[[self class] alloc] initWithToolName:toolName]);
}

#if FL_MRC
- (void) dealloc {
    [_toolPath release];
    [_toolName release];
//    [_listeners release];
    [_commands release];
    [super dealloc];
}
#endif

- (void) setExecutingInShellAtPath:(NSURL*) url {
    self.toolPath = url;
    self.startDirectory = [[NSFileManager defaultManager] currentDirectoryPath];
}

//- (void) pushListener:(id<FLParseable>) task {
//    [_listeners addObject:task];
//    FLPerformSelector1(task, @selector(setParent:), self);
//}
//
//- (id<FLParseable>) popListener {
//    return [_listeners dequeueLastObject];
//}
//
//- (id<FLParseable>) listener {
//    return [_listeners lastObject];
//}
//
//- (id<FLParseable>) rootListener {
//    return [_listeners firstObject];
//}
//
//- (void) popListenerToListener:(id<FLParseable>) task {
//    NSUInteger idx = [_listeners indexOfObject:task];
//    if(idx != NSNotFound) {
//        [_listeners removeObjectsInRange:NSMakeRange(idx, _listeners.count - idx)];
//    }
//}
//
//- (void) popListenerToRootListener {
//    [self popListenerToListener:[_listeners firstObject]];
//}

- (void) addCommand:(FLToolCommand*) command {
    [_commands setObject:command forKey:[command.commandName lowercaseString]];
}

- (void) parseInput:(FLParseableInput*) input output:(FLStringFormatter*) output {
    
    NSString* key = [[input next] lowercaseString];
    if(!key) {
        // handle default case
    }
    else {
        FLToolCommand* command = [_commands objectForKey:key];
        FLConfirmNotNilWithComment(command, @"Unknown command: %@", key);
        [command parseInput:input];
        
        FLConfirmWithComment(input.last == nil, @"unhandled parameters: %@", input.unparsed);
    }
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

- (void) setCurrentDirectory:(NSString*) newDirectory {

// TODO: this returns a BOOL? Check it?
    [[NSFileManager defaultManager] changeCurrentDirectoryPath:newDirectory];
}

- (NSString*) currentDirectory {
    return [[NSFileManager defaultManager] currentDirectoryPath];
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

//- (id<FLParseable>) taskForArgument:(FLCommandLineArgument*) argument {
//
//    for(id<FLParseable> task in _listeners) {
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
//            FLThrowErrorCodeWithComment([FLToolApplicationErrorDomain instance], FLToolApplicationErrorCodeUnknownParameter, @"Unknown parameter: %@. Try -? for help. Or -u for usage.", parm);
//        }
//        
//        id data = nil;
//
//        if(handler.flags.isExpectingData) {
//            if(i + 1 >= input.count) {
//                FLThrowErrorCodeWithComment([FLToolApplicationErrorDomain instance], FLToolApplicationErrorCodeMissingDataForParameter, @"Expecting data following %@ parameter. Try -? for help. Or -u for usage.", parm);
//            }
//        
//            NSString* nextParm = [input objectAtIndex:++i];
//            if([self argumentHandlerForParameter:nextParm] != nil) {
//                FLThrowErrorCodeWithComment([FLToolApplicationErrorDomain instance], FLToolApplicationErrorCodeMissingDataForParameter, @"Expecting data following %@ parameter, got parameter %@ instead. Try -? for help. Or -u for usage.", parm, nextParm);
//            }
//            
//            data = nextParm;
//        }
//   
//        //check for duplicates
//        for(NSString* aParm in handler.inputKeys) {
//            FLArgumentHandler* unwantedHandler = [handlers objectForKey:aParm];
//            if(unwantedHandler != nil) {
//                FLThrowErrorCodeWithComment( [FLToolApplicationErrorDomain instance],
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
//                FLThrowErrorCodeWithComment([FLToolApplicationErrorDomain instance], FLToolApplicationErrorIncompatibleParameters,
//                @"Parameters %@ and %@ can't be used together. Try -? for help. Or -u for usage.", last.inputParametersAsString, handler.inputParametersAsString);
//            }
//        }
//        last = handler;
//    }        
//
//    for(FLArgumentHandler* handler in _argumentHandlers) {
//        if(handler.flags.isRequired && !handler.didFire) {
//            FLThrowErrorCodeWithComment(
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

#endif