//
//  FLObjectDescriber.m
//  PackMule
//
//  Created by Mike Fullerton on 6/30/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLObjectDescriber.h"

#import "FLObjcRuntime.h"

@interface FLObjectDescriber ()
@property (readwrite, copy, nonatomic) NSDictionary* properties;
@property (readwrite, assign, nonatomic) Class describingClass;
- (void) addSuperclassProperties;
- (void) discoverProperties;
@end

@implementation FLObjectDescriber

@synthesize properties = _properties;
@synthesize describingClass = _describingClass;

//+ (void) addPropertiesForClass:(Class) class dictionary:(NSMutableDictionary*) dictionary {
//	if(class) {
//        FLObjectDescriber* describer = [class objectDescriber];
//        if(describer) {
//            [self addPropertiesForClass:[class superclass] dictionary:dictionary];
//            [dictionary addEntriesFromDictionary:describer.properties];
//        }
//    }
//}

- (id) initWithClass:(Class) aClass withProperties:(NSDictionary*) properties {
    FLAssertNotNil_(aClass);
	if((self = [super init])) {
        _describingClass = aClass;
        _properties = [properties mutableCopy];
	}
	
	return self;
}

- (id) initWithClass:(Class) aClass {
    FLAssertNotNil_(aClass);
	if((self = [super init])) {
        _describingClass = aClass;
        _properties = [[NSMutableDictionary alloc] init];
        [self addSuperclassProperties];
        [self discoverProperties];
	}
    return self;
}

- (void) dealloc {
	FLRelease(_properties);
	FLSuperDealloc();
}

- (id) copyWithZone:(NSZone *)zone {
	return [[FLObjectDescriber alloc] initWithClass:self.class withProperties:self.properties];
}

- (void) addProperty:(FLPropertyType*) objectDescriber forPropertyName:(NSString*) propertyName {
	[_properties setObject:objectDescriber forKey:propertyName];
}

- (void) addProperty:(FLPropertyType*) property {
    [self addProperty:property forPropertyName:property.propertyName];
}

- (FLPropertyType*) propertyForName:(NSString*) propertyName {
	return [_properties objectForKey:propertyName];
}

- (void) addSuperclassProperties {
    FLObjectDescriber* describer = [[_describingClass superclass] objectDescriber];
    if(describer) {
        [_properties addEntriesFromDictionary:describer.properties];
    }
}

- (void) discoverProperties {
    
    unsigned int propertyCount = 0;
	objc_property_t* properties = class_copyPropertyList(_describingClass, &propertyCount);

	for(unsigned int i = 0; i < propertyCount; i++) {
		char* className = copyTypeNameFromProperty(properties[i]);
	//	printf("name: %s, attributes %s\n",name, attributes);
		
		if(className) {
			Class theClass = objc_getClass(className);
			
			FLAssertIsNotNil_(theClass);
			   
			NSString* propertyName = [NSString stringWithCString:property_getName(properties[i]) encoding:NSASCIIStringEncoding];

// TODO: build up FLType

            FLPropertyType* property = [FLPropertyType propertyType:propertyName propertyClass:theClass];

            [self addProperty:property];
						 
			free(className);
	
		//	printf("\tname: %s, value: '%s'\n", attrList[j].name, attrList[j].value);
		}
		
	}

    free(properties);
}

+ (id) objectDescriber:(Class) aClass {
    return FLAutorelease([[[self class] alloc] initWithClass:aClass]);
}

- (NSString*) description {
	return [NSString stringWithFormat:@"%@:%@", [super description], [_properties description]];
}

- (void) addProperty:(NSString*) name withClass:(Class) propertyClass {
    [self addProperty:[FLPropertyType propertyType:name propertyClass:propertyClass]];
}

- (void) addProperty:(NSString*) name withArrayType:(FLPropertyType*) arrayType {
    [self addProperty:name withArrayTypes:[NSArray arrayWithObject:arrayType]];
}

- (void) addProperty:(NSString*) name withArrayTypes:(NSArray*) types {
    [self addProperty:[FLPropertyType propertyType:name propertyClass:[NSMutableArray class] arrayTypes:types]];
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

@implementation FLDescribeableObject

+ (FLObjectDescriber*) objectDescriber {
    @synchronized(self) {
        return [FLObjectDescriber objectDescriber:[self class]];
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

    for(FLPropertyType* property in describer.properties.objectEnumerator) {

        id value = [property propertyValueForObject:self];

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
    [self visitDescribedObjectAndProperties:^(id object, FLPropertyType* prop, BOOL* stop) {
        FLPerformSelector(object, sel);
    }];

}
- (void) performSelectorOnDescribedObjectAndProperties:(SEL) sel
                                            withObject:(id) object1 {
    [self visitDescribedObjectAndProperties:^(id object, FLPropertyType* prop, BOOL* stop) {
        FLPerformSelector1(object, sel, object1);
    }];

}
- (void) performSelectorOnDescribedObjectAndProperties:(SEL) sel
                                            withObject:(id) object1
                                            withObject:(id) object2{
    [self visitDescribedObjectAndProperties:^(id object, FLPropertyType* prop, BOOL* stop) {
        FLPerformSelector2(object, sel, object1, object2);
    }];

}
- (void) performSelectorOnDescribedObjectAndProperties:(SEL) sel
                                            withObject:(id) object1
                                            withObject:(id) object2
                                            withObject:(id) object3 {
    [self visitDescribedObjectAndProperties:^(id object, FLPropertyType* prop, BOOL* stop) {
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
//	for(FLPropertyType* desc in arrayItemTypes) {
//		if([outer isKindOfClass:desc.classForType]) {
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
                
                for(FLPropertyType* desc in arrayItemTypes) {
                    if([outer isKindOfClass:desc.propertyClass]) {
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
//		if([[arrayItemTypes firstObject] propertyType].isObjectWithObjectProperties) {
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
		FLAssert_v([dest isKindOfClass:[src class]], @"objects are different classes");

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
					FLPropertyType* srcProp = [srcDescriber propertyForName:srcPropName];
					FLObjectDescriber* propDescriber = [srcProp.propertyClass objectDescriber];
                    
                    if(!propDescriber) {
					   if(mergeMode == FLMergeModeSourceWins) {
							[dest setValue:srcObject forKey:srcPropName];
					   }
					}
					else if(srcProp.arrayTypes.count > 0) {
						FLMergeObjectArrays(destObject, srcObject, mergeMode, srcProp.arrayTypes);
					}
					else {
						FLMergeObjects(destObject, srcObject, mergeMode);
					}
				}
			}
		}
	}
}
