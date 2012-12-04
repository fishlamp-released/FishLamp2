//
//  FLGalleryObject.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/10/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    FLGalleryObjectTypePhoto,
    FLGalleryObjectTypeGallery,
    FLGalleryObjectTypeCollection,
    FLGalleryObjectTypeGroup,
    FLGalleryObjectTypeSearchResult
} FLGalleryObjectType;

@protocol FLGalleryObject <NSObject>
@property (readonly, strong, nonatomic) id ownerID;
@property (readonly, strong, nonatomic) id parentID;
@property (readonly, assign, nonatomic) FLGalleryObjectType galleryItemType;
@property (readonly, assign, nonatomic) NSUInteger subItemCount;
@end

// concrete implementation.

@interface FLGalleryObject : NSObject<FLGalleryObject> {
@private
    NSString* _title;
    id _objectID;
    id _ownerID;
    id _parentID;
    FLGalleryObjectType _galleryItemType;
    NSUInteger _subItemCount;
// TODO: add in pointers to factories?
}
- (id) initWithObjectID:(id) dataRefKey;
+ (id) galleryObject:(id)objectID;

@property (readwrite, strong, nonatomic) NSString* gridViewDisplayName;
@property (readwrite, strong, nonatomic) id objectID;
@property (readwrite, strong, nonatomic) id ownerID;
@property (readwrite, strong, nonatomic) id parentID;
@property (readwrite, assign, nonatomic) FLGalleryObjectType galleryItemType;
@property (readwrite, assign, nonatomic) NSUInteger subItemCount;
@end

