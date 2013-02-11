//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioUpdateGroup.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioGroupUpdater;

// --------------------------------------------------------------------
// FLZenfolioUpdateGroup
// --------------------------------------------------------------------
@interface FLZenfolioUpdateGroup : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _groupId;
	FLZenfolioGroupUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSNumber* groupId;

@property (readwrite, retain, nonatomic) FLZenfolioGroupUpdater* updater;

+ (NSString*) groupIdKey;

+ (NSString*) updaterKey;

+ (FLZenfolioUpdateGroup*) updateGroup; 

@end

@interface FLZenfolioUpdateGroup (ValueProperties) 

@property (readwrite, assign, nonatomic) int groupIdValue;
@end

