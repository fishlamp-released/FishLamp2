//
//  FLOperation+HttpRequest.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"
#import "FLHttpRequest.h"

@interface FLOperation (HttpRequest)

- (FLResult) sendHttpRequest:(FLHttpRequest*) request;
- (FLResult) sendHttpRequest:(FLHttpRequest*) request withObserver:(FLHttpRequestObserver*) observer;
@end
