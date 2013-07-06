//
//  FLObjectRef.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLampCore.h"

@protocol FLObjectRef <NSObject>
- (id) object;
@end

@interface FLObjectRef : NSProxy<FLObjectRef> {
@private
    __unsafe_unretained id _object;
}
- (id) object;
- (id) initWithObject:(id) object;

@end
