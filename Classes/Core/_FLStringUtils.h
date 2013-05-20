//
//  NSString+GtExtrasInline.m
//  FishLampCore
//
//  Created by Mike Fullerton on 5/18/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

GT_SHIP_ONLY_INLINE
BOOL GtStringIsEmpty(NSString* string) {
	return string == nil || string.length == 0;
}

GT_SHIP_ONLY_INLINE
BOOL GtStringIsNotEmpty(NSString* string) {
	return string != nil && string.length > 0;
}

GT_SHIP_ONLY_INLINE
BOOL GtStringsAreEqual(NSString* lhs, NSString* rhs) {
	return [(lhs == nil ? @"" : lhs) isEqualToString:(rhs == nil ) ? @"" :rhs];
}

GT_SHIP_ONLY_INLINE
BOOL GtStringsAreEqualCaseInsensitive(NSString* lhs, NSString* rhs) { 
	return [(lhs == nil ? @"" : lhs) isEqualToString:(rhs == nil ) ? @"" :rhs caseSensitive:NO];
}
