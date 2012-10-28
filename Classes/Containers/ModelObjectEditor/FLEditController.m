//
//	FLDataSouce.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/26/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLEditController.h"
#import "NSObject+Comparison.h"
#import "FLOrderedCollection.h"

@interface FLEditController ()
- (id) containerForPath:(NSString*) path;
@property (readwrite, assign, nonatomic, getter=isValid) BOOL valid;
@end

@implementation FLEditController

@synthesize delegate = _delegate;
@synthesize mute = _mute;
@synthesize valid = _valid;

- (void) setMute:(BOOL) mute {
    if(_mute != mute) {
        _mute = mute;
        if(!mute) {
            [self updateValidity];
        }
    }
}

- (void) setValid:(BOOL) valid {
    if(_valid != valid) {
        _valid = valid;
        
        if(!self.isMuted) {
            if([_delegate respondsToSelector:@selector(editController:validityDidChange:)]) {
                [_delegate editController:self validityDidChange:self.isValid];
            }
        }
    }
}

- (NSDictionary*) containers {
	return _rootContainer;
}

- (id) init {
	if((self = [super init])) {
		_rootContainer = [[NSMutableDictionary alloc] init];
        _valid = YES;
    }
	
	return self;
}

+ (FLEditController*) editController {
    return FLReturnAutoreleased([[[self class] alloc] init]);
}

- (void) dealloc {
	FLRelease(_rootContainer);
	FLRelease(_observers);
	FLRelease(_validators);
	FLSuperDealloc();
}

- (id) objectForPath:(NSString*) path {
	id container = [self containerForPath:path];
    FLAssertIsNotNil_v(container, nil);

	return container ? [container objectForPath:[path lastPathComponent]] : nil;
}

- (void) didReplaceObject:(id) previousObject
               withObject:(id) newObject
                  forPath:(NSString*) path {

    if(!self.isMuted) {
        BOOL isValid = [self isObject:newObject validForPath:path];
        
        NSArray* observers = _observers ? [_observers objectForKey:path] : nil;
        if(observers) {
            for(FLEditControllerObserverBlock observer in observers) {
                observer(self, path, newObject, previousObject, isValid);
            }
        }
    
        if([_delegate respondsToSelector:@selector(editController:didReplaceObject:withObject:forPath:isValid:)]) {
            [_delegate editController:self
                didReplaceObject:previousObject
                      withObject:newObject
                         forPath:path
                         isValid:isValid];
        }
        
        // TODO: perhaps cache validities. It would be quicker. May not need this optimization though.
        [self updateValidity];
    }
}

- (void) setObject:(id) object
           forPath:(NSString*) path {
	
    id container = [self containerForPath:path];
    FLAssertIsNotNil_(container);

	if(container) {
        NSString* key = [path lastPathComponent];
        
		id previousObject = [container objectForPath:key];
    
        if( !FLObjectsAreEqual(previousObject, object) ) {
            FLRetain(previousObject);
            [container setValue:object forKey:key];
            [self didReplaceObject:previousObject withObject:object forPath:path];
            FLRelease(previousObject);
        }
	}
}

- (void) removeObjectForPath:(NSString*) path {
    [self setObject:nil forPath:path];
}

- (id) containerForPath:(NSString*) path {

// TODO: cache this array??
    NSArray* components = [path pathComponents];

    if(components.count > 0) {
        id lastContainer = _rootContainer;
        for(int i = 0; i < components.count - 1 && lastContainer; i++) {
            lastContainer = [lastContainer valueForKey:[components objectAtIndex:i]];
        }
        
        return lastContainer;
    }
    
    return nil;
}

- (void) addObserver:(FLEditControllerObserverBlock) observer forPath:(NSString*) path {
    
    if(!_observers) {
        _observers = [[NSMutableDictionary alloc] init];
    }
    
    observer = FLReturnAutoreleased([observer copy]);
    
    NSMutableArray* observers = [_observers objectForKey:path];
    if(!observers) {
        observers = [NSMutableArray array];
        [_observers setObject:observers forKey:path];
    }
    
    [observers addObject:observer];
}

- (void) addValidator:(FLEditControllerValidatorBlock) validator forPath:(NSString*) path {
    if(!_validators) {
        _validators = [[NSMutableDictionary alloc] init];
    }
    
    validator = FLReturnAutoreleased([validator copy]);
    
    NSMutableArray* array = [_validators objectForKey:path];
    if(!array) {
        array = [NSMutableArray array];
        [_validators setObject:array forKey:path];
    }
    
    [array addObject:validator];
}

- (BOOL) isObject:(id) object validForPath:(NSString*) path {

    BOOL isValid = YES;
    if(_validators) {
        NSArray* validators = [_validators objectForKey:path];
        if(validators) {
            for(FLEditControllerValidatorBlock validator in validators) {
                validator(self, path, object, &isValid);
                
                if(!isValid) {
                    break;
                }
            }
        }
    }
    return isValid;
}

- (BOOL) isValidForPath:(NSString*) path {
    return [self isObject:[self objectForPath:path] validForPath:path];
}

- (void) updateValidity {

    BOOL isValid = YES;
    if(_validators) {
        for(NSString* path in _validators) {
            NSArray* validators = [_validators objectForKey:path];
            if(validators) {
                id object = [self objectForPath:path];
            
                for(FLEditControllerValidatorBlock validator in validators) {
                    validator(self, path, object, &isValid);
                    
                    if(!isValid) {
                        break;
                    }
                }
            }
        }
    }
    
    self.valid = isValid;
}

@end

static const FLEditControllerValidatorBlock FLStringValidator = ^(FLEditController* editController, NSString* atPath, id object, BOOL* outIsValid) {
    *outIsValid = FLStringIsNotEmpty(object);
};


