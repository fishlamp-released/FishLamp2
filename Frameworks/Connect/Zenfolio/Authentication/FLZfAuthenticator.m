//
//	FLZfAuthenticater.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/26/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLZfAuthenticator.h"
#import "FLZfUtils.h"
#import "FLBase64Encoding.h"
#import "FLZfErrors.h"
#import "FLUserLogin+FLZfAdditions.h"
#import "FLFrameworkErrorDomain.h"
#import "FLObjectDescriber.h" // for merge objects
#import "FLHttpRequest.h"
#import "FLZfHttpRequest.h"
#import "FLZfUser.h"
#import "FLUserLogin.h"
#import "FLZfHttpRequest.h"

@implementation FLZfAuthenticator

- (FLZfAuthChallenge*) sendChallengeRequest {
    FLHttpRequest* challengeRequest = [FLZfHttpRequest challengeHttpRequest:self.userLogin.userName];
    challengeRequest.authenticationDisabled = YES;
    
    return [challengeRequest sendSynchronouslyInContext:self.context];
}

- (NSString*) sendAuthenticateRequestWithChallenge:(FLZfAuthChallenge*) challenge {

    FLAssertIsNotNil_(challenge);
	
    NSData* decodedChallenge = [challenge Challenge];
    NSData* decodedSalt = [challenge PasswordSalt];

	FLAssertIsNotNil_(decodedChallenge);
	FLAssertIsNotNil_(decodedSalt);
	
	// 1. combine salt + pw
	// 2. encode 
	
	const char* pw = [self.userLogin.password UTF8String]; // autoreleased
	
	NSData* pwData = [[NSData alloc] initWithBytes:pw length:strlen(pw)];

	NSData* hash1 = nil;
	[NSData concatAndEncodeSHA256:decodedSalt rhs:pwData outData:&hash1];
	FLReleaseWithNil(pwData);
	
	// 3. combine challenge s hash1
	// 4. encode
	
	NSData* hash2 =	 nil;
	[NSData concatAndEncodeSHA256:decodedChallenge rhs:hash1 outData:&hash2]; 
	FLRelease(hash1);
    
	// 5. convert challenge and hash back to base64 

	NSData* encodedProof = [hash2 base64Encode];
    FLRelease(hash2);

	NSData* encodedChallenge = [decodedChallenge base64Encode];
    
    FLHttpRequest* authRequest = [FLZfHttpRequest  authenticateHttpRequest:encodedChallenge proof:encodedProof];
    authRequest.authenticationDisabled = YES;

    return [authRequest sendSynchronouslyInContext:self.context];
}

- (FLResult) runOperation  {
    
    FLZfAuthChallenge* response = [self sendChallengeRequest];
   
    NSString* token = [self sendAuthenticateRequestWithChallenge:response];
    
    if(FLStringIsNotEmpty(token)) {
        self.userLogin.authToken = token;
        self.userLogin.isAuthenticatedValue = YES;
        self.userLogin.authTokenLastUpdateTimeValue = [NSDate timeIntervalSinceReferenceDate];
    }
    else {
        FLThrowErrorCode_v(NSURLErrorDomain, NSURLErrorBadServerResponse, @"empty token from server");
    }

    FLLog(@"Authentication completed: %@", token);

    return self.userLogin;
}

@end

