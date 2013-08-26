//
//  FLObjectProxy.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCoreRequired.h"

@protocol FLObjectProxy <NSObject>
- (id) representedObject;
@end

@interface FLObjectProxy : NSProxy<FLObjectProxy>
@end
