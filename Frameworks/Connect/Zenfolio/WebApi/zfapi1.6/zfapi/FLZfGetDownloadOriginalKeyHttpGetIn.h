//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfGetDownloadOriginalKeyHttpGetIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfGetDownloadOriginalKeyHttpGetIn
// --------------------------------------------------------------------
@interface FLZfGetDownloadOriginalKeyHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _photoIds;
	NSString* _password;
} 


@property (readwrite, retain, nonatomic) NSString* password;

@property (readwrite, retain, nonatomic) NSMutableArray* photoIds;
// Type: NSString*, forKey: String

+ (NSString*) passwordKey;

+ (NSString*) photoIdsKey;

+ (FLZfGetDownloadOriginalKeyHttpGetIn*) getDownloadOriginalKeyHttpGetIn; 

@end

@interface FLZfGetDownloadOriginalKeyHttpGetIn (ValueProperties) 
@end

