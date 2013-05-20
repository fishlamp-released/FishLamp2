//
//  FLToolApplication.m
//  FishLampTools
//
//  Created by Fullerton Mike on 5/5/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if 0
#import "FLCommandLineTool.h"
#import "NSFileManager+FLExtras.h"
#import "FLStringUtils.h"
#import "FLErrorDomain.h"
//FLDeclareErrorDomain(FLToolApplicationErrorDomain);

FLDeclareErrorDomain(FLToolApplicationErrorDomain);

FLSynthesizeErrorDomain(FLToolApplicationErrorDomain, @"com.fishlamp.commandlinetool");

@interface FLCommandLineTool ()
@property (readwrite, strong, nonatomic) NSString* toolName;
@property (readwrite, strong, nonatomic) NSDictionary* arguments;
@property (readwrite, strong, nonatomic) NSArray* argumentHandlers;
@property (readwrite, strong, nonatomic) NSString* toolDirectory;
@end

@implementation FLCommandLineTool

@synthesize arguments = _arguments;
@synthesize argumentHandlers = _argumentHandlers;
@synthesize toolDirectory = _toolDirectory;
@synthesize helpBlurb = _helpBlurb;
@synthesize toolName = _toolName;
@synthesize toolMode = _toolMode;

static FLCommandLineTool* s_instance = nil;

+ (id) instance {
    return s_instance;
}

+ (void) setInstance:(FLCommandLineTool*) instance {
    FLRetainObject_(s_instance, instance);
}

- (id) init {
    self = [super init];
    if(self) {
        _argumentHandlers = [[NSMutableArray alloc] init];
        self.helpBlurb = @"TBD: TOOL SUBCLASS NEEDS HELP BLURB";
    
        [self addInputHandlers];
        [self addWthParameter];
    }
    
    return self;
}


- (void) _wait:(FLArgumentHandler*) handler {

    NSTimeInterval pause = [handler.inputData floatValue];
    FLLog(@"Pausing for %f seconds", pause);
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    
    while([NSDate timeIntervalSinceReferenceDate] < (start + pause)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];
    }
}

- (void) addInputHandlers {
    [self addInputHandler:[FLArgumentHandler argumentHandler:@"-?,--help,-h,?"
                                            inputFlags:0
                                           description:@"prints this help"
                                              selector:@selector(willPrintHelp:)]];

    [self addInputHandler:[FLArgumentHandler argumentHandler:@"-u,--usage"
                                            inputFlags:0
                                           description:@"prints usage"
                                              selector:@selector(willPrintUsage:)]];
    
    [self addInputHandler:[FLArgumentHandler argumentHandler:@"--debug"
                                            inputFlags:0
                                           description:@"Prints debugging info during run"
                                         callbackBlock: ^(id sender) { self.toolMode = FLToolModeSet(self.toolMode, FLToolModeDebug); }]];

    [self addInputHandler:[FLArgumentHandler argumentHandler:@"--wait"
                                            inputFlags:FLArgumentIsExpectingData
                                           description:@"Wait for x seconds"
                                         selector:@selector(_wait:)]];


}

- (void) addWthParameter {
    
    [self addInputHandler:[FLArgumentHandler argumentHandler:@"--wth"
                                            inputFlags:0
                                           description:@"Don't invoke this option. You've been warned."
                                         callbackBlock:^(id sender) {
                                            [self openURL:@"http://r33b.net/" inBackground:NO];
                                            } ]];
}

+ (id) application {
    return autorelease_([[[self class] alloc] init]); 
}

- (void) willPrintHelp:(id) sender {
    FLLog(@"%@ Help:", self.toolName);
    FLLog(self.helpBlurb);
    FLLog(@"");
    [self willPrintUsage:sender];
}

- (void) willPrintUsage:(id) sender {
    FLLog(@"%@ Usage:", self.toolName);
    for(FLArgumentHandler* handler in _argumentHandlers) {
        NSString* inputParms = [[NSString stringWithFormat:@"%@:", handler.inputParametersAsString] stringWithPadding:40];
        FLLog(@"%@%@", inputParms, handler.helpDescription);
    }
}

- (FLArgumentHandler*) argumentHandlerForParameter:(NSString*) parm {

    for(FLArgumentHandler* handler in _argumentHandlers) {
        if([handler hasInputParameter:parm]) {
            return handler;
        }
    }
    
    return nil;
}

- (void) addInputHandler:(FLArgumentHandler*) handler {
    
    FLAssertIsNotNil_(handler);

#if DEBUG
    for(NSString* key in handler.inputKeys) {
        FLAssert_v([self argumentHandlerForParameter:key] == nil, @"add duplicated inputParameter");
    }
#endif

    [_argumentHandlers addObject:handler];
}

- (void) runToolTask {
//    [self willPrintUsage];
}

