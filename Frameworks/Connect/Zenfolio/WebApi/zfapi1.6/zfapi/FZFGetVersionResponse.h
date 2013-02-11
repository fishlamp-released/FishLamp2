//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioGetVersionResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioGetVersionResponse
// --------------------------------------------------------------------
@interface FLZenfolioGetVersionResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _GetVersionResult;
} 


@property (readwrite, retain, nonatomic) NSString* GetVersionResult;

+ (NSString*) GetVersionResultKey;

+ (FLZenfolioGetVersionResponse*) getVersionResponse; 

@end

@interface FLZenfolioGetVersionResponse (ValueProperties) 
@end

