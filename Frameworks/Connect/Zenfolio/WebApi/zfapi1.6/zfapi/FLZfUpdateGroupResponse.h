//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfUpdateGroupResponse.h
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
// FLZfUpdateGroupResponse
// --------------------------------------------------------------------
@interface FLZfUpdateGroupResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZfGroup* _UpdateGroupResult;
} 


@property (readwrite, retain, nonatomic) FLZfGroup* UpdateGroupResult;

+ (NSString*) UpdateGroupResultKey;

+ (FLZfUpdateGroupResponse*) updateGroupResponse; 

@end

@interface FLZfUpdateGroupResponse (ValueProperties) 
@end

