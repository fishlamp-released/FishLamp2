//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFAuthenticateVisitorHttpGetIn.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFAuthenticateVisitorHttpGetIn
// --------------------------------------------------------------------
@interface ZFAuthenticateVisitorHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _visitorKey;
} 


@property (readwrite, retain, nonatomic) NSString* visitorKey;

+ (NSString*) visitorKeyKey;

+ (ZFAuthenticateVisitorHttpGetIn*) authenticateVisitorHttpGetIn; 

@end

@interface ZFAuthenticateVisitorHttpGetIn (ValueProperties) 
@end

