//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadGroupResponse.h
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
// ZFLoadGroupResponse
// --------------------------------------------------------------------
@interface ZFLoadGroupResponse : NSObject<NSCoding, NSCopying>{ 
@private
	ZFGroup* _LoadGroupResult;
} 


@property (readwrite, retain, nonatomic) ZFGroup* LoadGroupResult;

+ (NSString*) LoadGroupResultKey;

+ (ZFLoadGroupResponse*) loadGroupResponse; 

@end

@interface ZFLoadGroupResponse (ValueProperties) 
@end

