//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfLoadGroupHierarchyResponse.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfGroup;

// --------------------------------------------------------------------
// FLZfLoadGroupHierarchyResponse
// --------------------------------------------------------------------
@interface FLZfLoadGroupHierarchyResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZfGroup* _LoadGroupHierarchyResult;
} 


@property (readwrite, retain, nonatomic) FLZfGroup* LoadGroupHierarchyResult;

+ (NSString*) LoadGroupHierarchyResultKey;

+ (FLZfLoadGroupHierarchyResponse*) loadGroupHierarchyResponse; 

@end

@interface FLZfLoadGroupHierarchyResponse (ValueProperties) 
@end

