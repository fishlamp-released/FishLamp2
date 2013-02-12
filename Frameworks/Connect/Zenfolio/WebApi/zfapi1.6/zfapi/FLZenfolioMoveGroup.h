//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioMoveGroup.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioMoveGroup
// --------------------------------------------------------------------
@interface FLZenfolioMoveGroup : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _groupId;
	NSNumber* _destGroupId;
	NSNumber* _index;
} 


@property (readwrite, retain, nonatomic) NSNumber* destGroupId;

@property (readwrite, retain, nonatomic) NSNumber* groupId;

@property (readwrite, retain, nonatomic) NSNumber* index;

+ (NSString*) destGroupIdKey;

+ (NSString*) groupIdKey;

+ (NSString*) indexKey;

+ (FLZenfolioMoveGroup*) moveGroup; 

@end

@interface FLZenfolioMoveGroup (ValueProperties) 

@property (readwrite, assign, nonatomic) int groupIdValue;

@property (readwrite, assign, nonatomic) int destGroupIdValue;

@property (readwrite, assign, nonatomic) int indexValue;
@end

