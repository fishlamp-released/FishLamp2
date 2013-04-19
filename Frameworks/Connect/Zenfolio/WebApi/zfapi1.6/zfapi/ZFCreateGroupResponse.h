//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCreateGroupResponse.h
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
// ZFCreateGroupResponse
// --------------------------------------------------------------------
@interface ZFCreateGroupResponse : NSObject<NSCoding, NSCopying>{ 
@private
	ZFGroup* _CreateGroupResult;
} 


@property (readwrite, retain, nonatomic) ZFGroup* CreateGroupResult;

+ (NSString*) CreateGroupResultKey;

+ (ZFCreateGroupResponse*) createGroupResponse; 

@end

@interface ZFCreateGroupResponse (ValueProperties) 
@end
