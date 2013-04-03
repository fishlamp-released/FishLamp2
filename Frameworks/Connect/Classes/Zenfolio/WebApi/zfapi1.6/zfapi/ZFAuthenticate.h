//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFAuthenticate.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFAuthenticate
// --------------------------------------------------------------------
@interface ZFAuthenticate : NSObject<NSCoding, NSCopying>{ 
@private
	NSData* _challenge;
	NSData* _proof;
} 


@property (readwrite, retain, nonatomic) NSData* challenge;

@property (readwrite, retain, nonatomic) NSData* proof;

+ (NSString*) challengeKey;

+ (NSString*) proofKey;

+ (ZFAuthenticate*) authenticate; 

@end

@interface ZFAuthenticate (ValueProperties) 
@end

