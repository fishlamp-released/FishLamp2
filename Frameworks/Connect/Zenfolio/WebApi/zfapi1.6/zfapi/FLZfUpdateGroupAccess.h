//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfUpdateGroupAccess.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfAccessUpdater;

// --------------------------------------------------------------------
// FLZfUpdateGroupAccess
// --------------------------------------------------------------------
@interface FLZfUpdateGroupAccess : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _groupId;
	FLZfAccessUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSNumber* groupId;

@property (readwrite, retain, nonatomic) FLZfAccessUpdater* updater;

+ (NSString*) groupIdKey;

+ (NSString*) updaterKey;

+ (FLZfUpdateGroupAccess*) updateGroupAccess; 

@end

@interface FLZfUpdateGroupAccess (ValueProperties) 

@property (readwrite, assign, nonatomic) int groupIdValue;
@end

