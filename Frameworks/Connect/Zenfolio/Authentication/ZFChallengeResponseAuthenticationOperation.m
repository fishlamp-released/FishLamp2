//
//	ZFAuthenticater.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/26/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "ZFChallengeResponseAuthenticationOperation.h"

#import "FLBase64Encoding.h"
#import "ZFErrors.h"
#import "FLFrameworkErrorDomain.h"
#import "FLObjectDescriber.h" // for merge objects
#import "ZFWebApi.h"

@implementation ZFChallengeResponseAuthenticationOperation

- (FLHttpRequest*) authenticateRequestWithAuthChallenge:(ZFAuthChallenge*) challenge {

    FLAssertIsNotNil(challenge);
	
    NSData* decodedChallenge = [challenge Challenge];
    NSData* decodedSalt = [challenge PasswordSalt];

	FLAssertIsNotNil(decodedChallenge);
	FLAssertIsNotNil(decodedSalt);
	
	// 1. combine salt + pw
	// 2. encode 
	
	const char* pw = [self.userLogin.password UTF8String]; // autoreleased
	
	NSData* pwData = FLAutorelease([[NSData alloc] initWithBytes:pw length:strlen(pw)]);

	NSData* hash1 = [[decodedSalt dataWithAppendedData:pwData] SHA256Hash];
	
	// 3. combine challenge s hash1
	// 4. encode
	
	NSData* hash2 =	[[decodedChallenge dataWithAppendedData:hash1] SHA256Hash];
    
	// 5. convert challenge and hash back to base64 

	NSData* encodedProof = [hash2 base64Encode];

	NSData* encodedChallenge = [decodedChallenge base64Encode];
    
    return [ZFHttpRequest authenticateRequest:encodedChallenge proof:encodedProof];
}

- (FLResult) runOperation {
    
    FLTrace(@"Authenticating %@:", self.userLogin.userName );

    if(FLStringIsEmpty(self.userLogin.password)) {
    // can't authenticate because we don't have a pw. So put an error in the httpRequestFactory so ui can prompt for password.

        FLTrace(@"auth failed because password is empty");
        
        FLThrowIfError( [NSError errorWithDomain:ZFErrorDomain
                                           code:ZFErrorCodeInvalidCredentials
                           localizedDescription:NSLocalizedString(@"Password is incorrect", nil)]);
    }
    
    
    FLHttpRequest* challengeRequest = [ZFHttpRequest challengeHttpRequest:self.userLogin.userName];
    challengeRequest.disableAuthenticator = YES;
    
    ZFAuthChallenge* response = FLThrowIfError([self runWorker:challengeRequest]);
   
    FLHttpRequest* authenticateRequest = FLThrowIfError([self authenticateRequestWithAuthChallenge:response]);
    authenticateRequest.disableAuthenticator = YES;
    
    NSString* token = FLThrowIfError([self runWorker:authenticateRequest]);
    
    if(FLStringIsNotEmpty(token)) {
        self.userLogin.authToken = token;
        self.userLogin.authTokenLastUpdateTimeValue = [NSDate timeIntervalSinceReferenceDate];
    }
    else {
        FLThrowErrorCodeWithComment(NSURLErrorDomain, NSURLErrorBadServerResponse, @"empty token from server");
    }

    return [super runOperation];
}

@end

