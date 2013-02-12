//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioLoadGroupHierarchyResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioGroup;

// --------------------------------------------------------------------
// FLZenfolioLoadGroupHierarchyResponse
// --------------------------------------------------------------------
@interface FLZenfolioLoadGroupHierarchyResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZenfolioGroup* _LoadGroupHierarchyResult;
} 


@property (readwrite, retain, nonatomic) FLZenfolioGroup* LoadGroupHierarchyResult;

+ (NSString*) LoadGroupHierarchyResultKey;

+ (FLZenfolioLoadGroupHierarchyResponse*) loadGroupHierarchyResponse; 

@end

@interface FLZenfolioLoadGroupHierarchyResponse (ValueProperties) 
@end

