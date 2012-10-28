//
//  NSDate+FLAdditions.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/14/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLGeometry.h"

@interface NSDate (FLAdditions)

@end

NS_INLINE
BOOL FLIsValidDate(NSDate* date) {
	return date != nil && !FLFloatEqualToZero(date.timeIntervalSinceReferenceDate);
}
