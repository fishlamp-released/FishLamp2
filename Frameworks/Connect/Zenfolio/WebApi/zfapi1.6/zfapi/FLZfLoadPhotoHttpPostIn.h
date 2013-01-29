//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfLoadPhotoHttpPostIn.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfLoadPhotoHttpPostIn
// --------------------------------------------------------------------
@interface FLZfLoadPhotoHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoId;
	NSString* _level;
} 


@property (readwrite, retain, nonatomic) NSString* level;

@property (readwrite, retain, nonatomic) NSString* photoId;

+ (NSString*) levelKey;

+ (NSString*) photoIdKey;

+ (FLZfLoadPhotoHttpPostIn*) loadPhotoHttpPostIn; 

@end

@interface FLZfLoadPhotoHttpPostIn (ValueProperties) 
@end

