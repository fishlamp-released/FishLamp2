//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioUpdateGroupResponse.h
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
// FLZenfolioUpdateGroupResponse
// --------------------------------------------------------------------
@interface FLZenfolioUpdateGroupResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZenfolioGroup* _UpdateGroupResult;
} 


@property (readwrite, retain, nonatomic) FLZenfolioGroup* UpdateGroupResult;

+ (NSString*) UpdateGroupResultKey;

+ (FLZenfolioUpdateGroupResponse*) updateGroupResponse; 

@end

@interface FLZenfolioUpdateGroupResponse (ValueProperties) 
@end
