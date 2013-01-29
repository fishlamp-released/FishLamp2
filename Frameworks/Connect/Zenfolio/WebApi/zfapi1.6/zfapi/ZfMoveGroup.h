//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFMoveGroup.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFMoveGroup
// --------------------------------------------------------------------
@interface ZFMoveGroup : NSObject<NSCoding, NSCopying>{ 
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

+ (ZFMoveGroup*) moveGroup; 

@end

@interface ZFMoveGroup (ValueProperties) 

@property (readwrite, assign, nonatomic) int groupIdValue;

@property (readwrite, assign, nonatomic) int destGroupIdValue;

@property (readwrite, assign, nonatomic) int indexValue;
@end

