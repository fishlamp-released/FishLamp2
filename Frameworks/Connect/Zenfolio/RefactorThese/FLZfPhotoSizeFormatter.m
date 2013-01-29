//
//  FLZfPhotoSizeFormatter.m
//  ZenfolioDownloader
//
//  Created by patrickm on 19-11-07.
//  Copyright 2007 Zenfolio, Inc.. All rights reserved.
//

#import "FLZfPhotoSizeFormatter.h"


@implementation FLZfPhotoSizeFormatter

+ (id)formatter {
	return FLAutorelease([[[self class] alloc] init]);
}

//	[override]
- (NSString *)stringForObjectValue:(id)anObject {
	return [anObject stringValue];
}

//	[override]
- (BOOL)getObjectValue:(id *)anObject
			 forString:(NSString *)string
	  errorDescription:(NSString **)error {
	*anObject = [NSNumber numberWithInt:[string intValue]];
	return YES;
}

//	[override]
- (BOOL)isPartialStringValid:(NSString *)partialString
			newEditingString:(NSString **)newString
			errorDescription:(NSString **)error
{
	int i;
	for ( i = 0; i < [partialString length]; i++ ) {
		unichar uc = [partialString characterAtIndex:i];
		if ( i == 0 && uc == '0' ) {
			return NO;	//	can't start with a 0
		}
		if ( !isdigit([partialString characterAtIndex:i]) ) {
			return NO;	//	only accept digits
		} 
	}
	return [partialString intValue] <= 99999;
}

@end
