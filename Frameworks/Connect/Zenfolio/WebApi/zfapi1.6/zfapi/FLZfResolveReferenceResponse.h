//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfResolveReferenceResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfResolveResult;

// --------------------------------------------------------------------
// FLZfResolveReferenceResponse
// --------------------------------------------------------------------
@interface FLZfResolveReferenceResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZfResolveResult* _ResolveReferenceResult;
} 


@property (readwrite, retain, nonatomic) FLZfResolveResult* ResolveReferenceResult;

+ (NSString*) ResolveReferenceResultKey;

+ (FLZfResolveReferenceResponse*) resolveReferenceResponse; 

@end

@interface FLZfResolveReferenceResponse (ValueProperties) 
@end

