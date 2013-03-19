//
//  NSString+FLCharString.h
//  FishLampCore
//
//  Created by Mike Fullerton on 3/18/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLCharString.h"

@interface NSString (FLCharString)

- (id) initWithCharString:(FLCharString) charString;

+ (id) stringWithCharString:(FLCharString) charString;

@end
