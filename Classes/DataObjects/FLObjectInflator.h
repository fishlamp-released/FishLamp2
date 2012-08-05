//
//  FLObjectInflator.h
//  PackMule
//
//  Created by Mike Fullerton on 6/29/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

// this is basically an adaptor class. 
// I'll have to dig through the memory banks to remember why we needed it... :-)
// I think it had to do with the effing unbounded arrays in XML (hack).

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