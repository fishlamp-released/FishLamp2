//
//	FLZenfolioAuthenticater.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/26/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLZenfolioChallengeResponseAuthenticationOperation.h"

#import "FLBase64Encoding.h"
#import "FLZenfolioErrors.h"
#import "FLFrameworkErrorDomain.h"
#import "FLObjectDescriber.h" // for merge objects
#import "FLZenfolioWebApi.h"

@implementation FLZenfolioChallengeResponseAuthenticationOperation

- (FLHttpRequest*) authenticateRequestWithAuthChallenge:(FLZenfolioAuthChallenge*) challenge {

    FLAssertIsNotNil_(challenge);
	
    NSData* decodedChallenge = [challenge Challenge];
    NSData* decodedSalt = [challenge PasswordSalt];

	FLAssertIsNotNil_(decodedChallenge);
	FLAssertIsNotNil_(decodedSalt);
	
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
    
    return [FLZenfolioHttpRequest authenticateRequest:encodedChallenge proof:encodedProof];
}

- (FLResult) runOperationInContext:(id) context withObserver:(id) observer {
    
    FLTrace(@"Authenticating %@:", self.userLogin.userName );

    if(FLStringIsEmpty(self.userLogin.password)) {
    // can't authenticate because we don't have a pw. So put an error in the httpRequestFactory so ui can prompt for password.

        FLTrace(@"auth failed because password is empty");
        
        FLThrowIfError( [NSError errorWithDomain:FLZenfolioErrorDomain
                                           code:FLZenfolioErrorCodeInvalidCredentials
                           localizedDescription:NSLocalizedString(@"Password is incorrect", nil)]);
    }
    
    
    FLHttpRequest* challengeRequest = [FLZenfolioHttpRequest challengeHttpRequest:self.userLogin.userName];
    challengeRequest.disableAuthenticator = YES;
    
    FLZenfolioAuthChallenge* response = FLThrowIfError([context runWorker:challengeRequest withObserver:observer]);
   
    FLHttpRequest* authenticateRequest = FLThrowIfError([self authenticateRequestWithAuthChallenge:response]);
    authenticateRequest.disableAuthenticator = YES;
    
    NSString* token = FLThrowIfError([context runWorker:authenticateRequest withObserver:observer]);
    
    if(FLStringIsNotEmpty(token)) {
        self.userLogin.authToken = token;
        self.userLogin.authTokenLastUpdateTimeValue = [NSDate timeIntervalSinceReferenceDate];
    }
    else {
        FLThrowErrorCode_v(NSURLErrorDomain, NSURLErrorBadServerResponse, @"empty token from server");
    }

    return [super runOperationInContext:context withObserver:observer];
}

@end

