//
//  FLToolApplication.h
//  FishLampTools
//
//  Created by Fullerton Mike on 5/5/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//
#if 0
#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLArgumentHandler.h"

typedef enum {
  FLToolApplicationErrorCodeNone,
  FLToolApplicationErrorIncompatibleParameters,
  FLToolApplicationErrorCodeUnknownParameter,
  FLToolApplicationErrorCodeMissingRequiredParameter,
  FLToolApplicationErrorCodeDuplicateParameter,
  FLToolApplicationErrorCodeMissingDataForParameter,  
  FLToolApplicationErrorFileNotFound,
} FLToolApplicationErrorCode;


typedef enum {
    FLToolModeNormal    = 0,
    FLToolModeDebug     = (1 << 0),
    FLToolModeVerbose   = (1 << 1)
} FLToolModeFlag;

typedef struct {
    BOOL debug;
    BOOL verbose;
} FLToolMode;

NS_INLINE
FLToolMode FLToolModeMake(FLToolMode mode, FLToolModeFlag flag) {
    FLToolMode outStruct = {
        FLTestBits(flag, FLToolModeDebug),
        FLTestBits(flag, FLToolModeVerbose)
    };
    return outStruct;
}

NS_INLINE
FLToolMode FLToolModeSet(FLToolMode mode, FLToolModeFlag flag) {

    FLToolMode outStruct = {
        MAX(mode.debug, FLTestBits(flag, FLToolModeDebug)),
        MAX(mode.verbose, FLTestBits(flag, FLToolModeVerbose))
    };
    return outStruct;
}

NS_INLINE
FLToolMode FLToolModeClear(FLToolMode mode, FLToolModeFlag flag) {

    FLToolMode outStruct = {
        FLTestBits(flag, FLToolModeDebug) ? NO : mode.debug,
        FLTestBits(flag, FLToolModeVerbose) ? NO : mode.verbose,
    };
    return outStruct;
}




@interface FLCommandLineTool : NSObject {
@private
    NSDictionary* _arguments;
    NSMutableArray* _argumentHandlers;
    NSString* _toolDirectory;
    NSString* _helpBlurb;
    NSString* _toolName;
    FLToolMode _toolMode;
}

@property (readwrite, assign, nonatomic) FLToolMode toolMode;

@property (readwrite, strong, nonatomic) NSString* helpBlurb;

@property (readonly, strong, nonatomic) NSDictionary* arguments;

@property (readonly, strong, nonatomic) NSString* toolName;

@property (readonly, strong, nonatomic) NSString* toolDirectory;

- (BOOL) didInvokeArgument:(NSString*) argumentKey;

- (id) parameterFromArgument:(NSString*) argumentKey;

+ (id) application;

// input handlers

- (void) addInputHandler:(FLArgumentHandler*) handler;

- (FLArgumentHandler*) argumentHandlerForParameter:(NSString*) parm;

// required override.
- (void) addInputHandlers;

// optional overrides
- (void) willPrintHelp:(id) sender;

- (void) willPrintUsage:(id) sender;

- (void) didLaunchWithParameters:(NSArray*) input;

- (void) runToolTask;

- (void) onHandleError:(NSError*) error; 

// singleton (automatically set)
+ (id) instance;

+ (void) setInstance:(FLCommandLineTool*) instance;

// if you have to ask...
- (void) addWthParameter;

- (void) openFileInDefaultEditor:(NSString*) path;

- (void) openURL:(NSString *)url inBackground:(BOOL)background;

@end

extern int FLCommandLineToolMain(int argc, const char * argv[], Class toolAppClass, NSString* toolName);

#endif