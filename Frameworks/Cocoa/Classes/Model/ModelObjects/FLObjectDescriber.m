//
//  FLObjectDescriber.m
//  PackMule
//
//  Created by Mike Fullerton on 6/30/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLObjectDescriber.h"

#import "FLObjcRuntime.h"
#import "FLPropertyAttributes.h"
typedef void (^FLObjectDescriberPropertyVisitor)(id object, FLObjectDescriber* objectDescriber, BOOL* stop);

@interface FLObjectDescriber ()
@property (readwrite, copy, nonatomic) NSDictionary* properties;
@property (readwrite, assign, nonatomic) Class objectClass;
@property (readwrite, strong, nonatomic) NSString* objectName;
@property (readwrite, assign, nonatomic) FLPropertyAttributes_t propertyAttributes;

- (void) addSuperclassProperties;
- (void) discoverProperties;

//- (id) initWithRuntimeProperty:(objc_property_t) runtimeProperty;
//+ (id) objectDescriberWithRuntimeProperty:(objc_property_t) property;

@end

@implementation FLObjectDescriber

@synthesize properties = _properties;
@synthesize objectClass = _objectClass;
@synthesize objectName = _objectName;
@synthesize objectEncoder = _objectEncoder;
@synthesize propertyAttributes = _propertyAttributes;

//+ (void) addPropertiesForClass:(Class) class dictionary:(NSMutableDictionary*) dictionary {
//	if(class) {
//        FLObjectDescriber* describer = [class objectDescriber];
//        if(describer) {
//            [self addPropertiesForClass:[class superclass] dictionary:dictionary];
//            [dictionary addEntriesFromDictionary:describer.properties];
//        }
//    }
//}

//- (id) initWithClass:(Class) aClass 
//      withProperties:(NSDictionary*) properties {
//    FLAssertNotNil(aClass);
//	if((self = [super init])) {
//        _objectClass = aClass;
//        _properties = [properties mutableCopy];
//	}
//	
//	return self;
//}


- (id) init {
    return [self initWithClass:nil withObjectName:nil];
}

- (id) initWithClass:(Class) aClass 
      withObjectName:(NSString*) name {
    FLAssertNotNil(aClass);
	if((self = [super init])) {
        self.objectName = name; 
        _objectClass = aClass;
        _properties = [[NSMutableDictionary alloc] init];
        [self addSuperclassProperties];
        [self discoverProperties];
        self.objectEncoder = [self.objectClass objectEncoder];
    }
    return self;
}

- (id) initWithClass:(Class) aClass {
    return [self initWithClass:aClass withObjectName:NSStringFromClass([self class])];
}

+ (id) objectDescriberForClass:(Class) aClass
                withObjectName:(NSString*) name {
	return FLAutorelease([[[self class] alloc] initWithClass:aClass withObjectName:name]);
}

+ (id) objectDescriber:(NSString*) name objectClass:(Class) aClass {
    return [FLObjectDescriber objectDescriberForClass:aClass withObjectName:name];
}


//+ (id) objectDescriberWithRuntimeProperty:(objc_property_t) property {
//	return FLAutorelease([[[self class] alloc] initWithRuntimeProperty:property]);
//}
//
+ (id) objectDescriberWithRuntimeProperty:(objc_property_t) runtimeProperty {

    FLPropertyAttributes_t attributes;
    FLPropertyAttributesDecodeWithCopy(runtimeProperty, &attributes);
    
    if(attributes.className.string) {
        NSString* objectName = [NSString stringWithCString:attributes.propertyName encoding:NSASCIIStringEncoding];
        Class objectClass = NSClassFromString([NSString stringWithCharString:attributes.className]);
    
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriberForClass:objectClass withObjectName:objectName];
        describer.propertyAttributes = attributes;
        describer.objectEncoder = [objectClass objectEncoder]; 
        return describer;
    }
    
    FLLog(@"unable to make object describer for %s", attributes.encodedAttributes);
    FLPropertyAttributesFree(&attributes);
    
    
    return nil;
}

- (void) dealloc {
    FLPropertyAttributesFree(&_attributes);

#if FL_MRC
    [_objectName release];
    [_properties release];
	[super dealloc];
#endif
}

- (BOOL) hasProperties {
	return _properties.count > 0;
}	

//- (id) copyWithZone:(NSZone *)zone {
//	return [[FLObjectDescriber alloc] initWithClass:self.class withProperties:self.properties];
//}

- (FLObjectDescriber*) childDescriberForObjectName:(NSString*) propertyName {
	return [_properties objectForKey:propertyName];
}

- (void) addSuperclassProperties {
    FLObjectDescriber* describer = [[_objectClass superclass] objectDescriber];
    if(describer) {
        [_properties addEntriesFromDictionary:describer.properties];
    }
}

- (void) addChildDescriberWithName:(FLObjectDescriber*) property {
    FLAssertNotNil(property);
    if(property.objectClass) {
        [_properties setObject:property forKey:property.objectName];
    }
//    else {
//        FLLog(@"skipping property %@", property.objectName);
//    }
}

