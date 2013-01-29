//
//  FLZfGroupElement+More.h
//  FishLamp
//
//  Created by Mike Fullerton on 12/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZfGroupElement.h"


typedef enum {
	FLZfGroupElementTypeGroup,
	FLZfGroupElementTypeGallery,
	FLZfGroupElementTypeCollection
} FLZfGroupElementType;

@interface FLZfGroupElement (More)

@property (readonly, assign, nonatomic) BOOL isGalleryElement;
@property (readonly, assign, nonatomic) BOOL isGroupElement;
@property (readonly, assign, nonatomic) BOOL isCollectionElement;
@property (readonly, assign, nonatomic) FLZfGroupElementType groupElementType;

// here for polymorphic use, overridden in FLZfPhotoSet and FLZfGroup
@property (readwrite, retain, nonatomic) NSString* PageUrl;
@property (readwrite, retain, nonatomic) NSMutableArray* ParentGroups;
@property (readwrite, retain, nonatomic) NSDate* ModifiedOn;
@property (readonly, retain, nonatomic) NSNumber* parentGroupId;
@property (readonly, retain, nonatomic) NSString* Caption;
@property (readonly, retain, nonatomic) FLZfPhoto* TitlePhoto;

- (NSDate*) createdOn;
- (NSDate*) modifiedOn;
- (NSString*) title;
- (NSString*) sizeText;

- (int) groupElementID;

- (NSArray*) elements;
- (BOOL) visitAllElements:(void (^)(FLZfGroupElement* element, BOOL* stop)) visitor;
- (int) photoCount;
- (int) videoCount;
- (unsigned long long) photoBytes;
- (int) galleryCount;

@end