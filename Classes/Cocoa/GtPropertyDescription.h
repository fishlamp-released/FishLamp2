//
//  GtObjectDescriber.h
//  PackMule
//
//  Created by Mike Fullerton on 6/29/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtDataTypeID.h"

@interface GtPropertyDescription :NSObject {
@private
	NSString* m_name;
	Class m_class;
	NSArray* m_arrayTypes;
	
	struct {
		GtDataTypeID propertyType : 8;
		unsigned int isUnboundedArray: 1;
		unsigned int isUnboundedArrayItem: 1;
	} m_flags;
}

// When parsing XML, the element representing this property can be unbounded (we'd be an 
// array in this case).
// When this happens the parser needs to be able to add the element to the array as if it 
// were a root property on that object.
// For example:
//		[myObject setPhoneNumber:number]; 
//		This would essentially add the phone number to the object's
//		phone number array, which would be declared as:
//		@property (readwrite, retain, nonatomic) NSMutableArray* phoneNumbers;
//
// this is kind of a special case hack for XML parsing.
@property (readonly, assign, nonatomic, getter=isUnboundedArray) BOOL unboundedArray;
@property (readonly, assign, nonatomic, getter=isUnboundedArrayItem) BOOL unboundedArrayItem;

@property (readonly, retain, nonatomic) NSString* propertyName;
@property (readonly, assign, nonatomic) Class propertyClass;
@property (readonly, assign, nonatomic) GtDataTypeID propertyType;
@property (readonly, retain, nonatomic) NSArray* arrayTypes;
@property (readonly, assign, nonatomic) BOOL isArray;

- (id) initWithPropertyName:(NSString*) name
	propertyClass:(Class) aClass
	propertyType:(GtDataTypeID) dataType;

- (id) initWithPropertyName:(NSString*) name
	propertyClass:(Class) aClass
	propertyType:(GtDataTypeID) dataType
	arrayTypes:(NSArray*) arrayTypes;

- (id) initWithPropertyName:(NSString*) name
	propertyClass:(Class) aClass
	propertyType:(GtDataTypeID) dataType
	arrayTypes:(NSArray*) arrayTypes
	isUnboundedArray:(BOOL) isUnboundedArray;

+ (GtPropertyDescription*) propertyDescription:(NSString*) name
	propertyClass:(Class) aClass
	propertyType:(GtDataTypeID) dataType;


+ (GtPropertyDescription*) propertyDescription:(NSString*) name
	propertyClass:(Class) aClass
	propertyType:(GtDataTypeID) dataType
	arrayTypes:(NSArray*) arrayTypes;


+ (GtPropertyDescription*) propertyDescription:(NSString*) name
	propertyClass:(Class) aClass
	propertyType:(GtDataTypeID) dataType
	arrayTypes:(NSArray*) arrayTypes
	isUnboundedArray:(BOOL) isUnboundedArray;

@end



