//
//  FLObjectInflator.h
//  PackMule
//
//  Created by Mike Fullerton on 6/29/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"

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