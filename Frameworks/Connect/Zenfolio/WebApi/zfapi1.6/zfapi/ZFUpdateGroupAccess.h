//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFUpdateGroupAccess.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class ZFAccessUpdater;

// --------------------------------------------------------------------
// ZFUpdateGroupAccess
// --------------------------------------------------------------------
@interface ZFUpdateGroupAccess : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _groupId;
	ZFAccessUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSNumber* groupId;

@property (readwrite, retain, nonatomic) ZFAccessUpdater* updater;

+ (NSString*) groupIdKey;

+ (NSString*) updaterKey;

+ (ZFUpdateGroupAccess*) updateGroupAccess; 

@end

@interface ZFUpdateGroupAccess (ValueProperties) 

@property (readwrite, assign, nonatomic) int groupIdValue;
@end

