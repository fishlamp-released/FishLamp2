//
//  ZFGroupElement+More.h
//  ZenLib
//
//  Created by Mike Fullerton on 12/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZfGroupElement.h"


typedef enum {
	ZFGroupElementTypeGroup,
	ZFGroupElementTypeGallery,
	ZFGroupElementTypeCollection
} ZFGroupElementType;

@interface ZFGroupElement (More)

@property (readonly, assign, nonatomic) BOOL isGalleryElement;
@property (readonly, assign, nonatomic) BOOL isGroupElement;
@property (readonly, assign, nonatomic) BOOL isCollectionElement;
@property (readonly, assign, nonatomic) ZFGroupElementType groupElementType;

// here for polymorphic use, overridden in ZFPhotoSet and ZFGroup
@property (readwrite, retain, nonatomic) NSString* PageUrl;
@property (readwrite, retain, nonatomic) NSMutableArray* ParentGroups;
@property (readwrite, retain, nonatomic) NSDate* ModifiedOn;
@property (readonly, retain, nonatomic) NSNumber* parentGroupId;
@property (readonly, retain, nonatomic) NSString* Caption;
@property (readonly, retain, nonatomic) ZFPhoto* TitlePhoto;

- (NSDate*) createdOn;
- (NSDate*) modifiedOn;
- (NSString*) title;
- (NSString*) sizeText;

- (int) groupElementID;

- (NSArray*) elements;
- (BOOL) visitAllElements:(void (^)(ZFGroupElement* element, BOOL* stop)) visitor;
- (int) photoCount;
- (int) videoCount;
- (unsigned long long) photoBytes;
- (int) galleryCount;

@end