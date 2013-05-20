//
//  GtObjectDescriber.h
//  PackMule
//
//  Created by Mike Fullerton on 6/30/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtPropertyDescription.h"

@interface GtObjectDescriber : NSObject<NSCopying> {
@private 
	NSMutableDictionary* m_propertyDescribers;
}

- (id) init;
- (id) initWithPropertyDescribers:(NSDictionary*) dictionary;

@property (readonly, copy, nonatomic) NSDictionary* propertyDescribers;

- (void) setPropertyDescriber:(GtPropertyDescription*) objectDescriber forPropertyName:(NSString*) propertyName;
- (GtPropertyDescription*) propertyDescriberForPropertyName:(NSString*) propertyName;


//// this fills in all the properties for the class, including superclasses (Not including NSObject) using Objective-c runtime info.
//- (void) addPropertiesForClass:(Class) aClass;

@end

@interface NSObject (GtObjectDescriber)
+ (GtObjectDescriber*) sharedObjectDescriber;
@end

typedef enum {
	GtMergeModePreserveDestination,		// always keep dest value, even if src has value.
	GtMergeModeSourceWins,				// if src has value, overwrite dest value.
} GtMergeMode;


// this only works for objects with valid describers.
extern void GtMergeObjects(id dest, id src, GtMergeMode mergeMode);
extern void GtMergeObjectArrays(NSMutableArray* dest, NSArray* src, GtMergeMode mergeMode, NSArray* arrayItemTypes);
