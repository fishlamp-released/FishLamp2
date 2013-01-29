//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfDeleteGroupHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfDeleteGroupHttpPostIn
// --------------------------------------------------------------------
@interface FLZfDeleteGroupHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _groupId;
} 


@property (readwrite, retain, nonatomic) NSString* groupId;

+ (NSString*) groupIdKey;

+ (FLZfDeleteGroupHttpPostIn*) deleteGroupHttpPostIn; 

@end

@interface FLZfDeleteGroupHttpPostIn (ValueProperties) 
@end

