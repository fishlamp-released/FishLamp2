//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadGroupHttpGetIn.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFLoadGroupHttpGetIn
// --------------------------------------------------------------------
@interface ZFLoadGroupHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _groupId;
	NSString* _level;
	NSString* _includeChildren;
} 


@property (readwrite, retain, nonatomic) NSString* groupId;

@property (readwrite, retain, nonatomic) NSString* includeChildren;

@property (readwrite, retain, nonatomic) NSString* level;

+ (NSString*) groupIdKey;

+ (NSString*) includeChildrenKey;

+ (NSString*) levelKey;

+ (ZFLoadGroupHttpGetIn*) loadGroupHttpGetIn; 

@end

@interface ZFLoadGroupHttpGetIn (ValueProperties) 
@end

