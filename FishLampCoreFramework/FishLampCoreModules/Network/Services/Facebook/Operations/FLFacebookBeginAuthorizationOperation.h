//
//  FLFacebookBeginAuthorizationOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLFacebookOperation.h"

@interface FLFacebookBeginAuthorizationOperation : FLFacebookOperation {
@private
    NSArray* _permissions;
}

@property (readwrite, strong) NSArray* permissions;
@end
