//
//  NSString+MiscUtils.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MiscUtils)

+ (NSString*) localizedStringForByteSize:(long long) size;

+ (NSString*) localizedStringForTime:(int) seconds;

@end
