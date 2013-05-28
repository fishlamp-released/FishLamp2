//
//  FLCharString.m
//  FishLampCore
//
//  Created by Mike Fullerton on 3/18/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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