//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCategory.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFCategory
// --------------------------------------------------------------------
@interface ZFCategory : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _Code;
	NSString* _DisplayName;
} 


@property (readwrite, retain, nonatomic) NSNumber* Code;

@property (readwrite, retain, nonatomic) NSString* DisplayName;

+ (NSString*) CodeKey;

+ (NSString*) DisplayNameKey;

+ (ZFCategory*) category; 

@end

@interface ZFCategory (ValueProperties) 

@property (readwrite, assign, nonatomic) int CodeValue;
@end

