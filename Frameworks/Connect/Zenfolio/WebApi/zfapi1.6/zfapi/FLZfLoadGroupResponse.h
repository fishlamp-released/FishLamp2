//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfLoadGroupResponse.h
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
// FLZfLoadGroupResponse
// --------------------------------------------------------------------
@interface FLZfLoadGroupResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZfGroup* _LoadGroupResult;
} 


@property (readwrite, retain, nonatomic) FLZfGroup* LoadGroupResult;

+ (NSString*) LoadGroupResultKey;

+ (FLZfLoadGroupResponse*) loadGroupResponse; 

@end

@interface FLZfLoadGroupResponse (ValueProperties) 
@end

