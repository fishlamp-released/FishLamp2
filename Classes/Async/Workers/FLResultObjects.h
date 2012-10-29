//
//  FLResultObjects
//  FishLampCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLResult.h"
#import "FLProperties.h"

@interface FLSuccessfullResult : NSObject<FLResult>
FLSingletonProperty(FLSuccessfullResult);
@end

@interface FLOutputResult : FLSuccessfullResult {
@private
    id _output;
}
- (id) initWithOutput:(id) output;
+ (id) outputResult:(id) output;
@end

@interface FLFailedResult : NSObject<FLResult>
FLSingletonProperty(FLFailedResult);
@end

@interface FLErrorResult : FLFailedResult {
@private
    NSError* _error;
}
- (id) initWithError:(NSError*) error;
+ (id) errorResult:(NSError*) error;
@end

