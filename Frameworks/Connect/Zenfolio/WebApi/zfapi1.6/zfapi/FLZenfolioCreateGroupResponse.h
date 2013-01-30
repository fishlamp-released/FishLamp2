//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioCreateGroupResponse.h
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
// FLZenfolioCreateGroupResponse
// --------------------------------------------------------------------
@interface FLZenfolioCreateGroupResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZenfolioGroup* _CreateGroupResult;
} 


@property (readwrite, retain, nonatomic) FLZenfolioGroup* CreateGroupResult;

+ (NSString*) CreateGroupResultKey;

+ (FLZenfolioCreateGroupResponse*) createGroupResponse; 

@end

@interface FLZenfolioCreateGroupResponse (ValueProperties) 
@end

