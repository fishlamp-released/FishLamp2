//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFReorderGroupHttpGetIn.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFReorderGroupHttpGetIn
// --------------------------------------------------------------------
@interface ZFReorderGroupHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _groupId;
	NSString* _shiftOrder;
} 


@property (readwrite, retain, nonatomic) NSString* groupId;

@property (readwrite, retain, nonatomic) NSString* shiftOrder;

+ (NSString*) groupIdKey;

+ (NSString*) shiftOrderKey;

+ (ZFReorderGroupHttpGetIn*) reorderGroupHttpGetIn; 

@end

@interface ZFReorderGroupHttpGetIn (ValueProperties) 
@end

