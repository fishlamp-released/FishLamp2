//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioCreateGroup.h
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
// FLZenfolioCreateGroup
// --------------------------------------------------------------------
@interface FLZenfolioCreateGroup : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _parentId;
	FLZenfolioGroupUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSNumber* parentId;

@property (readwrite, retain, nonatomic) FLZenfolioGroupUpdater* updater;

+ (NSString*) parentIdKey;

+ (NSString*) updaterKey;

+ (FLZenfolioCreateGroup*) createGroup; 

@end

@interface FLZenfolioCreateGroup (ValueProperties) 

@property (readwrite, assign, nonatomic) int parentIdValue;
@end

