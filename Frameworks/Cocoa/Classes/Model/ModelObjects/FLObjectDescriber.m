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

@interface FLTypeDesc (FLObjectDescriber)
+ (id) typeDescWithRuntimeProperty:(objc_property_t) runtimeProperty;
@end


@implementation FLTypeDesc (FLObjectDescriber)

+ (id) typeDescWithRuntimeProperty:(objc_property_t) runtimeProperty {

    FLPropertyAttributes_t attributes;
    FLPropertyAttributesDecodeWithNoCopy(runtimeProperty, &attributes);
    
    if(attributes.className.string) {
        NSString* identifier = [NSString stringWithCString:attributes.propertyName encoding:NSASCIIStringEncoding];
        Class objectClass = NSClassFromString([NSString stringWithCharString:attributes.className]);
        return [FLTypeDesc typeDesc:identifier class:objectClass];
    }
    
#if TRACE    
    FLLog(@"unable to make object typeDesc for %s", attributes.encodedAttributes);
#endif    
    return nil;
}
@end

@interface FLObjectDescriber ()
- (void) addSuperclassChildren;
- (void) discoverChildren;
@end

@implementation FLObjectDescriber

- (id) initWithClass:(Class) aClass {
	if((self = [super initWithClass:aClass])) {
        [self addSuperclassChildren];
        [self discoverChildren];
    }
    return self;
}

+ (id) objectDescriber:(Class) aClass {
	return FLAutorelease([[[self class] alloc] initWithClass:aClass]);
}

- (void) addSuperclassChildren {
    FLObjectDescriber* typeDesc = [[self.objectClass superclass] objectDescriber];
    if(typeDesc) {
        for(FLTypeDesc* desc in typeDesc.subtypes.objectEnumerator) {
            [self addSubtype:desc];
        }
    }
}

- (void) discoverChildren {
    unsigned int propertyCount = 0;
	objc_property_t* subtypes = class_copyPropertyList(self.objectClass, &propertyCount);

	for(unsigned int i = 0; i < propertyCount; i++) {
    
        FLTypeDesc* typeDesc = [FLTypeDesc typeDescWithRuntimeProperty:subtypes[i]];
        if(typeDesc) {
            [self addSubtype:typeDesc];
        }
	}

    free(subtypes);
}

- (void) setChildForIdentifier:(NSString*) name withClass:(Class) objectClass {
    [self setSubtypeClass:objectClass forIdentifier:name];
}

//- (void) setChildForIdentifier:(NSString*) name withArrayType:(FLObjectDescriber*) arrayType {
//    [self setChildForIdentifier:name withArrayTypes:[NSArray arrayWithObject:arrayType]];
//}

- (void) setChildForIdentifier:(NSString*) name withArrayTypes:(NSArray*) types {
    [self setSubtypeArrayTypes:types forIdentifier:name];
}

@end

//typedef void (^FLObjectDescriberPropertyVisitor)(id object, FLObjectDescriber* objectDescriber, BOOL* stop);
//
//@implementation NSArray (FLObjectDescriber)
//- (void) visitSelf:(FLObjectDescriberPropertyVisitor) visitor
//              stop:(BOOL*) stop {
//
//    for(id object in self) {
//        [object visitSelf:visitor stop:stop];
//
//        if(*stop) {
//            return;
//        }
//    }
//}
//@end
//
//@implementation NSDictionary (FLObjectDescriber)
//- (void) visitSelf:(FLObjectDescriberPropertyVisitor) visitor
//              stop:(BOOL*) stop {
//
//    for(id object in [self objectEnumerator]) {
//
//        [object visitSelf:visitor stop:stop];
//
//        if(*stop) {
//            return;
//        }
//    }
//}
//@end
//
//@implementation NSSet (FLObjectDescriber)
//- (void) visitSelf:(FLObjectDescriberPropertyVisitor) visitor
//              stop:(BOOL*) stop {
//
//    for(id object in [self objectEnumerator]) {
//
//        [object visitSelf:visitor stop:stop];
//
//        if(*stop) {
//            return;
//        }
//    }
//}
//@end

@implementation FLSelfDescribingObject

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

//- (void) visitSelf:(FLObjectDescriberPropertyVisitor) visitor
//              stop:(BOOL*) stop {
//
//    visitor(self, nil, stop);
//
//    if(*stop) {
//        return;
//    }
//
//    FLObjectDescriber* typeDesc = [[self class] objectDescriber];
//
//    for(FLTypeDesc* property in typeDesc.subtypes.objectEnumerator) {
//
//        id value = [self valueForKey:property.identifier]; //[property propertyValueForObject:self];
//
//        if(value) {
//            [value visitSelf:visitor stop:stop];
//
//            if(*stop) {
//                return;
//            }
//        }
//    }
//}
//
//- (void) visitDescribedObjectAndsubtypes:(FLObjectDescriberPropertyVisitor) visitor {
//    BOOL stop = NO;
//    [self visitSelf:visitor stop:&stop];
//}
//
//
//- (void) performSelectorOnDescribedObjectAndsubtypes:(SEL) sel {
//    [self visitDescribedObjectAndsubtypes:^(id object, FLObjectDescriber* prop, BOOL* stop) {
//        FLPerformSelector(object, sel);
//    }];
//
//}
//- (void) performSelectorOnDescribedObjectAndsubtypes:(SEL) sel
//                                            withObject:(id) object1 {
//    [self visitDescribedObjectAndsubtypes:^(id object, FLObjectDescriber* prop, BOOL* stop) {
//        FLPerformSelector1(object, sel, object1);
//    }];
//
//}
//- (void) performSelectorOnDescribedObjectAndsubtypes:(SEL) sel
//                                            withObject:(id) object1
//                                            withObject:(id) object2{
//    [self visitDescribedObjectAndsubtypes:^(id object, FLObjectDescriber* prop, BOOL* stop) {
//        FLPerformSelector2(object, sel, object1, object2);
//    }];
//
//}
//- (void) performSelectorOnDescribedObjectAndsubtypes:(SEL) sel
//                                            withObject:(id) object1
//                                            withObject:(id) object2
//                                            withObject:(id) object3 {
//    [self visitDescribedObjectAndsubtypes:^(id object, FLObjectDescriber* prop, BOOL* stop) {
//        FLPerformSelector3(object, sel, object1, object2, object3);
//    }];
//
//}


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
//		if([[arrayItemTypes firstObject] objectDescriber].isObjectWithObjectsubtypes) {
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
        
		for(NSString* srcPropName in srcDescriber.subtypes) {
			id srcObject = [src valueForKey:srcPropName];
			
            if(srcObject) {
				id destObject =	[dest valueForKey:srcPropName];
				if(!destObject) {
					[dest setValue:srcObject forKey:srcPropName];
				}
				else {
					FLTypeDesc* srcProp = [srcDescriber subTypeForIdentifier:srcPropName];
					FLTypeDesc* propDescriber = [srcProp.objectClass objectDescriber];
                    
                    if(!propDescriber) {
					   if(mergeMode == FLMergeModeSourceWins) {
							[dest setValue:srcObject forKey:srcPropName];
					   }
					}
					else if(srcProp.subtypes.count > 0) {
						FLMergeObjectArrays(destObject, srcObject, mergeMode, [srcProp.subtypes allValues]);
					}
					else {
						FLMergeObjects(destObject, srcObject, mergeMode);
					}
				}
			}
		}
	}
}
