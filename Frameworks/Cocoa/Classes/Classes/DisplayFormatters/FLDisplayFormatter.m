//
//	FLDisplayFormatter.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/13/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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

