//
//  FLObjectRef.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLampCore.h"

@protocol FLObjectRef <NSObject>
- (id) representedObject;
@end

@interface FLObjectRef : NSProxy<FLObjectRef> {
@private
    __unsafe_unretained id _unretainedRepresentedObject;
}
- (id) initWithRepresentedObject:(id) object;

@end
