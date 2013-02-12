//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioCategory.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioCategory
// --------------------------------------------------------------------
@interface FLZenfolioCategory : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _Code;
	NSString* _DisplayName;
} 


@property (readwrite, retain, nonatomic) NSNumber* Code;

@property (readwrite, retain, nonatomic) NSString* DisplayName;

+ (NSString*) CodeKey;

+ (NSString*) DisplayNameKey;

+ (FLZenfolioCategory*) category; 

@end

@interface FLZenfolioCategory (ValueProperties) 

@property (readwrite, assign, nonatomic) int CodeValue;
@end

