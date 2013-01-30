//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioGetVisitorKeyResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioGetVisitorKeyResponse
// --------------------------------------------------------------------
@interface FLZenfolioGetVisitorKeyResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _GetVisitorKeyResult;
} 


@property (readwrite, retain, nonatomic) NSString* GetVisitorKeyResult;

+ (NSString*) GetVisitorKeyResultKey;

+ (FLZenfolioGetVisitorKeyResponse*) getVisitorKeyResponse; 

@end

@interface FLZenfolioGetVisitorKeyResponse (ValueProperties) 
@end

