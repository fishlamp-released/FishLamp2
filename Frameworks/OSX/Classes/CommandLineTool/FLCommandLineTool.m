//
//  FLToolApplication.m
//  FishLampTools
//
//  Created by Fullerton Mike on 5/5/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLCommandLineTool.h"
#import "FLStringUtils.h"
#import "NSString+Lists.h"

@interface FLCommandLineTool ()
@property (readwrite, strong, nonatomic) NSURL* toolPath;
@property (readwrite, strong, nonatomic) NSString* startDirectory;
@property (readwrite, strong, nonatomic) NSString* toolName;
@end

@implementation FLCommandLineTool

@synthesize toolPath = _toolPath;
@synthesize startDirectory = _startDirectory;
@synthesize toolName = _toolName;

//+ (id) commandLineTool {
//    return FLAutorelease([[[self class] alloc] initWithToolName:nil]);
//}
//
//+ (id) commandLineTool:(NSString*) toolName {
//    return FLAutorelease([[[self class] alloc] initWithToolName:toolName]);
//}

- (id) initWithToolName:(NSString*) name {
    self = [super init];
    if(self) {
        self.toolName = name;
        self.output = [FLLogger logger];
        [self.output addLoggerSink:[FLConsoleLogSink consoleLogSink:FLLogOutputSimple]];
    }
    
    return self;
}

- (id) init {
    return [self initWithToolName:@""];
}

#if FL_MRC
- (void) dealloc {
    [_toolName release];
    [_startDirectory release];
    [_toolPath release];
    [super dealloc];
}
#endif

- (void) setCurrentDirectory:(NSString*) newDirectory {

// TODO: this returns a BOOL? Check it?
    [[NSFileManager defaultManager] changeCurrentDirectoryPath:newDirectory];
}

- (NSString*) currentDirectory {
    return [[NSFileManager defaultManager] currentDirectoryPath];
}

- (int) runFromMain:(int) argc argv:(const char**) argv {

    NSMutableArray* array = [NSMutableArray array];
    for(int i = 0; i < argc; i++) {
        [array addObject:[NSString stringWithCString:argv[i] encoding:NSASCIIStringEncoding]];
    }
    return [self runWithArguments:array];
}

- (NSString*) getPassword:(NSString*) prompt {

//    [self.output appendString:prompt];
    char *pass = getpass(prompt.UTF8String);
    return [NSString stringWithCString:pass encoding:NSUTF8StringEncoding];
}

- (NSString*) getInputString:(NSString*) prompt maxLength:(NSUInteger) maxLength {
    
    [self.output appendString:prompt];

    char* buffer = malloc(maxLength + 1);
    
    NSInteger idx = 0;
    
    char c = getchar();
    while(c != '\n' && idx < maxLength) {
        buffer[idx++] = c;
        c = getchar();
    }
    buffer[idx] = 0;
    
    NSString* outString = [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
    
    free(buffer);
    
    return outString;
}


- (int) runWithArguments:(NSArray*) arguments {

#if FL_MRC    
    @autoreleasepool {
#endif    
        @try {
        
            NSArray* args = [[NSProcessInfo processInfo] arguments];

            self.toolPath = [NSURL fileURLWithPath:[args objectAtIndex:0]];
            self.startDirectory = [[NSFileManager defaultManager] currentDirectoryPath];

            NSArray* argsWithoutPath = [args subarrayWithRange:NSMakeRange(1, args.count -1)];

            NSString* string = [NSString concatStringArray:argsWithoutPath delimiter:@" "];

            [self runToolCommandsWithInput:string];
        }
        @catch(NSException* ex) {
            [[self output] appendLineWithFormat:@"uncaught exception: %@", [ex reason]];

            return 1;
        }
        
        return 0;
#if FL_MRC
    }
#endif
}

@end



