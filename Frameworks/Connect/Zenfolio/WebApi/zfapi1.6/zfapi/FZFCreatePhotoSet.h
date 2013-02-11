//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioCreatePhotoSet.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


#import "FLZenfolioApi1_6Enums.h"
@class FLZenfolioPhotoSetUpdater;

// --------------------------------------------------------------------
// FLZenfolioCreatePhotoSet
// --------------------------------------------------------------------
@interface FLZenfolioCreatePhotoSet : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _groupId;
	NSString* _type;
	FLZenfolioPhotoSetUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSNumber* groupId;

@property (readwrite, retain, nonatomic) NSString* type;

@property (readwrite, retain, nonatomic) FLZenfolioPhotoSetUpdater* updater;

+ (NSString*) groupIdKey;

+ (NSString*) typeKey;

+ (NSString*) updaterKey;

+ (FLZenfolioCreatePhotoSet*) createPhotoSet; 

@end

@interface FLZenfolioCreatePhotoSet (ValueProperties) 

@property (readwrite, assign, nonatomic) int groupIdValue;

@property (readwrite, assign, nonatomic) FLZenfolioPhotoSetType typeValue;
@end

