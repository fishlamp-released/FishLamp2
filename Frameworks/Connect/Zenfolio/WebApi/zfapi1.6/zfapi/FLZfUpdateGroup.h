//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfUpdateGroup.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfGroupUpdater;

// --------------------------------------------------------------------
// FLZfUpdateGroup
// --------------------------------------------------------------------
@interface FLZfUpdateGroup : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _groupId;
	FLZfGroupUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSNumber* groupId;

@property (readwrite, retain, nonatomic) FLZfGroupUpdater* updater;

+ (NSString*) groupIdKey;

+ (NSString*) updaterKey;

+ (FLZfUpdateGroup*) updateGroup; 

@end

@interface FLZfUpdateGroup (ValueProperties) 

@property (readwrite, assign, nonatomic) int groupIdValue;
@end

