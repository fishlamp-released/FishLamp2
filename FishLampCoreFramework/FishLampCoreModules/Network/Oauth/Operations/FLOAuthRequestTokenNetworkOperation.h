//
//  FLOAuthRequestTokenNetworkOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/1/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLHttpOperation.h"
#import "FLOAuth.h"
#import "FLOAuthApp.h"

@interface FLOAuthRequestTokenNetworkOperation : FLHttpOperation {
@private 
	FLOAuthApp* _app;
}

@property (readonly, retain, nonatomic) FLOAuthApp* OAuthApp;

- (id) initWithOAuthApp:(FLOAuthApp*) app;
+ (FLOAuthRequestTokenNetworkOperation*) OAuthRequestTokenNetworkOperation:(FLOAuthApp*) app;

@end
