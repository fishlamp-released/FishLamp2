//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfCreateGroupResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfGroup;

// --------------------------------------------------------------------
// FLZfCreateGroupResponse
// --------------------------------------------------------------------
@interface FLZfCreateGroupResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZfGroup* _CreateGroupResult;
} 


@property (readwrite, retain, nonatomic) FLZfGroup* CreateGroupResult;

+ (NSString*) CreateGroupResultKey;

+ (FLZfCreateGroupResponse*) createGroupResponse; 

@end

@interface FLZfCreateGroupResponse (ValueProperties) 
@end

