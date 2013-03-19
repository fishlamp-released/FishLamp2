//
//  FLObjectDescriber.m
//  PackMule
//
//  Created by Mike Fullerton on 6/29/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

//#import "FLObjectDescriber.h"
//#import "FLStringUtils.h"
//#import "FLPropertyAttributes.h"
//#import "FLCharString.h"
//#import "NSString+FLCharString.h"
//
//@interface FLObjectDescriber ()
//@property (readwrite, strong, nonatomic) NSString* propertyName;
////@property (readwrite, strong, nonatomic) NSArray* properties;
////@property (readwrite, strong, nonatomic) FLObjectEncoder* objectDescriber;
//@end
//
//@implementation FLObjectDescriber
//
//@synthesize properties = _properties;
//@synthesize objectEncoder = _objectEncoder;
//@synthesize propertyName = _propertyName;
//@synthesize objectClass = _objectClass;
//
//- (id) initWithPropertyName:(NSString*) name
//              objectClass:(Class) objectClass
//              properties:(NSArray*) properties {
//
//	if((self = [super init])) {
//		FLAssertStringIsNotEmpty_(name);
//        self.propertyName = name;
//        _objectClass = objectClass;
//        self.properties = properties;
//	}
//	
//	return self;
//}
//
//
//- (id) initWithPropertyName:(NSString*) name
//              objectClass:(Class) objectClass {
//    return [self initWithPropertyName:name objectClass:objectClass properties:nil];
//}
//
//
//+ (FLObjectDescriber*) objectDescriber:(NSString*) name
//                   objectClass:(Class) objectClass {
//
//	return FLAutorelease([[FLObjectDescriber alloc] initWithPropertyName:name objectClass:objectClass properties:nil]);
//}
//
//
//+ (FLObjectDescriber*) objectDescriber:(NSString*) name
//                   objectClass:(Class) objectClass
//                      properties:(NSArray*) properties {
//
//	return FLAutorelease([[FLObjectDescriber alloc] initWithPropertyName:name objectClass:objectClass properties:properties]);
//}
//
//- (void) dealloc {
//    FLPropertyAttributesFree(&_attributes);
//
//#if FL_MRC
//    [_objectEncoder release];
//    [_properties release];
//    [_propertyName release];
//    [super dealloc];
//#endif
//}
//
//- (BOOL) properties {
//	return _properties.count > 0;
//}	
//
//- (NSString*) description {
//	return [NSString stringWithFormat:@"%@: Name: %@, Class: %@, ArrayTypes:\n%@",
//		[super description],
//		self.propertyName,
//		NSStringFromClass(self.objectClass),
//		[self.properties description]];
//}
//
////- (void) setPropertyValue:(id) value forObject:(id) object {
////    [object setValue:value forKey:self.propertyName];
////}
////
////- (id) propertyValueForObject:(id) object {
////    return [object valueForKey:self.propertyName];
////}
//
//@end
//
