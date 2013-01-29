//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCreateGroup.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class ZFGroupUpdater;

// --------------------------------------------------------------------
// ZFCreateGroup
// --------------------------------------------------------------------
@interface ZFCreateGroup : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _parentId;
	ZFGroupUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSNumber* parentId;

@property (readwrite, retain, nonatomic) ZFGroupUpdater* updater;

+ (NSString*) parentIdKey;

+ (NSString*) updaterKey;

+ (ZFCreateGroup*) createGroup; 

@end

@interface ZFCreateGroup (ValueProperties) 

@property (readwrite, assign, nonatomic) int parentIdValue;
@end

