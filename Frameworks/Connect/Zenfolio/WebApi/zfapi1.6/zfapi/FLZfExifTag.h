//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfExifTag.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfExifTag
// --------------------------------------------------------------------
@interface FLZfExifTag : NSObject<NSCoding, NSCopying>{ 
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

+ (FLZfExifTag*) exifTag; 

@end

@interface FLZfExifTag (ValueProperties) 

@property (readwrite, assign, nonatomic) int IdValue;
@end

