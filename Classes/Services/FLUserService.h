//
//  FLUserService.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAppService.h"
#import "FLUserLogin.h"

@protocol FLUserService <FLAppService>
@property (readonly, assign) BOOL isAuthenticated;
@property (readonly, strong) FLUserLogin* userLogin; 
@end

