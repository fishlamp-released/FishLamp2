//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfDeleteGroup.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfDeleteGroup
// --------------------------------------------------------------------
@interface FLZfDeleteGroup : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _groupId;
} 


@property (readwrite, retain, nonatomic) NSNumber* groupId;

+ (NSString*) groupIdKey;

+ (FLZfDeleteGroup*) deleteGroup; 

@end

@interface FLZfDeleteGroup (ValueProperties) 

@property (readwrite, assign, nonatomic) int groupIdValue;
@end

