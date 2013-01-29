//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfReplacePhotoHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfReplacePhotoHttpPostIn
// --------------------------------------------------------------------
@interface FLZfReplacePhotoHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _originalId;
	NSString* _replacedId;
} 


@property (readwrite, retain, nonatomic) NSString* originalId;

@property (readwrite, retain, nonatomic) NSString* replacedId;

+ (NSString*) originalIdKey;

+ (NSString*) replacedIdKey;

+ (FLZfReplacePhotoHttpPostIn*) replacePhotoHttpPostIn; 

@end

@interface FLZfReplacePhotoHttpPostIn (ValueProperties) 
@end

