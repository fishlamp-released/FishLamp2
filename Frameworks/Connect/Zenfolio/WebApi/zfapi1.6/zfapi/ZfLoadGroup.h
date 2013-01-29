//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadGroup.h
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
// ZFLoadGroup
// --------------------------------------------------------------------
@interface ZFLoadGroup : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _groupId;
	NSString* _level;
	NSNumber* _includeChildren;
} 


@property (readwrite, retain, nonatomic) NSNumber* groupId;

@property (readwrite, retain, nonatomic) NSNumber* includeChildren;

@property (readwrite, retain, nonatomic) NSString* level;

+ (NSString*) groupIdKey;

+ (NSString*) includeChildrenKey;

+ (NSString*) levelKey;

+ (ZFLoadGroup*) loadGroup; 

@end

@interface ZFLoadGroup (ValueProperties) 

@property (readwrite, assign, nonatomic) int groupIdValue;

@property (readwrite, assign, nonatomic) ZFInformatonLevel levelValue;

@property (readwrite, assign, nonatomic) BOOL includeChildrenValue;
@end

