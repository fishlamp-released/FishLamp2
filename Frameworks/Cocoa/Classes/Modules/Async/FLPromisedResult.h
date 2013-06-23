//
//  FLPromisedResult.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/23/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLPromisedResult : NSObject {
@private
    id _value;
    NSError* _error;
}
@property (readonly, strong, nonatomic) NSError* error;
@property (readonly, strong, nonatomic) id value;

- (id) initWithValue:(id) value error:(NSError*) error;
+ (id) promisedResult:(id) value error:(NSError*) error;

@end
