//
//  FLCredentials.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLModelObject.h"

@protocol FLCredentials <NSObject, NSCopying, NSMutableCopying>
@property (readonly, strong, nonatomic) NSNumber* rememberPassword;
@property (readonly, strong, nonatomic) NSString* userName;
@property (readonly, strong, nonatomic) NSString* password;
@property (readonly, assign, nonatomic) BOOL canAuthenticate;
@end

@protocol FLMutableCredentials <FLCredentials>
@property (readwrite, strong, nonatomic) NSNumber* rememberPassword;
@property (readwrite, strong, nonatomic) NSString* userName;
@property (readwrite, strong, nonatomic) NSString* password;
- (void) clearCredentials;
@end


@interface FLCredentials : FLModelObject<FLCredentials> {
@private
    NSString* _userName;
    NSString* _password;
    NSNumber* _rememberPassword;
}

- (id) initWithUserName:(NSString*) userName 
               password:(NSString*) password 
       rememberPassword:(NSNumber*) rememberPassword;

+ (id) credentials:(NSString*) userName 
              password:(NSString*) password 
      rememberPassword:(NSNumber*) rememberPassword;

+ (id) credentials;
@end

@interface FLMutableCredentials : FLCredentials<FLMutableCredentials>
@end


