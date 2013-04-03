//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFUpdateGroup.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class ZFGroupUpdater;

// --------------------------------------------------------------------
// ZFUpdateGroup
// --------------------------------------------------------------------
@interface ZFUpdateGroup : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _groupId;
	ZFGroupUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSNumber* groupId;

@property (readwrite, retain, nonatomic) ZFGroupUpdater* updater;

+ (NSString*) groupIdKey;

+ (NSString*) updaterKey;

+ (ZFUpdateGroup*) updateGroup; 

@end

@interface ZFUpdateGroup (ValueProperties) 

@property (readwrite, assign, nonatomic) int groupIdValue;
@end

