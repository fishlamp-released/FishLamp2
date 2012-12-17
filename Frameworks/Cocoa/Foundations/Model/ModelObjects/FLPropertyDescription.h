//
//  FLObjectDescriber.h
//  PackMule
//
//  Created by Mike Fullerton on 6/29/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLCore.h"

#import "FLDataTypeID.h"

@interface FLPropertyDescription :NSObject {
@private
	NSString* _name;
	Class _class;
	NSArray* _arrayTypes;
	SEL _getter;
    SEL _setter;
    
	struct {
		FLDataTypeID propertyType : 8;
		unsigned int isUnboundedArray: 1;
		unsigned int isUnboundedArrayItem: 1;
	} _flags;
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
@property (readonly, assign, nonatomic) FLDataTypeID propertyType;
@property (readonly, retain, nonatomic) NSArray* arrayTypes;
@property (readonly, assign, nonatomic) BOOL isArray;

@property (readwrite, assign, nonatomic) SEL setter;
@property (readwrite, assign, nonatomic) SEL getter;

- (id) initWithPropertyName:(NSString*) name
	propertyClass:(Class) aClass
	propertyType:(FLDataTypeID) dataType;

- (id) initWithPropertyName:(NSString*) name
              propertyClass:(Class) aClass
               propertyType:(FLDataTypeID) dataType
                 arrayTypes:(NSArray*) arrayTypes;

- (id) initWithPropertyName:(NSString*) name
              propertyClass:(Class) aClass
               propertyType:(FLDataTypeID) dataType
                 arrayTypes:(NSArray*) arrayTypes
           isUnboundedArray:(BOOL) isUnboundedArray;

+ (FLPropertyDescription*) propertyDescription:(NSString*) name
                                 propertyClass:(Class) aClass
                                  propertyType:(FLDataTypeID) dataType;


+ (FLPropertyDescription*) propertyDescription:(NSString*) name
                                 propertyClass:(Class) aClass
                                  propertyType:(FLDataTypeID) dataType
                                    arrayTypes:(NSArray*) arrayTypes;


+ (FLPropertyDescription*) propertyDescription:(NSString*) name
                                 propertyClass:(Class) aClass
                                  propertyType:(FLDataTypeID) dataType
                                    arrayTypes:(NSArray*) arrayTypes
                              isUnboundedArray:(BOOL) isUnboundedArray;
    
    
- (void) setPropertyValue:(id) value forObject:(id) object; 

- (id) propertyValueForObject:(id) object;    

@end



