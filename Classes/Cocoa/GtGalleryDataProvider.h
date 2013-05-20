//
//  GtGalleryDataSource.h
//  FishLamp-iOS-Lib
//
//  Created by Fullerton Mike on 1/2/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtGridViewController.h"
#import "GtActionContext.h"
#import "GtOrderedCollection.h"
#import "GtAsyncEventHandler.h"

typedef enum {
    GtGalleryObjectTypePhoto,
    GtGalleryObjectTypeGallery,
    GtGalleryObjectTypeCollection,
    GtGalleryObjectTypeGroup,
    GtGalleryObjectTypeSearchResult
} GtGalleryObjectType;

typedef enum {
    GtGalleryImageSizeHintNone,
    GtGalleryImageSizeHintThumbnail,
    GtGalleryImageSizeHintFullScreen,
    GtGalleryImageSizeHintFullScreenZoomed
} GtGalleryImageSizeHint;

#define GtGalleryDataSourceErrorDomain @"GtGalleryDataSourceErrorDomain"
typedef enum {
    GtGalleryDataSourceErrorNotLoaded = 1,
    GtGalleryDataSourceErrorNotFound
} GtGalleryDataSourceErrorNum;


@protocol GtGalleryObject <GtGridViewObject> 
@property (readonly, retain, nonatomic) id ownerID;
@property (readonly, retain, nonatomic) id parentID;
@property (readonly, assign, nonatomic) GtGalleryObjectType galleryItemType;
@property (readonly, assign, nonatomic) NSUInteger subItemCount;
@end

@protocol GtGalleryDataProvider <NSObject>

@property (readwrite, assign, nonatomic) NSUInteger pageSize;

- (void) beginLoadingGalleryContainerByID:(id) galleryID
                             eventHandler:(GtAsyncEventHandler*) eventHandler; // result is a GtGalleryObject

- (void) beginLoadingChildrenForGallery:(id) galleryContainer
                          startingIndex:(NSUInteger) startingIndex
                           eventHandler:(GtAsyncEventHandler*) eventHandler; // result is a array of Gallery Objects
    
- (void) beginLoadingImageForGalleryObject:(id) galleryObject
                                sizeInView:(CGSize) imageSize
                                  sizeHint:(GtGalleryImageSizeHint) sizeHint
                              eventHandler:(GtAsyncEventHandler*) eventHandler; // result is a UIImage
    

@end

// TODO: move elsewhere

@protocol GtGridViewUser <GtGridViewObject>

@end

@protocol GtGridViewUserDataProvider <NSObject>

- (void) beginLoadingUserByID:(id) userID
                 eventHandler:(GtAsyncEventHandler*) eventHandler; // result is a GtGridViewUser

@end


// concrete implementation.

@interface GtGalleryObject : NSObject<GtGalleryObject> {
@private
    NSMutableArray* m_galleryItems;
    id m_gridViewObjectID;
    NSString* m_title;
    id m_ownerID;
    id m_parentID;
    GtGalleryObjectType m_galleryItemType;
    NSUInteger m_subItemCount;

// TODO: add in pointers to factories?
}
- (id) initWithGridViewDataID:(id) gridViewObjectID;
+ (id) galleryItem:(id) gridViewObjectID;

@property (readwrite, retain, nonatomic) id gridViewObjectID;
@property (readwrite, retain, nonatomic) NSString* gridViewDisplayName;
@property (readwrite, retain, nonatomic) id ownerID;
@property (readwrite, retain, nonatomic) id parentID;
@property (readwrite, assign, nonatomic) GtGalleryObjectType galleryItemType;
@property (readwrite, assign, nonatomic) NSUInteger subItemCount;
@end