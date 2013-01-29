//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfCategory.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfCategory
// --------------------------------------------------------------------
@interface FLZfCategory : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _Code;
	NSString* _DisplayName;
} 


@property (readwrite, retain, nonatomic) NSNumber* Code;

@property (readwrite, retain, nonatomic) NSString* DisplayName;

+ (NSString*) CodeKey;

+ (NSString*) DisplayNameKey;

+ (FLZfCategory*) category; 

@end

@interface FLZfCategory (ValueProperties) 

@property (readwrite, assign, nonatomic) int CodeValue;
@end

