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
@property (readwrite, retain, nonatomic) NSString* PageUrl;
@property (readwrite, retain, nonatomic) NSMutableArray* ParentGroups;
@property (readwrite, retain, nonatomic) NSDate* ModifiedOn;
@property (readonly, retain, nonatomic) NSNumber* parentGroupId;
@property (readonly, retain, nonatomic) NSString* Caption;
@property (readonly, retain, nonatomic) FLZenfolioPhoto* TitlePhoto;

- (NSDate*) createdOn;
- (NSDate*) modifiedOn;
- (NSString*) title;
//- (NSString*) sizeText;

- (int) groupElementID;

- (NSArray*) elements;
- (BOOL) visitAllElements:(void (^)(FLZenfolioGroupElement* element, BOOL* stop)) visitor;
- (int) photoCount;
- (int) videoCount;
- (unsigned long long) photoBytes;
- (int) galleryCount;
@end

