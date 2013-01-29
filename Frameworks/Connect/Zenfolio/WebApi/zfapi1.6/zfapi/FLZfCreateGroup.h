//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfCreateGroup.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfGroupUpdater;

// --------------------------------------------------------------------
// FLZfCreateGroup
// --------------------------------------------------------------------
@interface FLZfCreateGroup : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _parentId;
	FLZfGroupUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSNumber* parentId;

@property (readwrite, retain, nonatomic) FLZfGroupUpdater* updater;

+ (NSString*) parentIdKey;

+ (NSString*) updaterKey;

+ (FLZfCreateGroup*) createGroup; 

@end

@interface FLZfCreateGroup (ValueProperties) 

@property (readwrite, assign, nonatomic) int parentIdValue;
@end

