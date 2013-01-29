//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfLoadPhotoHttpGetIn.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfLoadPhotoHttpGetIn
// --------------------------------------------------------------------
@interface FLZfLoadPhotoHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoId;
	NSString* _level;
} 


@property (readwrite, retain, nonatomic) NSString* level;

@property (readwrite, retain, nonatomic) NSString* photoId;

+ (NSString*) levelKey;

+ (NSString*) photoIdKey;

+ (FLZfLoadPhotoHttpGetIn*) loadPhotoHttpGetIn; 

@end

@interface FLZfLoadPhotoHttpGetIn (ValueProperties) 
@end

