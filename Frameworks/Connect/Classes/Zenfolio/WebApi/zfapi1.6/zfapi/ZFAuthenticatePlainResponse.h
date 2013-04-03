//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFAuthenticatePlainResponse.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFAuthenticatePlainResponse
// --------------------------------------------------------------------
@interface ZFAuthenticatePlainResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _AuthenticatePlainResult;
} 


@property (readwrite, retain, nonatomic) NSString* AuthenticatePlainResult;

+ (NSString*) AuthenticatePlainResultKey;

+ (ZFAuthenticatePlainResponse*) authenticatePlainResponse; 

@end

@interface ZFAuthenticatePlainResponse (ValueProperties) 
@end

