//
//	FLDataTypeIDUtilities.m
//	PackMule
//
//	Created by Mike Fullerton on 4/27/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//
#import "FLObjcUtilities.h"
#import "FLCodeGeneratorErrors.h"
//
//@implementation NSMutableArray (CodeGenerator)
//- (void) addUniqueObject:(id) inObj {
//	for(id object in self) {
//		if([object isEqual:inObj]) {
//			FLThrowErrorCodeWithComment(FLErrorDomain, FLErrorDuplicateItemErrorCode, @"Duplicate item in array: %@", [inObj description]);
//		}
//	}
//	
//	[self addObject:inObj];
//}
//@end
//
//@implementation NSMutableDictionary (More)
//
//- (void) setObjectOrFail:(id) object forKey:(id) key {
//	if([self objectForKey:key] != nil) {
//		FLThrowErrorCodeWithComment(FLErrorDomain, FLErrorCodeItemExists, @"Item exists already: %@", key);
//	}
//	
//	[self setObject:object forKey:key];
//}
//
//NSString* _CheckString(NSString* str, const char* cstr)
//{
//	FLConfirmStringIsNotEmptyWithComment(str, @"%s", cstr != nil ? cstr : "");
//	return str;
//}	
//@end