- (void) discoverProperties {
    
    unsigned int propertyCount = 0;
	objc_property_t* properties = class_copyPropertyList(_objectClass, &propertyCount);

	for(unsigned int i = 0; i < propertyCount; i++) {
    
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriberWithRuntimeProperty:properties[i]];
        if(describer) {
            [self addChildDescriberWithName:describer];
        }
	}

    free(properties);
}

//+ (id) objectDescriber:(Class) aClass {
//    return FLAutorelease([[[self class] alloc] initWithClass:aClass]);
//}

- (NSString*) description {
	return [NSString stringWithFormat:@"%@: { name=%@, class=%@, encoder=%@, properties:%@", [super description], self.objectName, NSStringFromClass(self.objectClass), [self.objectEncoder description], [_properties description]];
}

- (void) addChildDescriberWithName:(NSString*) name withClass:(Class) objectClass {
    FLObjectDescriber* describer = [_properties objectForKey:name];
    if(!describer) {
        [self addChildDescriberWithName:[FLObjectDescriber objectDescriberForClass:objectClass withObjectName:name]];
    }
    else {
        describer.objectEncoder = [objectClass objectEncoder];
    }
}

- (void) addChildDescriberWithName:(NSString*) name withArrayType:(FLObjectDescriber*) arrayType {
    [self addChildDescriberWithName:name withArrayTypes:[NSArray arrayWithObject:arrayType]];
}

- (void) addChildDescriberWithName:(NSString*) name withArrayTypes:(NSArray*) types {
    FLObjectDescriber* describer = [_properties objectForKey:name];
    if(!describer) {
        describer = [FLObjectDescriber objectDescriberForClass:[NSMutableArray class] withObjectName:name];
        [self addChildDescriberWithName:describer];
    }

    for(FLObjectDescriber* obj in types) {
        [describer addChildDescriberWithName:obj];
    }
}

@end

@implementation NSArray (FLObjectDescriber)
- (void) visitSelf:(FLObjectDescriberPropertyVisitor) visitor
              stop:(BOOL*) stop {

    for(id object in self) {
        [object visitSelf:visitor stop:stop];

        if(*stop) {
            return;
        }
    }
}
@end

@implementation NSDictionary (FLObjectDescriber)
- (void) visitSelf:(FLObjectDescriberPropertyVisitor) visitor
              stop:(BOOL*) stop {

    for(id object in [self objectEnumerator]) {

        [object visitSelf:visitor stop:stop];

        if(*stop) {
            return;
        }
    }
}
@end

@implementation NSSet (FLObjectDescriber)
- (void) visitSelf:(FLObjectDescriberPropertyVisitor) visitor
              stop:(BOOL*) stop {

    for(id object in [self objectEnumerator]) {

        [object visitSelf:visitor stop:stop];

        if(*stop) {
            return;
        }
    }
}
@end

@implementation FLSelfDescribingObject

+ (FLObjectDescriber*) objectDescriber {
    @synchronized(self) {
        return [FLObjectDescriber objectDescriberForClass:[self class] withObjectName:NSStringFromClass([self class])];
    }
	return nil;
}

@end

@implementation NSObject (FLObjectDescriber)

+ (FLObjectDescriber*) objectDescriber {
    return nil;
}

- (FLObjectDescriber*) objectDescriber {
    return [[self class] objectDescriber];
}

- (void) visitSelf:(FLObjectDescriberPropertyVisitor) visitor
              stop:(BOOL*) stop {

    visitor(self, nil, stop);

    if(*stop) {
        return;
    }

    FLObjectDescriber* describer = [[self class] objectDescriber];

    for(FLObjectDescriber* property in describer.properties.objectEnumerator) {

        id value = [self valueForKey:property.objectName]; //[property propertyValueForObject:self];

        if(value) {
            [value visitSelf:visitor stop:stop];

            if(*stop) {
                return;
            }
        }
    }
}

- (void) visitDescribedObjectAndProperties:(FLObjectDescriberPropertyVisitor) visitor {
    BOOL stop = NO;
    [self visitSelf:visitor stop:&stop];
}


- (void) performSelectorOnDescribedObjectAndProperties:(SEL) sel {
    [self visitDescribedObjectAndProperties:^(id object, FLObjectDescriber* prop, BOOL* stop) {
        FLPerformSelector(object, sel);
    }];

}
- (void) performSelectorOnDescribedObjectAndProperties:(SEL) sel
                                            withObject:(id) object1 {
    [self visitDescribedObjectAndProperties:^(id object, FLObjectDescriber* prop, BOOL* stop) {
        FLPerformSelector1(object, sel, object1);
    }];

}
- (void) performSelectorOnDescribedObjectAndProperties:(SEL) sel
                                            withObject:(id) object1
                                            withObject:(id) object2{
    [self visitDescribedObjectAndProperties:^(id object, FLObjectDescriber* prop, BOOL* stop) {
        FLPerformSelector2(object, sel, object1, object2);
    }];

}
- (void) performSelectorOnDescribedObjectAndProperties:(SEL) sel
                                            withObject:(id) object1
                                            withObject:(id) object2
                                            withObject:(id) object3 {
    [self visitDescribedObjectAndProperties:^(id object, FLObjectDescriber* prop, BOOL* stop) {
        FLPerformSelector3(object, sel, object1, object2, object3);
    }];

}


