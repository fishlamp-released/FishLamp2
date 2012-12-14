//
//  FLUserContext.h
//  FLCore
//
//  Created by Mike Fullerton on 11/7/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLContext.h"
#import "FLUserLogin.h"

@interface FLUserContext : FLContext {
@private
	FLUserLogin* _userLogin;
}
@property (readwrite, strong) FLUserLogin* userLogin; 

@end

