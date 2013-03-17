//
//  FLObjectDescriber.h
//  PackMule
//
//  Created by Mike Fullerton on 6/29/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLType.h"
#import "FLCoreTypes.h"

@interface FLPropertyType : NSObject {
@private
    FLType* _propertyType;
    NSString* _propertyName;
    NSArray* _arrayTypes;
}

@property (readonly, assign, nonatomic) Class propertyClass;
@property (readonly, strong, nonatomic) FLType* propertyType;
@property (readonly, strong, nonatomic) NSString* propertyName;

@property (readonly, strong, nonatomic) NSArray* arrayTypes;
@property (readonly, assign, nonatomic) BOOL isArray;

- (id) initWithPropertyName:(NSString*) name
              propertyClass:(Class) propertyClass;

- (id) initWithPropertyName:(NSString*) name
              propertyClass:(Class) propertyClass
                 arrayTypes:(NSArray*) arrayTypes;

+ (FLPropertyType*) propertyType:(NSString*) name
                   propertyClass:(Class) propertyClass;

+ (FLPropertyType*) propertyType:(NSString*) name
                   propertyClass:(Class) propertyClass
                      arrayTypes:(NSArray*) arrayTypes;

- (void) setPropertyValue:(id) value forObject:(id) object; 

- (id) propertyValueForObject:(id) object;    

@end



//@interface FLPropertyType () {
//@private
//    BOOL _unboundedArray;
//    BOOL _unboundedArrayItem;
//}
//
//
//// deprecated
//
//// When parsing XML, the element representing this property can be unbounded (we'd be an 
//// array in this case).
//// When this happens the parser needs to be able to add the element to the array as if it 
//// were a root property on that object.
//// For example:
////		[myObject setPhoneNumber:number]; 
////		This would essentially add the phone number to the object's
////		phone number array, which would be declared as:
////		@property (readwrite, strong, nonatomic) NSMutableArray* phoneNumbers;
////
//// this is kind of a special case hack for XML parsing.
//@property (readonly, assign, nonatomic, getter=isUnboundedArray) BOOL unboundedArray;
//@property (readonly, assign, nonatomic, getter=isUnboundedArrayItem) BOOL unboundedArrayItem;
//
//- (id) initWithPropertyName:(NSString*) name
//              propertyClass:(Class) propertyClass
//                 arrayTypes:(NSArray*) arrayTypes
//           isUnboundedArray:(BOOL) isUnboundedArray;
//
//+ (FLPropertyType*) propertyType:(NSString*) name
//                                 propertyClass:(Class) propertyClass
//                                    arrayTypes:(NSArray*) arrayTypes
//                              isUnboundedArray:(BOOL) isUnboundedArray;
//
//
//@end

