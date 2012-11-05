//
//  FLServiceable.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLServiceable <NSObject>
@property (readwrite, strong) id services;
@end

@interface FLServiceable : NSObject<FLServiceable> {
@private
    id _services;
}
@end
