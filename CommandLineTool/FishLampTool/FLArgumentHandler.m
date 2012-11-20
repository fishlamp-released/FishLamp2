//
//  FLInputParameter.m
//  FishLampTools
//
//  Created by Fullerton Mike on 5/5/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//
#if 0
#import "FLArgumentHandler.h"

@interface FLArgumentHandler ()
@end

@implementation FLArgumentHandler

@synthesize prepareCallback = _onInvoke;
@synthesize executeCallback = _onInput;
@synthesize finishedCallback = _onFinished;
@synthesize inputData = _inputData;
@synthesize inputKeys = _inputKeys;
@synthesize helpDescription = _helpDescription;
@synthesize didFire = _didFire;
@synthesize flags = _inputFlags;
@synthesize compatibleInputKeys = _compatibleParameters;

- (FLArgumentFlagMask) defaultFlags {
    return 0;
}

- (id) init {
    self = [super init];
    if(self){
        _inputKeys =[[NSMutableArray alloc] init];
    }
    return self;
}

- (id) initWithKeys:(NSString*) inputKeysCSV
         inputFlags:(FLArgumentFlagMask) inputFlags
        description:(NSString*) description {
    
    return [self initWithKeys:inputKeysCSV inputFlags:inputFlags description:description selector:nil];
}

- (id) initWithKeys:(NSString*) inputKeysCSV
         inputFlags:(FLArgumentFlagMask) inputFlags
        description:(NSString*) description
        selector:(SEL) selector {
    
    return [self initWithKeys:inputKeysCSV inputFlags:inputFlags description:description callback:[FLCallback callbackWithTarget:nil action:selector]];
}

- (id) initWithKeys:(NSString*) inputKeysCSV
         inputFlags:(FLArgumentFlagMask) inputFlags
        description:(NSString*) description
        callbackBlock:(FLCallbackBlock) block {
    
    return [self initWithKeys:inputKeysCSV inputFlags:inputFlags description:description callback:[FLCallback callbackWithBlock:block]];
}


- (id) initWithKeys:(NSString*) inputKeysCSV
         inputFlags:(FLArgumentFlagMask) inputFlags
        description:(NSString*) description
        callback:(FLCallback*) callback {

    self = [self init];
    if(self) {
        NSArray* inputs = [inputKeysCSV componentsSeparatedByString:@","];
        for(NSString* input in inputs) {
            [self addInputParameter:input];
        }
        self.flags = FLArgumentFlagsMake(inputFlags | [self defaultFlags]);
        self.helpDescription = description;
        self.prepareCallback = callback;;
    }
    
    return self;
}

+ (id) argumentHandler:(NSString*) inputKeysCSV
         inputFlags:(FLArgumentFlagMask) inputFlags
        description:(NSString*) description {
    
    return autorelease_([[[self class] alloc] initWithKeys:inputKeysCSV inputFlags:inputFlags description:description callback:nil]);
}

+ (id) argumentHandler:(NSString*) inputKeysCSV
         inputFlags:(FLArgumentFlagMask) inputFlags
        description:(NSString*) description
           selector:(SEL) selector {
    return autorelease_([[[self class] alloc] initWithKeys:inputKeysCSV inputFlags:inputFlags description:description selector:selector]);
}


+ (id) argumentHandler:(NSString*) inputKeysCSV
         inputFlags:(FLArgumentFlagMask) inputFlags
        description:(NSString*) description
      callbackBlock:(FLCallbackBlock) block {
    return autorelease_([[[self class] alloc] initWithKeys:inputKeysCSV inputFlags:inputFlags description:description callbackBlock:block]);
}

+ (id) argumentHandler:(NSString*) inputKeysCSV
         inputFlags:(FLArgumentFlagMask) inputFlags
        description:(NSString*) description
           callback:(FLCallback*) callback {
    return autorelease_([[[self class] alloc] initWithKeys:inputKeysCSV inputFlags:inputFlags description:description callback:callback]);
}

+ (id) argumentHandler{
    return autorelease_([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    release_(_onFinished);
    release_(_onInput);
    release_(_inputData);
    release_(_onInvoke);
    super_dealloc_();
}
#endif

- (void) prepare:(NSString*) input {
    self.inputData = input;
    if(self.prepareCallback) {
        [self.prepareCallback invoke:self];
    }
}

- (void) execute {
    if(self.executeCallback) {
        [self.executeCallback invoke:self];
    }
}

- (void) finish {
    if(self.finishedCallback) {
        [self.finishedCallback invoke:self];
    }
}



@end
#endif