//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioGetRecentPhotos.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioGetRecentPhotos
// --------------------------------------------------------------------
@interface FLZenfolioGetRecentPhotos : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _offset;
	NSNumber* _limit;
} 


@property (readwrite, retain, nonatomic) NSNumber* limit;

@property (readwrite, retain, nonatomic) NSNumber* offset;

+ (NSString*) limitKey;

+ (NSString*) offsetKey;

+ (FLZenfolioGetRecentPhotos*) getRecentPhotos; 

@end

@interface FLZenfolioGetRecentPhotos (ValueProperties) 

@property (readwrite, assign, nonatomic) int offsetValue;

@property (readwrite, assign, nonatomic) int limitValue;
@end

