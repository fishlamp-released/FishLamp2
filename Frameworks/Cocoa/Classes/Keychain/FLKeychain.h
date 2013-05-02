//
//	FLKeychain.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/18/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//
#import "FishLampCore.h"
#import <Security/Security.h>

@interface FLKeychain : NSObject {
}

+ (NSString*) httpPasswordForUserName:(NSString*) userName
                           withDomain:(NSString*) domain;

+ (OSStatus) setHttpPassword:(NSString*) password 
             forUserName:(NSString*) userName 
              withDomain:(NSString*) domain;

+ (OSStatus) removeHttpPasswordForUserName:(NSString*) userName 
                            withDomain:(NSString*) domain;
@end


