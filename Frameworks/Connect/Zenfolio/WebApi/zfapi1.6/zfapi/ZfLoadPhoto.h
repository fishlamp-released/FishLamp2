//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadPhoto.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


#import "ZFApi1_6Enums.h"

// --------------------------------------------------------------------
// ZFLoadPhoto
// --------------------------------------------------------------------
@interface ZFLoadPhoto : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoId;
	NSString* _level;
} 


@property (readwrite, retain, nonatomic) NSString* level;

@property (readwrite, retain, nonatomic) NSNumber* photoId;

+ (NSString*) levelKey;

+ (NSString*) photoIdKey;

+ (ZFLoadPhoto*) loadPhoto; 

@end

@interface ZFLoadPhoto (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoIdValue;

@property (readwrite, assign, nonatomic) ZFInformatonLevel levelValue;
@end

