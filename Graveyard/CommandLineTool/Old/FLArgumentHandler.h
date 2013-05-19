//
//  FLInputParameter.h
//  FishLampTools
//
//  Created by Fullerton Mike on 5/5/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#if 0
#import <Foundation/Foundation.h>
#import "FishLampCore.h"
#import "FLCallback.h"

@class FLArgumentHandler;

typedef enum {
    FLArgumentNone                      = 0,
    FLArgumentIsRequired                = (1 << 0),
    FLArgumentIsExpectingData           = (1 << 1),
    FLArgumentItemMustAlreadyExist      = (1 << 2),
    FLArgumentCreateMissingItem         = (1 << 3)
} FLArgumentFlagMask;

typedef struct {
    BOOL isRequired;
    BOOL isExpectingData;
    BOOL itemMustAlreadyExist;
    BOOL createMissingItem;
} FLArgumentFlags;

NS_INLINE
FLArgumentFlags FLArgumentFlagsMake(FLArgumentFlagMask flag) {

    FLArgumentFlags outStruct = {
        FLTestBits(flag, FLArgumentIsRequired),
        FLTestBits(flag, FLArgumentIsExpectingData),
        FLTestBits(flag, FLArgumentItemMustAlreadyExist),
        FLTestBits(flag, FLArgumentCreateMissingItem)
    };
    return outStruct;
}

NS_INLINE
FLArgumentFlags FLArgumentFlagsSet(FLArgumentFlags mode, FLArgumentFlagMask flag) {

    FLArgumentFlags outStruct = {
        MAX(mode.isRequired, FLTestBits(flag, FLArgumentIsRequired)),
        MAX(mode.isExpectingData, FLTestBits(flag, FLArgumentIsExpectingData)),
        MAX(mode.itemMustAlreadyExist, FLTestBits(flag, FLArgumentItemMustAlreadyExist)),
        MAX(mode.createMissingItem, FLTestBits(flag, FLArgumentCreateMissingItem))
    };
    return outStruct;
}

NS_INLINE
FLArgumentFlags FLArgumentFlagsClear(FLArgumentFlags mode, FLArgumentFlagMask flag) {

    FLArgumentFlags outStruct = {
        FLTestBits(flag, FLArgumentIsRequired) ? NO : mode.isRequired,
        FLTestBits(flag, FLArgumentIsExpectingData) ? NO : mode.isExpectingData,
        FLTestBits(flag, FLArgumentItemMustAlreadyExist) ? NO : mode.itemMustAlreadyExist,
        FLTestBits(flag, FLArgumentCreateMissingItem) ? NO : mode.createMissingItem,
    };
    return outStruct;
}


typedef void (^FLInputParameterBlock)(FLArgumentHandler* argumentHandler, id dataOrNil);

#define FLInputHandlerCompatableWithAll @"*"

@interface FLArgumentHandler : NSObject {
@private
    NSString* _inputData;
    FLCallback* _onInvoke;
    FLCallback* _onInput;
    FLCallback* _onFinished;
    FLArgumentFlags _inputFlags;
    BOOL _didFire;
}

- (id) initWithKeys:(NSString*) inputKeysCSV
         inputFlags:(FLArgumentFlagMask) inputFlags
        description:(NSString*) description;

- (id) initWithKeys:(NSString*) inputKeysCSV
         inputFlags:(FLArgumentFlagMask) inputFlags
        description:(NSString*) description
      callbackBlock:(FLCallbackBlock) block;

- (id) initWithKeys:(NSString*) inputKeysCSV
         inputFlags:(FLArgumentFlagMask) inputFlags
        description:(NSString*) description
        selector:(SEL) selector;

- (id) initWithKeys:(NSString*) inputKeysCSV
         inputFlags:(FLArgumentFlagMask) inputFlags
        description:(NSString*) description
           callback:(FLCallback*) callback;

+ (id) argumentHandler:(NSString*) inputKeysCSV
         inputFlags:(FLArgumentFlagMask) inputFlags
        description:(NSString*) description;

+ (id) argumentHandler:(NSString*) inputKeysCSV
         inputFlags:(FLArgumentFlagMask) inputFlags
        description:(NSString*) description
           selector:(SEL) selector;

+ (id) argumentHandler:(NSString*) inputKeysCSV
         inputFlags:(FLArgumentFlagMask) inputFlags
        description:(NSString*) description
      callbackBlock:(FLCallbackBlock) block;

+ (id) argumentHandler:(NSString*) inputKeysCSV
         inputFlags:(FLArgumentFlagMask) inputFlags
        description:(NSString*) description
           callback:(FLCallback*) callback;


- (void) prepare:(NSString*) input;

- (void) execute;

- (void) finish;


// run first, use to set variables like '-r' for recursive
@property (strong, strong, nonatomic) FLCallback* prepareCallback;

// execute the invoke handlers
@property (strong, strong, nonatomic) FLCallback* executeCallback;

// clean up if needed 
@property (strong, strong, nonatomic) FLCallback* finishedCallback;

//
// setup
//

@property (readwrite, assign, nonatomic) FLArgumentFlags flags;



// 
// state
//

// was this invoked
@property (readwrite, assign, nonatomic) BOOL didFire;

// this gets set by tools when input params are parsed
// pull this out in your handler block.
@property (readwrite, strong, nonatomic) NSString* inputData;

//
// help (shown when usage is invoked.
// 

@property (readwrite, strong, nonatomic) NSString* helpDescription;

//
// compatible parameters, by default not compatible with other argumentHandlers
//

// compatible parameters list
@property (readonly, strong, nonatomic) NSArray* compatibleInputKeys;

// use FLInputHandlerCompatableWithAll to be compatabile with all, for example in a --verbose key
- (void) addCompatibleParameter:(NSString*) parameter; 

// check both for compatibility with each other
- (BOOL) isCompatibleWithInputHandler:(FLArgumentHandler*) handler;

// just check if inputParameter (for another argumentHandler) is compatible with self
- (BOOL) isCompatibleWithInputParameter:(NSString*) inputParameter;

- (FLArgumentFlagMask) defaultFlags;


@end
#endif