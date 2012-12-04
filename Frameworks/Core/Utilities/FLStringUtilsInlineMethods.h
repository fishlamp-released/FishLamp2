//
//  NSString+FLExtrasInline.m
//  FishLampCore
//
//  Created by Mike Fullerton on 5/18/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

FL_SHIP_ONLY_INLINE
BOOL FLStringIsEmpty(NSString* string) {
	return string == nil || string.length == 0;
}

FL_SHIP_ONLY_INLINE
BOOL FLStringIsNotEmpty(NSString* string) {
	return string != nil && string.length > 0;
}

FL_SHIP_ONLY_INLINE
BOOL FLStringsAreEqual(NSString* lhs, NSString* rhs) {
	return [(lhs == nil ? @"" : lhs) isEqualToString:(rhs == nil ) ? @"" :rhs];
}

FL_SHIP_ONLY_INLINE
BOOL FLStringsAreEqualCaseInsensitive(NSString* lhs, NSString* rhs) { 
	return [(lhs == nil ? @"" : lhs) isEqualToString:(rhs == nil ) ? @"" :rhs caseSensitive:NO];
}

