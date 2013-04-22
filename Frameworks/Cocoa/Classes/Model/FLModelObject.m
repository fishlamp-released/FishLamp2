//
//  FLModelObject.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/21/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLModelObject.h"


@implementation NSObject (FLModelObject)

+ (BOOL) isModelObject {
    return [self respondsToSelector:@selector(objectDescriber)];
}

- (BOOL) isModelObject {
    return [[self class] isModelObject];
}

- (void) encodeModelObjectWithCoder:(NSCoder*) aCoder {
    if([self isModelObject]) {
        FLObjectDescriber* typeDesc = [[self class] objectDescriber];
      
        for(NSUInteger i = 0; i < typeDesc.subTypeCount; i++) {
            FLObjectDescriber* type = [typeDesc subTypeForIndex:i];

            id value = [self valueForKey:type.identifier];
            if(value) {
                [aCoder encodeObject:value forKey:type.identifier];
            }
        }
    }
}

- (id) initModelObjectWithCoder:(NSCoder*) aDecoder {
    self = [self init];
    if(self && [self isModelObject]) {
        FLObjectDescriber* typeDesc = [[self class] objectDescriber];
        
        for(NSUInteger i = 0; i < typeDesc.subTypeCount; i++) {
            FLObjectDescriber* type = [typeDesc subTypeForIndex:i];

            [self setValue:[aDecoder decodeObjectForKey:type.identifier] forKey:type.identifier];
        }
    }

    return self;
}

- (id) copyModelObjectWithZone:(NSZone*) zone {
    if([self isModelObject]) {
        FLObjectDescriber* typeDesc = [[self class] objectDescriber];
        
        id copy = [[[self class] alloc] init];
        for(NSUInteger i = 0; i < typeDesc.subTypeCount; i++) {
            FLObjectDescriber* type = [typeDesc subTypeForIndex:i];

            [copy setValue:FLCopyOrRetainObject([self valueForKey:type.identifier]) forKey:type.identifier];
        }
        return copy;
    }
    
    return nil;
}

@end

@implementation FLIdentifiedObject
@synthesize identifier = _identifier;
#if FL_MRC
- (void) dealloc {
	[_identifier release];
	[super dealloc];
}
#endif
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

        if(![dest isModelObject] || ![src isModelObject]) {
            return;
        }

		FLObjectDescriber* srcDescriber = [[src class] objectDescriber];
        
        for(NSUInteger i = 0; i < srcDescriber.subTypeCount; i++) {
            
            NSString* srcPropName = [srcDescriber identifierForIndex:i];
			id srcObject = [src valueForKey:srcPropName];
			
            if(srcObject) {
				id destObject =	[dest valueForKey:srcPropName];
				if(!destObject) {
					[dest setValue:srcObject forKey:srcPropName];
				}
				else {
					FLObjectDescriber* srcProp = [srcDescriber subTypeForIdentifier:srcPropName];
                    
                    if(![srcProp.objectClass isModelObject]) {
					   if(mergeMode == FLMergeModeSourceWins) {
							[dest setValue:srcObject forKey:srcPropName];
					   }
					}
					else if(srcProp.subTypeCount > 0) {
						FLMergeObjectArrays(destObject, srcObject, mergeMode, [srcProp subTypesCopy]);
					}
					else {
						FLMergeObjects(destObject, srcObject, mergeMode);
					}
				}
			}
		}
	}
}