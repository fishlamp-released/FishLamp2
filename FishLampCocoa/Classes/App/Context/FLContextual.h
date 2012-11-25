//
//  FLContextual.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLContextual <NSObject>
@property (readonly, assign) id context;

- (void) removeFromContext:(id) context;
- (void) addToContext:(id) context;
@end

@interface FLContextual : NSObject<FLContextual> {
@private
    __unsafe_unretained id _context;
}
@end
