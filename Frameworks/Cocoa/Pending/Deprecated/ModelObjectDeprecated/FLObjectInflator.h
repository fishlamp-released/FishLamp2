//
//  FLObjectInflator.h
//  PackMule
//
//  Created by Mike Fullerton on 6/29/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FishLamp.h"

@class FLObjectDescriber;

@interface FLObjectInflator : NSObject
- (id) initWithObjectDescriber:(FLObjectDescriber*) objectDescriber;
@end

#if REFACTOR
@class FLObjectDescriber;

@interface FLObjectInflator : NSObject {
@private
	NSMutableDictionary* _unboundedArrays;
}

- (id) initWithObjectDescriber:(FLObjectDescriber*) objectDescriber;

- (void) setValue:(id) value forKey:(id) forKey forObject:(id) object;
- (id) valueForKey:(id) key forObject:(id) object;

- (void) addUnboundedArraySetter:(NSString*) name arrayPropertyName:(NSString*) arrayName;

@end

@interface NSObject (FLObjectInflator) 
- (void) setValue:(id) value forKey:(id) forKey forObject:(id) object;
- (id) valueForKey:(id) key forObject:(id) object;
@property (readonly, retain, nonatomic) id objectInflator;
+ (FLObjectInflator*) sharedObjectInflator;
@end
#endif