- (void) _parseParameters:(NSArray*) input {
    
    NSMutableDictionary* handlers = [NSMutableDictionary dictionaryWithCapacity:self.argumentHandlers.count];

    self.toolDirectory = input.firstObject;
    
    for(int i = 1; i < input.count; i++) {
        NSString* parm = [input objectAtIndex:i];
        FLArgumentHandler* handler = [self argumentHandlerForParameter:parm];

        if(!handler) {
            FLThrowErrorCode_v([FLToolApplicationErrorDomain instance], FLToolApplicationErrorCodeUnknownParameter, @"Unknown parameter: %@. Try -? for help. Or -u for usage.", parm);
        }
        
        id data = nil;

        if(handler.flags.isExpectingData) {
            if(i + 1 >= input.count) {
                FLThrowErrorCode_v([FLToolApplicationErrorDomain instance], FLToolApplicationErrorCodeMissingDataForParameter, @"Expecting data following %@ parameter. Try -? for help. Or -u for usage.", parm);
            }
        
            NSString* nextParm = [input objectAtIndex:++i];
            if([self argumentHandlerForParameter:nextParm] != nil) {
                FLThrowErrorCode_v([FLToolApplicationErrorDomain instance], FLToolApplicationErrorCodeMissingDataForParameter, @"Expecting data following %@ parameter, got parameter %@ instead. Try -? for help. Or -u for usage.", parm, nextParm);
            }
            
            data = nextParm;
        }
   
        //check for duplicates
        for(NSString* aParm in handler.inputKeys) {
            FLArgumentHandler* unwantedHandler = [handlers objectForKey:aParm];
            if(unwantedHandler != nil) {
                FLThrowErrorCode_v( [FLToolApplicationErrorDomain instance],
                        FLToolApplicationErrorCodeDuplicateParameter, 
                        @"Duplicate parameter %@ (already got %@). Try -? for help. Or -u for usage.", 
                        aParm, 
                        unwantedHandler.inputParametersAsString);
            }
        }

        if(data) {
            [handler prepare:data];
        }
        
        for(NSString* key in handler.inputKeys) {
            [handlers setObject:handler forKey:key];
            [handlers setObject:handler forKey:[key stringByReplacingOccurrencesOfString:@"-" withString:@""]];
        }
        
        handler.didFire = YES;
    }

    // check for incompatible parameters
    FLArgumentHandler* last = nil;
    for(FLArgumentHandler* handler in handlers.objectEnumerator) {
        if(handler && last) {
            if(![handler isCompatibleWithInputHandler:last]) {
                FLThrowErrorCode_v([FLToolApplicationErrorDomain instance], FLToolApplicationErrorIncompatibleParameters,
                @"Parameters %@ and %@ can't be used together. Try -? for help. Or -u for usage.", last.inputParametersAsString, handler.inputParametersAsString);
            }
        }
        last = handler;
    }        

    for(FLArgumentHandler* handler in _argumentHandlers) {
        if(handler.flags.isRequired && !handler.didFire) {
            FLThrowErrorCode_v(
                [FLToolApplicationErrorDomain instance],
                FLToolApplicationErrorCodeMissingRequiredParameter,
                @"Missing required parameter: %@. Try -? for help. Or -u for usage.", handler.inputParametersAsString);
        }
    }

    
    self.arguments = handlers;
}

- (BOOL) didInvokeArgument:(NSString*) argumentKey {
    return [self.arguments objectForKey:argumentKey] != nil;
}

- (id) parameterFromArgument:(NSString*) argumentKey {
    return [[self.arguments objectForKey:argumentKey] inputData];
}



- (void) willInvokeHandlers:(NSDictionary*) handlers {
    if(handlers) {
        for(FLArgumentHandler* handler in handlers.objectEnumerator) {
            if(handler.prepareCallback) {
                [handler.prepareCallback invoke:handler];
            }
        }
    }
}

- (void) willFinishWithHandlers:(NSDictionary*) handlers {
    if(handlers) {
        for(FLArgumentHandler* handler in handlers.objectEnumerator) {
            if(handler.finishedCallback) {
                [handler.finishedCallback invoke:handler];
            }
        }
    }
}

- (void) didLaunchWithParameters:(NSArray*) input {
    
    [self _parseParameters:input];
    
    if(self.toolMode.debug) {
        FLLog([input description]);
    }

    for(FLArgumentHandler* handler in self.arguments.objectEnumerator) {
        [handler execute];
    }
    
    for(FLArgumentHandler* handler in self.arguments.objectEnumerator) {
        [handler finish];
    }

    [self runToolTask];
}

- (void) dealloc {
    release_(_argumentHandlers);
    release_(_toolName);
    release_(_toolDirectory);
    release_(_arguments);
    release_(_argumentHandlers);
    super_dealloc_();
}

- (void) openFileInDefaultEditor:(NSString*) path {
    [[NSWorkspace sharedWorkspace] openFile:path];
}

- (void) onHandleError:(NSError*) error {
    if(FLStringIsNotEmpty(error.localizedDescription)) {
        FLLog(@"EPIC FAIL: %@", error.localizedDescription);
    } 
    else { 
        FLLog(@"EPIC FAIL: %@", [error description]);
    }
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


@end

int FLCommandLineToolMain(int argc, const char * argv[], Class toolAppClass, NSString* toolName) {

    @try {
        NSMutableArray* inputStrings = [NSMutableArray arrayWithCapacity:argc];
        for(int i = 0; i < argc; i++) {
            [inputStrings addObject:[NSString stringWithCString:argv[i] encoding:NSASCIIStringEncoding]];
        }
        
        [FLCommandLineTool setInstance:[toolAppClass application]];
        [[FLCommandLineTool instance] setToolName:toolName];
        [[FLCommandLineTool instance] didLaunchWithParameters:inputStrings];
    }
    @catch(NSException* ex) {
        [[FLCommandLineTool instance] onHandleError:ex.error];
        return 1;
    }
    @finally {
        [FLCommandLineTool setInstance:nil];
    }   
    
    return 0;
}
#endif
