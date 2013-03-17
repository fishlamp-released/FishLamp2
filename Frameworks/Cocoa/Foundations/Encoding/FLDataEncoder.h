//
//  FLDataEncoder.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLDataEncoding.h"
#import "FLDataDecoding.h"

@interface FLDataEncoder : NSObject<FLDataEncoding, FLDataDecoding> {
@private
    NSNumberFormatter* _numberFormatter;
}
+ (id) dataEncoder;

@property (readonly, strong, nonatomic) NSNumberFormatter* numberFormatter;

@end
