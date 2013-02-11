//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioUpdateGroupAccess.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioAccessUpdater;

// --------------------------------------------------------------------
// FLZenfolioUpdateGroupAccess
// --------------------------------------------------------------------
@interface FLZenfolioUpdateGroupAccess : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _groupId;
	FLZenfolioAccessUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSNumber* groupId;

@property (readwrite, retain, nonatomic) FLZenfolioAccessUpdater* updater;

+ (NSString*) groupIdKey;

+ (NSString*) updaterKey;

+ (FLZenfolioUpdateGroupAccess*) updateGroupAccess; 

@end

@interface FLZenfolioUpdateGroupAccess (ValueProperties) 

@property (readwrite, assign, nonatomic) int groupIdValue;
@end

