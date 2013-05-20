//
//  GtObjectInflator.h
//  PackMule
//
//  Created by Mike Fullerton on 6/29/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@class GtObjectDescriber;

@interface GtObjectInflator : NSObject {
@private
	NSMutableDictionary* m_unboundedArrays;
}

- (id) initWithObjectDescriber:(GtObjectDescriber*) objectDescriber;

- (void) setValue:(id) value forKey:(id) forKey forObject:(id) object;
- (id) valueForKey:(id) key forObject:(id) object;

- (void) addUnboundedArraySetter:(NSString*) name arrayPropertyName:(NSString*) arrayName;

@end

@interface NSObject (GtObjectInflator) 
- (void) setValue:(id) value forKey:(id) forKey forObject:(id) object;
- (id) valueForKey:(id) key forObject:(id) object;
@property (readonly, retain, nonatomic) id objectInflator;
+ (GtObjectInflator*) sharedObjectInflator;
@end