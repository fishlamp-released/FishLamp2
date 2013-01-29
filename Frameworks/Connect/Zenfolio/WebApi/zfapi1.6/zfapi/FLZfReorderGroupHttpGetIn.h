//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfReorderGroupHttpGetIn.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfReorderGroupHttpGetIn
// --------------------------------------------------------------------
@interface FLZfReorderGroupHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _groupId;
	NSString* _shiftOrder;
} 


@property (readwrite, retain, nonatomic) NSString* groupId;

@property (readwrite, retain, nonatomic) NSString* shiftOrder;

+ (NSString*) groupIdKey;

+ (NSString*) shiftOrderKey;

+ (FLZfReorderGroupHttpGetIn*) reorderGroupHttpGetIn; 

@end

@interface FLZfReorderGroupHttpGetIn (ValueProperties) 
@end

