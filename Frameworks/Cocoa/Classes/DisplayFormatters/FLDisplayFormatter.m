//
//	FLDisplayFormatter.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/13/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLDisplayFormatter.h"

@implementation NSObject (FLDisplayFormatter)

+ (NSString*) displayFormatterDataToString:(id) data {
	return @"";
}

+ (id) displayFormatterStringToData:(NSString*) string {
	return string;
}

- (NSString*) formattedStringForDisplay {
    return [[self class] displayFormatterDataToString:self];
}

@end

