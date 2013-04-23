//
//  FLPropertyDescriber.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/22/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLPropertyDescriber.h"
#import "FLObjectDescriber.h"

@interface FLPropertyDescriber ()
@property (readwrite) NSString* propertyName;
@property (readwrite) FLObjectDescriber* propertyType;
@property (readwrite, copy) NSArray* containedTypes;
@end

@implementation FLPropertyDescriber
@synthesize propertyName = _propertyName;
@synthesize propertyType = _propertyType;
@synthesize containedTypes = _containedTypes;

- (id) initWithPropertyName:(NSString*) propertyName 
               propertyType:(FLObjectDescriber*) propertyType
             containedTypes:(NSArray*) containedTypes {	

    FLAssertNotNil(propertyName);
    FLAssertNotNil(propertyType);
	self = [super init];
	if(self) {
        self.propertyType = propertyType;
        self.propertyName = propertyName;
        _containedTypes = [containedTypes copy];
	}
	return self;
}

+ (id) propertyDescriber:(NSString*) name propertyClass:(Class) aClass {
    return [FLPropertyDescriber propertyDescriber:name propertyClass:aClass containedTypes:nil];
}
+ (id) propertyDescriber:(NSString*) name class:(Class) aClass {
    return [FLPropertyDescriber propertyDescriber:name propertyClass:aClass containedTypes:nil];
}

+ (id) propertyDescriber:(NSString*) name 
            propertyType:(FLObjectDescriber*) propertyType {
    return FLAutorelease([[[self class] alloc] initWithPropertyName:name propertyType:propertyType containedTypes:nil]);
}            

+ (id) propertyDescriber:(NSString*) name 
           propertyClass:(Class) aClass 
          containedTypes:(NSArray*) containedTypes {

    FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:aClass];
    if(describer) {
        return FLAutorelease([[FLPropertyDescriber alloc] initWithPropertyName:name 
                                                                  propertyType:describer 
                                                                containedTypes:containedTypes]);
    }
    
    return nil;
}

- (id) copyWithZone:(NSZone *)zone {
    return [[FLPropertyDescriber alloc] initWithPropertyName:_propertyName 
                                                propertyType:_propertyType 
                                              containedTypes:FLCopyWithAutorelease(_containedTypes)];
}

- (Class) propertyClass {
    return _propertyType.objectClass;
}   

- (FLPropertyDescriber*) containedTypeForName:(NSString*) name {
    @synchronized(self) {
        for(FLPropertyDescriber* property in _containedTypes) {
            if(FLStringsAreEqual(property.propertyName, name)) {
                return property;
            }
        }
    }
    return nil;
}

- (NSUInteger) containedTypesCount {
    @synchronized(self) {
        return _containedTypes.count;
    }
}

- (FLPropertyDescriber*) containedTypeForIndex:(NSUInteger) idx {
    @synchronized(self) {
        return [_containedTypes objectAtIndex:idx];
    }
}

- (void) setContainedTypes:(NSArray*) types {
    @synchronized(self) {
        FLSetObjectWithCopy(_containedTypes, types);
    }
}

- (NSArray*) containedTypes {
    @synchronized(self) {
        return FLCopyWithAutorelease(_containedTypes);
    }
}

//- (void) describeTo:(FLPrettyString*) string {
//    [string appendLineWithFormat:@"propertyName %@, propertyType %@", self.propertyName, [self.propertyType description]];
//}

- (NSString*) description {
    
    FLPrettyString* contained = nil;
    
    for(FLPropertyDescriber* describer in _containedTypes) {
        if(!contained) {
            contained = [FLPrettyString prettyString];
            [contained indent];
        }
    
        [contained appendBlankLine];
        [contained appendFormat:@"%@", [describer description]];
    }
    
    return [NSString stringWithFormat:@"%@: %@ %@", self.propertyName, NSStringFromClass(self.propertyClass), contained ? [contained string] : @""];
}

#if FL_MRC
- (void) dealloc {
    [_propertyType release];
	[_propertyName release];
    [_containedTypes release];
    [super dealloc];
}
#endif
@end
