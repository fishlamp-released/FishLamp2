//
//  FLOperation.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"
#import "FLZenfolioUserContext.h"

@interface FLOperation (ZenfolioHttp) {
@private
}
@property (readwrite, assign) FLZenfolioUserContext* userContext;

@end
