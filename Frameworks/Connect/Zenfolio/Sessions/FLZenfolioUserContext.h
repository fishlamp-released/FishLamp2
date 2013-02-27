//
//  FLZenfolioUserContext.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/22/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHttpUserService.h"
#import "FLZenfolioGroupElementSelection.h"

@interface FLZenfolioUserContext : FLHttpUserService {
@private
    FLZenfolioGroup* _rootGroup;
    FLZenfolioGroupElementSelection* _selection;
}

@property (readwrite, strong) FLZenfolioGroup* rootGroup;

// TODO: refactor this out of this base class
@property (readwrite, strong) FLZenfolioGroupElementSelection* selection;


@end
