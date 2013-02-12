//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioGetDownloadOriginalKeyResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioGetDownloadOriginalKeyResponse
// --------------------------------------------------------------------
@interface FLZenfolioGetDownloadOriginalKeyResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _GetDownloadOriginalKeyResult;
} 


@property (readwrite, retain, nonatomic) NSString* GetDownloadOriginalKeyResult;

+ (NSString*) GetDownloadOriginalKeyResultKey;

+ (FLZenfolioGetDownloadOriginalKeyResponse*) getDownloadOriginalKeyResponse; 

@end

@interface FLZenfolioGetDownloadOriginalKeyResponse (ValueProperties) 
@end

