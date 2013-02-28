//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioResolveReferenceResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioResolveResult;

// --------------------------------------------------------------------
// FLZenfolioResolveReferenceResponse
// --------------------------------------------------------------------
@interface FLZenfolioResolveReferenceResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZenfolioResolveResult* _ResolveReferenceResult;
} 


@property (readwrite, retain, nonatomic) FLZenfolioResolveResult* ResolveReferenceResult;

+ (NSString*) ResolveReferenceResultKey;

+ (FLZenfolioResolveReferenceResponse*) resolveReferenceResponse; 

@end

@interface FLZenfolioResolveReferenceResponse (ValueProperties) 
@end
