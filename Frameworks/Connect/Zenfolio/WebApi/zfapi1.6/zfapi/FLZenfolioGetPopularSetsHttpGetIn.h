//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioGetPopularSetsHttpGetIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioGetPopularSetsHttpGetIn
// --------------------------------------------------------------------
@interface FLZenfolioGetPopularSetsHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _type;
	NSString* _offset;
	NSString* _limit;
} 


@property (readwrite, retain, nonatomic) NSString* limit;

@property (readwrite, retain, nonatomic) NSString* offset;

@property (readwrite, retain, nonatomic) NSString* type;

+ (NSString*) limitKey;

+ (NSString*) offsetKey;

+ (NSString*) typeKey;

+ (FLZenfolioGetPopularSetsHttpGetIn*) getPopularSetsHttpGetIn; 

@end

@interface FLZenfolioGetPopularSetsHttpGetIn (ValueProperties) 
@end
