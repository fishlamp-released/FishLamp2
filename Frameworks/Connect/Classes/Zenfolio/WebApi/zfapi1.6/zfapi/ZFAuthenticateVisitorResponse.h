//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFAuthenticateVisitorResponse.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFAuthenticateVisitorResponse
// --------------------------------------------------------------------
@interface ZFAuthenticateVisitorResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _AuthenticateVisitorResult;
} 


@property (readwrite, retain, nonatomic) NSString* AuthenticateVisitorResult;

+ (NSString*) AuthenticateVisitorResultKey;

+ (ZFAuthenticateVisitorResponse*) authenticateVisitorResponse; 

@end

@interface ZFAuthenticateVisitorResponse (ValueProperties) 
@end

