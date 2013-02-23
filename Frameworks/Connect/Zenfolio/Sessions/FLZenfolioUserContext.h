//
//  FLZenfolioUserContext.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/22/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHttpUserService.h"

@interface FLZenfolioUserContext : FLHttpUserService {
@private
    FLZenfolioGroup* _rootGroup;

}
@property (readwrite, strong) FLZenfolioGroup* rootGroup;


@end
