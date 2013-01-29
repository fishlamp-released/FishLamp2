//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfAuthenticateVisitorHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfAuthenticateVisitorHttpPostIn
// --------------------------------------------------------------------
@interface FLZfAuthenticateVisitorHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _visitorKey;
} 


@property (readwrite, retain, nonatomic) NSString* visitorKey;

+ (NSString*) visitorKeyKey;

+ (FLZfAuthenticateVisitorHttpPostIn*) authenticateVisitorHttpPostIn; 

@end

@interface FLZfAuthenticateVisitorHttpPostIn (ValueProperties) 
@end

