//
//  FLObjectBuilder.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/9/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"
#import "FLDataDecoding.h"
#import "FLObjectInflatorState.h"

@protocol FLObjectBuilderDelegate;

@interface FLObjectBuilder : NSObject {
@private
    NSMutableArray* _stack;
    id<FLDataDecoding> _dataDecoder;
    NSError* _error;
    id _rootObject;
    
    __unsafe_unretained id<FLObjectBuilderDelegate> _delegate;
}

+ (id) objectBuilder;

@property (readwrite, assign, nonatomic) id<FLObjectBuilderDelegate> delegate;

// dictionary should only have arrays, dictionaries, and strings in it.

- (void) buildObjectsFromDictionary:(NSDictionary*) dictionary 
                     withRootObject:(id) rootObject
                        withDecoder:(id<FLDataDecoding>) decoder;

- (void) openWithRootObjectClass:(Class) theClass withDataDecoder:(id<FLDataDecoding>) decoder;
- (id) finishBuilding;

- (FLObjectInflatorState*) firstObject;
- (FLObjectInflatorState*) lastObject;

- (FLObjectInflatorState*) openObject:(NSString*) objectKey;
- (void) appendString:(NSString*) string; // TODO: move to state object
- (void) closeObject:(FLObjectInflatorState*) object;

- (void) addObject:(NSString*) name data:(NSString*) data;
- (void) addAttribute:(NSString*) name data:(NSString*) data;

// debugging/errors
@property (readwrite, retain, nonatomic) NSError* error;
- (void) setError:(NSError*) error errorHint:(int) errorHint;
- (NSString*) stateString;

@end


@protocol FLObjectBuilderDelegate <NSObject>
- (void) objectBuilder:(FLObjectBuilder*) objectBuilder willOpenObject:(FLObjectInflatorState*)object;
@end

@protocol FLBuildableObject <NSObject>
- (BOOL) objectBuilder:(FLObjectBuilder*) builder 
        willOpenObject:(FLObjectInflatorState*) state;

- (void) objectBuilder:(FLObjectBuilder*) builder 
            encounteredError:(NSError*) error 
            errorHint:(int) errorHint
            errorHelp:(FLPrettyString*) errorHelp;
@end

