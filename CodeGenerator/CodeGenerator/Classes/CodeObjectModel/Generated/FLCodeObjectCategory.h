// [Generated]
//
// This file was generated at 7/10/12 5:03 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeObjectCategory.h
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLModelObject.h"


@class FLCodeMethod;
@class FLCodeProperty;

// FLCodeObjectCategory
@interface FLCodeObjectCategory : FLModelObject { 
@private
    NSString* __objectName;
    NSString* __categoryName;
    NSMutableArray* __properties;
    NSMutableArray* __methods;
}

/// @brief: name of the type, e.g. bagelCount
@property (readwrite, strong, nonatomic) NSString* categoryName;

/// @brief: Getter will create __methods if nil. Alternately, use the methodsObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) NSMutableArray* methods;
/// Type: FLCodeMethod*, forKey: method

/// @brief: name of the type, e.g. bagelCount
@property (readwrite, strong, nonatomic) NSString* objectName;

/// @brief: Getter will create __properties if nil. Alternately, use the propertiesObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) NSMutableArray* properties;
/// Type: FLCodeProperty*, forKey: property

+ (FLCodeObjectCategory*) objectCategory; 

/// @brief: This returns __properties. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) NSMutableArray* propertiesObject;
/// Type: FLCodeProperty*, forKey: property

/// @brief: This returns __methods. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) NSMutableArray* methodsObject;
/// Type: FLCodeMethod*, forKey: method

- (void) createPropertiesIfNil; 

- (void) createMethodsIfNil; 
@end

// [/Generated]
