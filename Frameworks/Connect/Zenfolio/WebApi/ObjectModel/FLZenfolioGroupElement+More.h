//
//  FLZenfolioGroupElement+More.h
//  FishLamp
//
//  Created by Mike Fullerton on 12/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioGroupElement.h"


typedef enum {
	FLZenfolioGroupElementTypeGroup,
	FLZenfolioGroupElementTypeGallery,
	FLZenfolioGroupElementTypeCollection
} FLZenfolioGroupElementType;

@interface FLZenfolioGroupElement (More)

@property (readonly, assign, nonatomic) BOOL isGalleryElement;
@property (readonly, assign, nonatomic) BOOL isGroupElement;
@property (readonly, assign, nonatomic) BOOL isCollectionElement;
@property (readonly, assign, nonatomic) FLZenfolioGroupElementType groupElementType;

// here for polymorphic use, overridden in FLZenfolioPhotoSet and FLZenfolioGroup
@property (readwrite, strong, nonatomic) NSString* PageUrl;

@property (readwrite, strong, nonatomic) NSMutableArray* ParentGroups;

@property (readonly, strong, nonatomic) NSDate* CreatedOn;
@property (readwrite, strong, nonatomic) NSDate* ModifiedOn;

@property (readonly, strong, nonatomic) FLZenfolioPhoto* TitlePhoto;
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

@end

