//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfReplacePhoto.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfReplacePhoto
// --------------------------------------------------------------------
@interface FLZfReplacePhoto : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _originalId;
	NSNumber* _replacedId;
} 


@property (readwrite, retain, nonatomic) NSNumber* originalId;

@property (readwrite, retain, nonatomic) NSNumber* replacedId;

+ (NSString*) originalIdKey;

+ (NSString*) replacedIdKey;

+ (FLZfReplacePhoto*) replacePhoto; 

@end

@interface FLZfReplacePhoto (ValueProperties) 

@property (readwrite, assign, nonatomic) int originalIdValue;

@property (readwrite, assign, nonatomic) int replacedIdValue;
@end

