//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioExifTag.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioExifTag
// --------------------------------------------------------------------
@interface FLZenfolioExifTag : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _Id;
	NSString* _Value;
	NSString* _DisplayValue;
} 


@property (readwrite, retain, nonatomic) NSString* DisplayValue;

@property (readwrite, retain, nonatomic) NSNumber* Id;

@property (readwrite, retain, nonatomic) NSString* Value;

+ (NSString*) DisplayValueKey;

+ (NSString*) IdKey;

+ (NSString*) ValueKey;

+ (FLZenfolioExifTag*) exifTag; 

@end

@interface FLZenfolioExifTag (ValueProperties) 

@property (readwrite, assign, nonatomic) int IdValue;
@end

