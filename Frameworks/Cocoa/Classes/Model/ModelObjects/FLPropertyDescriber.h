//
//  FLPropertyDescriber.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/22/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLObjectDescriber;

@interface FLPropertyDescriber : NSObject<NSCopying> {
@private
    NSString* _propertyName;
    FLObjectDescriber* _propertyType;
    NSMutableArray* _containedTypes;
}
@property (readonly, assign) Class propertyClass;
@property (readonly, strong) NSString* propertyName;
@property (readonly, strong) FLObjectDescriber* propertyType;

@property (readonly, copy) NSArray* containedTypes;
@property (readonly, assign) NSUInteger containedTypesCount;
- (FLPropertyDescriber*) containedTypeForIndex:(NSUInteger) idx;

+ (id) propertyDescriber:(NSString*) identifier 
            propertyType:(FLObjectDescriber*) propertyType;

+ (id) propertyDescriber:(NSString*) identifier 
           propertyClass:(Class) aClass;

+ (id) propertyDescriber:(NSString*) identifier 
           propertyClass:(Class) aClass 
          containedTypes:(NSArray*) containedTypes;
          
- (FLPropertyDescriber*) containedTypeForName:(NSString*) name;

// deprecated
+ (id) propertyDescriber:(NSString*) name class:(Class) aClass;

@end
