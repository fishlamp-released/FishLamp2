//
//	FLZenfolioAuthenticater.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/26/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLZenfolioAuthenticator.h"

#import "FLBase64Encoding.h"
#import "FLZenfolioErrors.h"
#import "FLFrameworkErrorDomain.h"
#import "FLObjectDescriber.h" // for merge objects
#import "FLZenfolioWebApi.h"

@implementation FLZenfolioAuthenticator

- (FLZenfolioAuthChallenge*) sendChallengeRequest {
    FLHttpRequest* challengeRequest = [FLZenfolioHttpRequest challengeHttpRequest:self.userLogin.userName];
    
    [self.context addObject:challengeRequest];
    
    return [challengeRequest sendSynchronously];
}

- (NSString*) sendAuthenticateRequestWithChallenge:(FLZenfolioAuthChallenge*) challenge {

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
//	[NSData concatAndEncodeSHA256:decodedSalt rhs:pwData outData:&hash1];
	
	// 3. combine challenge s hash1
	// 4. encode
	
	NSData* hash2 =	[[decodedChallenge dataWithAppendedData:hash1] SHA256Hash];
//	[NSData concatAndEncodeSHA256:decodedChallenge rhs:hash1 outData:&hash2]; 
//	FLRelease(hash1);
    
	// 5. convert challenge and hash back to base64 

	NSData* encodedProof = [hash2 base64Encode];
    FLRelease(hash2);

	NSData* encodedChallenge = [decodedChallenge base64Encode];
    
    FLHttpRequest* authRequest = [FLZenfolioHttpRequest  httpRequestAuthenticateSynchronously:encodedChallenge proof:encodedProof];
    return [authRequest sendSynchronously];
}

- (FLResult) runOperation  {
    
    FLZenfolioAuthChallenge* response = [self sendChallengeRequest];
   
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

