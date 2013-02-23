//
//	FLZenfolioAuthenticater.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/26/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLZenfolioAuthenticateOperation.h"

#import "FLBase64Encoding.h"
#import "FLZenfolioErrors.h"
#import "FLFrameworkErrorDomain.h"
#import "FLObjectDescriber.h" // for merge objects
#import "FLZenfolioWebApi.h"

@implementation FLZenfolioAuthenticateOperation


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
//	[NSData concatAndEncodeSHA256:decodedSalt rhs:pwData outData:&hash1];
	
	// 3. combine challenge s hash1
	// 4. encode
	
	NSData* hash2 =	[[decodedChallenge dataWithAppendedData:hash1] SHA256Hash];
//	[NSData concatAndEncodeSHA256:decodedChallenge rhs:hash1 outData:&hash2]; 
//	FLRelease(hash1);
    
	// 5. convert challenge and hash back to base64 

	NSData* encodedProof = [hash2 base64Encode];
//    FLRelease(hash2);

	NSData* encodedChallenge = [decodedChallenge base64Encode];
    
    return [FLZenfolioHttpRequest authenticateRequest:encodedChallenge proof:encodedProof];
}

- (FLResult) runOperationInContext:(id) context withObserver:(id) observer {
    
    FLHttpRequest* challengeRequest = [FLZenfolioHttpRequest challengeHttpRequest:self.userLogin.userName];
    challengeRequest.disableAuthenticator = YES;
    
    FLZenfolioAuthChallenge* response = [context runWorker:challengeRequest withObserver:observer];
   
    FLHttpRequest* authenticateRequest = [self authenticateRequestWithAuthChallenge:response];
    authenticateRequest.disableAuthenticator = YES;
    
    NSString* token = [context runWorker:authenticateRequest withObserver:observer];
    
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

