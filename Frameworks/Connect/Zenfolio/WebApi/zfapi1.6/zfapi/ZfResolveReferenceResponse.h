//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFResolveReferenceResponse.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class ZFResolveResult;

// --------------------------------------------------------------------
// ZFResolveReferenceResponse
// --------------------------------------------------------------------
@interface ZFResolveReferenceResponse : NSObject<NSCoding, NSCopying>{ 
@private
	ZFResolveResult* _ResolveReferenceResult;
} 


@property (readwrite, retain, nonatomic) ZFResolveResult* ResolveReferenceResult;

+ (NSString*) ResolveReferenceResultKey;

+ (ZFResolveReferenceResponse*) resolveReferenceResponse; 

@end

@interface ZFResolveReferenceResponse (ValueProperties) 
@end

