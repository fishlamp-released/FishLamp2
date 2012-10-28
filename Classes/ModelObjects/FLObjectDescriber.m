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
@property (readwrite, copy, nonatomic) NSDictionary* propertyDescribers;
@end

@implementation FLObjectDescriber

@synthesize propertyDescribers = _properties;

- (id) init {
	if((self = [super init])) {
		_properties = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

- (id) initWithPropertyDescribers:(NSDictionary*) describers {
	if((self = [super init])) {
		_properties = [[NSMutableDictionary alloc] init];
		for(FLPropertyDescription* prop in describers.objectEnumerator) {
			[self setPropertyDescriber:prop forPropertyName:prop.propertyName];
		}
	}
	
	return self;
}

- (id) _initWithDictionaryForCopy:(NSDictionary*) dictionary {
	if((self = [super init])) {
		_properties = [dictionary mutableCopy];
	}
	
	return self;
}

- (void) dealloc {
	FLRelease(_properties);
	FLSuperDealloc();
}

- (id) copyWithZone:(NSZone *)zone {
	FLObjectDescriber* desc = [[FLObjectDescriber alloc] _initWithDictionaryForCopy:self.propertyDescribers];
	return desc;
}

- (void) setPropertyDescriber:(FLPropertyDescription*) objectDescriber forPropertyName:(NSString*) propertyName {
	[_properties setObject:objectDescriber forKey:propertyName];
	
	if(objectDescriber.isUnboundedArray) {
		for(FLPropertyDescription* prop in objectDescriber.arrayTypes) {
			FLAssertIsNil_([_properties objectForKey:prop.propertyName]);
			[_properties setObject:prop forKey:prop.propertyName];
		}
	}
}

- (FLPropertyDescription*) propertyDescriberForPropertyName:(NSString*) propertyName {
	return [_properties objectForKey:propertyName];
}

- (void) addPropertiesForClass:(Class) class {
	if(class == [NSObject class]) {
		return;
	}

	Class superclass = class_getSuperclass(class);
	if(superclass) {
		[self addPropertiesForClass:superclass];
	}

	unsigned int propertyCount = 0;
	objc_property_t* properties = class_copyPropertyList(class, &propertyCount);

	for(unsigned int i = 0; i < propertyCount; i++) {
		char* className = copyTypeNameFromProperty(properties[i]);
	//	printf("name: %s, attributes %s\n",name, attributes);
		
		if(className) {
			Class c = objc_getClass(className);
			
			FLAssertIsNotNil_(c);
			   
			NSString* propertyName = [NSString stringWithCString:property_getName(properties[i]) encoding:NSASCIIStringEncoding];
			
			[self setPropertyDescriber:[FLPropertyDescription propertyDescription:propertyName
				propertyClass:c
				propertyType:FLDataTypeUnknown
				arrayTypes:nil] forPropertyName:propertyName];
							 
			free(className);
	
		//	printf("\tname: %s, value: '%s'\n", attrList[j].name, attrList[j].value);
		}
		
	}

    free(properties);
}

- (NSString*) description {
	return [NSString stringWithFormat:@"%@:%@", [super description], [_properties description]];
}

- (void) visitAllProperties:(FLObjectDescriberPropertyVisitor) visitor {
    for(FLPropertyDescription* property in _properties.objectEnumerator) {
        visitor(property);
    }
}

@end

@implementation NSObject (FLObjectDescriber)

+ (FLObjectDescriber*) sharedObjectDescriber {
	return nil;
}

- (FLObjectDescriber*) objectDescriber {
    return [[self class] sharedObjectDescriber];
}

@end


typedef void (*CompareCallback) (id, id, FLMergeMode, NSArray* arrayItemTypes); 

void _FLMergeListsOfObjects(NSMutableArray* dest, 
                            NSArray* src, 
                            FLMergeMode mergeMode, 
                            NSArray* arrayItemTypes,
                            CompareCallback handleEqual) {
	
    for(NSInteger i = (NSInteger) src.count - 1; i >= 0; i--) {	
		id outer = [src objectAtIndex:i];
		bool foundIt = NO;
		for(NSInteger j = (NSInteger) dest.count - 1; j >= 0; j--) {
			id inner = [dest objectAtIndex:j];
			if([inner isEqual:outer]) {	
				handleEqual(inner, outer, mergeMode, arrayItemTypes);
				foundIt = YES;
				break;
			}
		}
		if(!foundIt) {
			[dest addObject:outer];
		}
	}
}

void FLEqualObjectHandler(id inner, id outer, FLMergeMode mergeMode, NSArray* arrayItemTypes) {
	FLMergeObjects(inner, outer, mergeMode); 
}

void FLEqualValueHandler(id inner, id outer, FLMergeMode mergeMode, NSArray* arrayItemTypes) {
	// already equal, so nothing to do.
}

void FLEqualMultiObjectHandler(id inner, id outer, FLMergeMode mergeMode, NSArray* arrayItemTypes) {
	for(FLPropertyDescription* desc in arrayItemTypes) {
		if([outer isKindOfClass:desc.propertyClass] && desc.propertyType == FLDataTypeObject) {
			FLMergeObjects(inner, outer, mergeMode); 
			break;
		}
	}
	

//	FLDataTypeStruct* itemType = FLGetTypeForClass(arrayItemTypes, [outer class]);
//	if(itemType && itemType->typeID == FLDataTypeObject)
//	{
//		FLMergeObjects(inner, outer, mergeMode); 
//	}
}

void FLMergeObjectArrays(NSMutableArray* dest, 
                         NSArray* src, 
                         FLMergeMode mergeMode, 
                         NSArray* arrayItemTypes){

	if(arrayItemTypes.count) {
		if([[arrayItemTypes firstObject] propertyType] == FLDataTypeObject) {
			_FLMergeListsOfObjects(dest, src, mergeMode, arrayItemTypes, FLEqualObjectHandler);
		}
		else {
			_FLMergeListsOfObjects(dest, src, mergeMode, arrayItemTypes, FLEqualValueHandler);
		}
	}
	else {
		_FLMergeListsOfObjects(dest, src, mergeMode, arrayItemTypes, FLEqualMultiObjectHandler);
	}
}

void FLMergeObjects(id dest, id src, FLMergeMode mergeMode) {
	if(dest && src) {
		FLCAssert_v([dest isKindOfClass:[src class]], @"objects are different classes");

		FLObjectDescriber* srcDescriber = [[src class] sharedObjectDescriber];
		for(NSString* srcPropName in srcDescriber.propertyDescribers) {
			id srcObject = [src valueForKey:srcPropName];
			
            if(srcObject) {
				id destObject =	[dest valueForKey:srcPropName];
				if(!destObject) {
					[dest setValue:srcObject forKey:srcPropName];
				}
				else {
					FLPropertyDescription* srcProp = [srcDescriber propertyDescriberForPropertyName:srcPropName];
					if(srcProp.propertyType != FLDataTypeObject) {
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
