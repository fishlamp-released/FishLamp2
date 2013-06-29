//
//  FLRetainedObject.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjectRef.h"

@interface FLRetainedObject : FLObjectRef {
@private
    id _retainedObject;
}

@property (readonly, strong, nonatomic) id object;

+ (id) retainedObject:(id) object;

@end
