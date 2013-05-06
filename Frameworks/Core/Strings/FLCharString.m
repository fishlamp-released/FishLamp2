//
//  FLCharString.m
//  FishLampCore
//
//  Created by Mike Fullerton on 3/18/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCharString.h"

@implementation NSString (FLCharString)
+ (NSString*) stringWithCharString:(FLCharString) charString {
    if(charString.length == 0) {
        return nil;
    }

    return FLAutorelease([[NSString alloc] initWithBytes:charString.string length:charString.length encoding:NSASCIIStringEncoding]);

}
@end