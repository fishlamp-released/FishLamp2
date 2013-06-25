//
//  FLMainThreadRef.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLRetainedRef.h"

@interface FLMainThreadRef : FLRetainedRef

+ (id) mainThreadRef:(id) object;

@end
