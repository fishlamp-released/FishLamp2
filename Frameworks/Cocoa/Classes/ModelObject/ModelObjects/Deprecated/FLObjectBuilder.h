//
//  FLObjectBuilder.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/9/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if REFACTOR
#import "FLCocoaRequired.h"
#import "FishLamp.h"
#import "FLDataDecoding.h"
#import "FLAsyncResult.h"
#import "FLPropertyInflator.h"

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

// iterative building
- (void) openWithRootObjectClass:(Class) theClass withDataDecoder:(id<FLDataDecoding>) decoder;
- (FLPromisedResult) finishBuilding;

- (FLPropertyInflator*) firstInflator;
- (FLPropertyInflator*) lastInflator;

- (FLPropertyInflator*) startInflatingPropertyWithName:(NSString*) propertyName 
                                             withState:(int) state;

- (void) finishInflatingProperty;

- (void) addPropertyWithName:(NSString*) propertyName 
           withEncodedString:(NSString*) data 
                   withState:(int) state;

// debugging/errors
- (void) setError:(NSError*) error errorHint:(int) errorHint;
- (NSString*) stateString;

- (FLPropertyInflator*) previousStateForState:(FLPropertyInflator*) state;

@end

@protocol FLObjectBuilderDelegate <NSObject>
@optional
- (void) objectBuilder:(FLObjectBuilder*) objectBuilder 
   willInflateProperty:(FLPropertyInflator*) propertyInflator;
   
- (void) objectBuilder:(FLObjectBuilder*) objectBuilder 
            encounteredError:(NSError*) error 
            errorHint:(int) errorHint
            errorHelp:(FLPrettyString*) errorHelp;

@end

//@protocol FLBuildableObject <NSObject>
//- (BOOL) objectBuilder:(FLObjectBuilder*) builder 
//        willInflateProperty:(FLPropertyInflator*) state;
//
//@end

#endif