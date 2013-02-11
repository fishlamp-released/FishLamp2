//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioReplacePhoto.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioReplacePhoto
// --------------------------------------------------------------------
@interface FLZenfolioReplacePhoto : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _originalId;
	NSNumber* _replacedId;
} 


@property (readwrite, retain, nonatomic) NSNumber* originalId;

@property (readwrite, retain, nonatomic) NSNumber* replacedId;

+ (NSString*) originalIdKey;

+ (NSString*) replacedIdKey;

+ (FLZenfolioReplacePhoto*) replacePhoto; 

@end

@interface FLZenfolioReplacePhoto (ValueProperties) 

@property (readwrite, assign, nonatomic) int originalIdValue;

@property (readwrite, assign, nonatomic) int replacedIdValue;
@end

