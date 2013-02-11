//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioLoadPhoto.h
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
// FLZenfolioLoadPhoto
// --------------------------------------------------------------------
@interface FLZenfolioLoadPhoto : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoId;
	NSString* _level;
} 


@property (readwrite, retain, nonatomic) NSString* level;

@property (readwrite, retain, nonatomic) NSNumber* photoId;

+ (NSString*) levelKey;

+ (NSString*) photoIdKey;

+ (FLZenfolioLoadPhoto*) loadPhoto; 

@end

@interface FLZenfolioLoadPhoto (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoIdValue;

@property (readwrite, assign, nonatomic) FLZenfolioInformatonLevel levelValue;
@end

