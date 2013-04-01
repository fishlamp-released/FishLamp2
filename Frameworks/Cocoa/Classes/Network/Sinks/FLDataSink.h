//
//  FLDataSink.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/31/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLInputSink.h"

@interface FLDataSink : NSObject<FLInputSink>  {
@private
    NSMutableData* _responseData;
    NSData* _data;
}

+ (id) dataSink;
@end