//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadGroupHierarchyResponse.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class ZFGroup;

// --------------------------------------------------------------------
// ZFLoadGroupHierarchyResponse
// --------------------------------------------------------------------
@interface ZFLoadGroupHierarchyResponse : NSObject<NSCoding, NSCopying>{ 
@private
	ZFGroup* _LoadGroupHierarchyResult;
} 


@property (readwrite, retain, nonatomic) ZFGroup* LoadGroupHierarchyResult;

+ (NSString*) LoadGroupHierarchyResultKey;

+ (ZFLoadGroupHierarchyResponse*) loadGroupHierarchyResponse; 

@end

@interface ZFLoadGroupHierarchyResponse (ValueProperties) 
@end

