//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFAuthenticateVisitorHttpPostIn.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFAuthenticateVisitorHttpPostIn
// --------------------------------------------------------------------
@interface ZFAuthenticateVisitorHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _visitorKey;
} 


@property (readwrite, retain, nonatomic) NSString* visitorKey;

+ (NSString*) visitorKeyKey;

+ (ZFAuthenticateVisitorHttpPostIn*) authenticateVisitorHttpPostIn; 

@end

@interface ZFAuthenticateVisitorHttpPostIn (ValueProperties) 
@end

