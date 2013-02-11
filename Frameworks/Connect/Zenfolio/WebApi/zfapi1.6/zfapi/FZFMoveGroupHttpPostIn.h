//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioMoveGroupHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioMoveGroupHttpPostIn
// --------------------------------------------------------------------
@interface FLZenfolioMoveGroupHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _groupId;
	NSString* _destGroupId;
	NSString* _index;
} 


@property (readwrite, retain, nonatomic) NSString* destGroupId;

@property (readwrite, retain, nonatomic) NSString* groupId;

@property (readwrite, retain, nonatomic) NSString* index;

+ (NSString*) destGroupIdKey;

+ (NSString*) groupIdKey;

+ (NSString*) indexKey;

+ (FLZenfolioMoveGroupHttpPostIn*) moveGroupHttpPostIn; 

@end

@interface FLZenfolioMoveGroupHttpPostIn (ValueProperties) 
@end