@end


//typedef void (*CompareCallback) (id, id, FLMergeMode, NSArray* arrayItemTypes); 
//
//void _FLMergeListsOfObjects(NSMutableArray* dest, 
//                            NSArray* src, 
//                            FLMergeMode mergeMode, 
//                            NSArray* arrayItemTypes,
//                            CompareCallback handleEqual) {
//	
//    for(NSInteger i = (NSInteger) src.count - 1; i >= 0; i--) {	
//		id outer = [src objectAtIndex:i];
//		bool foundIt = NO;
//		for(NSInteger j = (NSInteger) dest.count - 1; j >= 0; j--) {
//			id inner = [dest objectAtIndex:j];
//			if([inner isEqual:outer]) {	
//				handleEqual(inner, outer, mergeMode, arrayItemTypes);
//				foundIt = YES;
//				break;
//			}
//		}
//		if(!foundIt) {
//			[dest addObject:outer];
//		}
//	}
//}
//
//void FLEqualObjectHandler(id inner, id outer, FLMergeMode mergeMode, NSArray* arrayItemTypes) {
//	FLMergeObjects(inner, outer, mergeMode); 
//}
//
//void FLEqualValueHandler(id inner, id outer, FLMergeMode mergeMode, NSArray* arrayItemTypes) {
//	// already equal, so nothing to do.
//}
//
//void FLEqualMultiObjectHandler(id inner, id outer, FLMergeMode mergeMode, NSArray* arrayItemTypes) {
//	for(FLObjectDescriber* desc in arrayItemTypes) {
//		if([outer isKindOfClass:desc.actualClass]) {
//			FLMergeObjects(inner, outer, mergeMode); 
//			break;
//		}
//	}
//	
//
////	FLDataTypeStruct* itemType = FLGetTypeForClass(arrayItemTypes, [outer class]);
////	if(itemType && itemType->typeID == FLDataTypeObject)
////	{
////		FLMergeObjects(inner, outer, mergeMode); 
////	}
//}

void FLMergeObjectArrays(NSMutableArray* dest, 
                         NSArray* src, 
                         FLMergeMode mergeMode, 
                         NSArray* arrayItemTypes){

    for(NSInteger i = (NSInteger) src.count - 1; i >= 0; i--) {	
		id outer = [src objectAtIndex:i];
		bool foundIt = NO;
		for(NSInteger j = (NSInteger) dest.count - 1; j >= 0; j--) {
			id inner = [dest objectAtIndex:j];
			if([inner isEqual:outer]) {	
                
                for(FLObjectDescriber* desc in arrayItemTypes) {
                    if([outer isKindOfClass:desc.objectClass]) {
                        FLMergeObjects(inner, outer, mergeMode); 
                        foundIt = YES;
				        break;
                    }
                }
                
                break;
			}
		}
		if(!foundIt) {
			[dest addObject:outer];
		}
	}



//	if(arrayItemTypes.count) {
//		if([[arrayItemTypes firstObject] objectDescriber].isObjectWithObjectProperties) {
//			_FLMergeListsOfObjects(dest, src, mergeMode, arrayItemTypes, FLEqualObjectHandler);
//		}
//		else {
//			_FLMergeListsOfObjects(dest, src, mergeMode, arrayItemTypes, FLEqualValueHandler);
//		}
//	}
//	else {
//		_FLMergeListsOfObjects(dest, src, mergeMode, arrayItemTypes, FLEqualMultiObjectHandler);
//	}
}

void FLMergeObjects(id dest, id src, FLMergeMode mergeMode) {
	if(dest && src) {
		FLAssertWithComment([dest isKindOfClass:[src class]], @"objects are different classes");

		FLObjectDescriber* srcDescriber = [[src class] objectDescriber];
        if(!srcDescriber) {
            return;
        }   
        
		for(NSString* srcPropName in srcDescriber.properties) {
			id srcObject = [src valueForKey:srcPropName];
			
            if(srcObject) {
				id destObject =	[dest valueForKey:srcPropName];
				if(!destObject) {
					[dest setValue:srcObject forKey:srcPropName];
				}
				else {
					FLObjectDescriber* srcProp = [srcDescriber childDescriberForObjectName:srcPropName];
					FLObjectDescriber* propDescriber = [srcProp.objectClass objectDescriber];
                    
                    if(!propDescriber) {
					   if(mergeMode == FLMergeModeSourceWins) {
							[dest setValue:srcObject forKey:srcPropName];
					   }
					}
					else if(srcProp.properties.count > 0) {
						FLMergeObjectArrays(destObject, srcObject, mergeMode, [srcProp.properties allValues]);
					}
					else {
						FLMergeObjects(destObject, srcObject, mergeMode);
					}
				}
			}
		}
	}
}
