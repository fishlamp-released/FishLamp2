//
//  ZFUserContext.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/22/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHttpUserService.h"
#import "ZFGroupElementSelection.h"

@interface ZFUserContext : FLHttpUserService {
@private
    ZFGroup* _rootGroup;
    ZFGroupElementSelection* _selection;
}

@property (readwrite, strong) ZFGroup* rootGroup;

// TODO: refactor this out of this base class
@property (readwrite, strong) ZFGroupElementSelection* selection;


@end
