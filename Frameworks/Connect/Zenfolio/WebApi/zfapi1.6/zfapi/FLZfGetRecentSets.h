//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfGetRecentSets.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


#import "FLZfApi1_6Enums.h"

// --------------------------------------------------------------------
// FLZfGetRecentSets
// --------------------------------------------------------------------
@interface FLZfGetRecentSets : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _type;
	NSNumber* _offset;
	NSNumber* _limit;
} 


@property (readwrite, retain, nonatomic) NSNumber* limit;

@property (readwrite, retain, nonatomic) NSNumber* offset;

@property (readwrite, retain, nonatomic) NSString* type;

+ (NSString*) limitKey;

+ (NSString*) offsetKey;

+ (NSString*) typeKey;

+ (FLZfGetRecentSets*) getRecentSets; 

@end

@interface FLZfGetRecentSets (ValueProperties) 

@property (readwrite, assign, nonatomic) FLZfPhotoSetType typeValue;

@property (readwrite, assign, nonatomic) int offsetValue;

@property (readwrite, assign, nonatomic) int limitValue;
@end

