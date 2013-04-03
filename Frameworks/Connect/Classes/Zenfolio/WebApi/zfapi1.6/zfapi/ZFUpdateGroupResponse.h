//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFUpdateGroupResponse.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class ZFGroup;

// --------------------------------------------------------------------
// ZFUpdateGroupResponse
// --------------------------------------------------------------------
@interface ZFUpdateGroupResponse : NSObject<NSCoding, NSCopying>{ 
@private
	ZFGroup* _UpdateGroupResult;
} 


@property (readwrite, retain, nonatomic) ZFGroup* UpdateGroupResult;

+ (NSString*) UpdateGroupResultKey;

+ (ZFUpdateGroupResponse*) updateGroupResponse; 

@end

@interface ZFUpdateGroupResponse (ValueProperties) 
@end

