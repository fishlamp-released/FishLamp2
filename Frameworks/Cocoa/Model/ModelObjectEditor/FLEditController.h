//
//	FLDataSouce.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/26/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCore.h"

@protocol FLEditControllerDelegate;

@class FLEditController;

typedef void (^FLEditControllerObserverBlock)(FLEditController* editController, NSString* path, id newObject, id previousObject, BOOL isValid);
typedef void (^FLEditControllerValidatorBlock)(FLEditController* editController, NSString* atPath, id object, BOOL* outIsValid);

@interface FLEditController : NSObject {
@private
	NSMutableDictionary* _rootContainer;
    NSMutableDictionary* _observers;
    NSMutableDictionary* _validators;
    BOOL _mute;
    BOOL _valid;
	__unsafe_unretained id<FLEditControllerDelegate> _delegate;
}

+ (FLEditController*) editController;

@property (readwrite, assign, nonatomic, getter=isMuted) BOOL mute;

@property (readwrite, assign, nonatomic) id<FLEditControllerDelegate> delegate;

// objects are heirachical

- (id) objectForPath:(NSString*) path;

- (void) setObject:(id) value
           forPath:(NSString*) path;

- (void) removeObjectForPath:(NSString*) path;
   
// observers
   
- (void) addObserver:(FLEditControllerObserverBlock) observer forPath:(NSString*) path;
   
// validation

@property (readonly, assign, nonatomic, getter=isValid) BOOL valid;

- (void) updateValidity;

- (void) addValidator:(FLEditControllerValidatorBlock) validator forPath:(NSString*) path;

- (BOOL) isValidForPath:(NSString*) path;

- (BOOL) isObject:(id) object validForPath:(NSString*) path;
   
// override point

- (void) didReplaceObject:(id) previousObject
               withObject:(id) newObject
                  forPath:(NSString*) forPath;
         
@end

@protocol FLEditControllerDelegate <NSObject>

@optional

- (void) editController:(FLEditController*) editController
       didReplaceObject:(id) previousObjectOrNil
             withObject:(id) newObjectOrNil
                forPath:(NSString*) path
                isValid:(BOOL) isValid;

- (void) editController:(FLEditController*) editController
      validityDidChange:(BOOL) isValid;

@end

static const FLEditControllerValidatorBlock FLStringValidator;

