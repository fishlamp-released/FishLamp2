//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFDeleteGroupHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFDeleteGroupHttpPostIn
// --------------------------------------------------------------------
@interface ZFDeleteGroupHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _groupId;
} 


@property (readwrite, retain, nonatomic) NSString* groupId;

+ (NSString*) groupIdKey;

+ (ZFDeleteGroupHttpPostIn*) deleteGroupHttpPostIn; 

@end

@interface ZFDeleteGroupHttpPostIn (ValueProperties) 
@end

