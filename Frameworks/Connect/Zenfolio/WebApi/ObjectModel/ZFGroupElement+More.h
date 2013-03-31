//
//  ZFGroupElement+More.h
//  FishLamp
//
//  Created by Mike Fullerton on 12/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFGroupElement.h"


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
@property (readwrite, strong, nonatomic) NSString* PageUrl;

@property (readwrite, strong, nonatomic) NSMutableArray* ParentGroups;

@property (readonly, strong, nonatomic) NSDate* CreatedOn;
@property (readwrite, strong, nonatomic) NSDate* ModifiedOn;

@property (readonly, strong, nonatomic) ZFPhoto* TitlePhoto;
@property (readonly, strong, nonatomic) NSNumber* GalleryCount;
@property (readonly, strong, nonatomic) NSNumber* PhotoCount;
@property (readonly, strong, nonatomic) NSNumber* VideoCount;
@property (readonly, strong, nonatomic) NSArray* Elements;
@property (readonly, strong, nonatomic) NSString* Caption;
@property (readonly, strong, nonatomic) NSNumber* PhotoBytes;

@property (readonly, assign, nonatomic) unsigned long long PhotoBytesValue;

// helpers
@property (readonly, strong, nonatomic) NSNumber* parentGroupId;

- (NSString*) sizeText;

- (NSNumber*) calculateGalleryCount;
- (NSNumber*) calculatePhotoCount;
- (NSNumber*) calculateVideoCount;
- (NSNumber*) calculatePhotoBytes;


@end

