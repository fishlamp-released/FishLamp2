//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioLoadGroup.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


#import "FLZenfolioApi1_6Enums.h"

// --------------------------------------------------------------------
// FLZenfolioLoadGroup
// --------------------------------------------------------------------
@interface FLZenfolioLoadGroup : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _groupId;
	NSString* _level;
	NSNumber* _includeChildren;
} 


@property (readwrite, retain, nonatomic) NSNumber* groupId;

@property (readwrite, retain, nonatomic) NSNumber* includeChildren;

@property (readwrite, retain, nonatomic) NSString* level;

+ (NSString*) groupIdKey;

+ (NSString*) includeChildrenKey;

+ (NSString*) levelKey;

+ (FLZenfolioLoadGroup*) loadGroup; 

@end

@interface FLZenfolioLoadGroup (ValueProperties) 

@property (readwrite, assign, nonatomic) int groupIdValue;

@property (readwrite, assign, nonatomic) FLZenfolioInformatonLevel levelValue;

@property (readwrite, assign, nonatomic) BOOL includeChildrenValue;
@end

