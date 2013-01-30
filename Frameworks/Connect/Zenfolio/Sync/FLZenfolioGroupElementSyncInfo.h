//	This file was generated at 7/3/11 10:47 AM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioGroupElementSyncInfo.h
//	Project: FishLamp
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// FLZenfolioGroupElementSyncInfo
// --------------------------------------------------------------------
@interface FLZenfolioGroupElementSyncInfo : NSObject<NSCopying, NSCoding>{ 
@private
	NSNumber* _isGroup;
	NSNumber* _syncObjectId;
	NSString* _name;
} 


@property (readwrite, retain, nonatomic) NSNumber* isGroup;

@property (readwrite, retain, nonatomic) NSString* name;

@property (readwrite, retain, nonatomic) NSNumber* syncObjectId;

+ (NSString*) isGroupKey;

+ (NSString*) nameKey;

+ (NSString*) syncObjectIdKey;

+ (FLZenfolioGroupElementSyncInfo*) groupElementSyncInfo; 

@end

@interface FLZenfolioGroupElementSyncInfo (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL isGroupValue;

@property (readwrite, assign, nonatomic) NSInteger syncObjectIdValue;
@end

