//	This file was generated at 7/3/11 1:04 PM by PackMule. DO NOT MODIFY!!
//
//	ZFBrowserViewOptions.h
//	Project: myZenfolio
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


#import "FLDatabaseObject.h"

// --------------------------------------------------------------------
// ZFBrowserViewOptions
// --------------------------------------------------------------------
@interface ZFBrowserViewOptions : FLDatabaseObject<NSCopying, NSCoding>{ 
@private
	NSNumber* _elementId;
	NSNumber* _showIndexNumber;
	NSNumber* _showTitle;
} 


@property (readwrite, retain, nonatomic) NSNumber* elementId;

@property (readwrite, retain, nonatomic) NSNumber* showIndexNumber;

@property (readwrite, retain, nonatomic) NSNumber* showTitle;

+ (NSString*) elementIdKey;

+ (NSString*) showIndexNumberKey;

+ (NSString*) showTitleKey;

+ (ZFBrowserViewOptions*) browserViewOptions; 

@end

@interface ZFBrowserViewOptions (ValueProperties) 

@property (readwrite, assign, nonatomic) int elementIdValue;

@property (readwrite, assign, nonatomic) BOOL showIndexNumberValue;

@property (readwrite, assign, nonatomic) BOOL showTitleValue;
@end

