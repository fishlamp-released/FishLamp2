//
//  FLRetainedObject.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjectProxy.h"

@interface FLRetainedObject : FLObjectProxy {
@private
    id _representedObject;
}

@property (readonly, strong) id representedObject;

- (id) initWithRetainedObject:(id) object;
+ (id) retainedObject:(id) object;

@end
