//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioResolveReferenceHttpGetIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioResolveReferenceHttpGetIn
// --------------------------------------------------------------------
@interface FLZenfolioResolveReferenceHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _loginName;
	NSString* _reference;
} 


@property (readwrite, retain, nonatomic) NSString* loginName;

@property (readwrite, retain, nonatomic) NSString* reference;

+ (NSString*) loginNameKey;

+ (NSString*) referenceKey;

+ (FLZenfolioResolveReferenceHttpGetIn*) resolveReferenceHttpGetIn; 

@end

@interface FLZenfolioResolveReferenceHttpGetIn (ValueProperties) 
@end

