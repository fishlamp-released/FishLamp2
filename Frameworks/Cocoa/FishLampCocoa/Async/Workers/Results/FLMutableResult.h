//
//  FLMutableResulting.h
//  Downloader
//
//  Created by Mike Fullerton on 11/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLMutableResult : NSObject<FLResulting> {
@private
    id _result;
}

@property (readwrite, strong) id result;

- (id) initWithResult:(id) result;

+ (id) mutableResultWithResult:(id) result;
+ (id) mutableResult;

@end
