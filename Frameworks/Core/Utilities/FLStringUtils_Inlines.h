//
//  NSString+FLExtrasInline.m
//  FLCore
//
//  Created by Mike Fullerton on 5/18/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//
#ifdef __INLINES__

FL_SHIP_ONLY_INLINE
BOOL FLStringIsEmpty(id string) {
	return string == nil || [string length] == 0;
}

FL_SHIP_ONLY_INLINE
BOOL FLStringIsNotEmpty(id string) {
	return string != nil && [string length] > 0;
}

FL_SHIP_ONLY_INLINE
BOOL FLStringsAreEqual(NSString* lhs, NSString* rhs) {
	return [(lhs == nil ? @"" : lhs) isEqualToString:(rhs == nil ) ? @"" :rhs];
}

FL_SHIP_ONLY_INLINE
BOOL FLStringsAreEqualCaseInsensitive(NSString* lhs, NSString* rhs) { 
	return [(lhs == nil ? @"" : lhs) isEqualToString:(rhs == nil ) ? @"" :rhs caseSensitive:NO];
}

#endif