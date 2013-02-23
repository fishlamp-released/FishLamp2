//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioAuthenticateVisitorHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioAuthenticateVisitorHttpPostIn
// --------------------------------------------------------------------
@interface FLZenfolioAuthenticateVisitorHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _visitorKey;
} 


@property (readwrite, retain, nonatomic) NSString* visitorKey;

+ (NSString*) visitorKeyKey;

+ (FLZenfolioAuthenticateVisitorHttpPostIn*) authenticateVisitorHttpPostIn; 

@end

@interface FLZenfolioAuthenticateVisitorHttpPostIn (ValueProperties) 
@end
