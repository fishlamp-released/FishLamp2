//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioDeleteGroup.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioDeleteGroup
// --------------------------------------------------------------------
@interface FLZenfolioDeleteGroup : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _groupId;
} 


@property (readwrite, retain, nonatomic) NSNumber* groupId;

+ (NSString*) groupIdKey;

+ (FLZenfolioDeleteGroup*) deleteGroup; 

@end

@interface FLZenfolioDeleteGroup (ValueProperties) 

@property (readwrite, assign, nonatomic) int groupIdValue;
@end

