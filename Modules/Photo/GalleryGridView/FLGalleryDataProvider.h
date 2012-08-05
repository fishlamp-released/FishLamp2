//
//  FLGalleryDataSource.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/2/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLGridViewController.h"
#import "FLActionContext.h"
#import "FLOrderedCollection.h"
#import "FLAsyncEventHandler.h"

typedef enum {
    FLGalleryObjectTypePhoto,
    FLGalleryObjectTypeGallery,
    FLGalleryObjectTypeCollection,
    FLGalleryObjectTypeGroup,
    FLGalleryObjectTypeSearchResult
} FLGalleryObjectType;

typedef enum {
    FLGalleryImageSizeHintNone,
    FLGalleryImageSizeHintThumbnail,
    FLGalleryImageSizeHintFullScreen,
    FLGalleryImageSizeHintFullScreenZoomed
} FLGalleryImageSizeHint;

#define FLGalleryDataSourceErrorDomain @"FLGalleryDataSourceErrorDomain"
typedef enum {
    FLGalleryDataSourceErrorNotLoaded = 1,
    FLGalleryDataSourceErrorNotFound
} FLGalleryDataSourceErrorNum;


@protocol FLGalleryObject <FLGridViewObject> 
@property (readonly, retain, nonatomic) id ownerID;
@property (readonly, retain, nonatomic) id parentID;
@property (readonly, assign, nonatomic) FLGalleryObjectType galleryItemType;
@property (readonly, assign, nonatomic) NSUInteger subItemCount;
@end

@protocol FLGalleryDataProvider <NSObject>

@property (readwrite, assign, nonatomic) NSUInteger pageSize;

- (void) beginLoadingGalleryContainerByID:(id) galleryID
                             eventHandler:(FLAsyncEventHandler*) eventHandler; // result is a FLGalleryObject

- (void) beginLoadingChildrenForGallery:(id) galleryContainer
                          startingIndex:(NSUInteger) startingIndex
                           eventHandler:(FLAsyncEventHandler*) eventHandler; // result is a array of Gallery Objects
    
- (void) beginLoadingImageForGalleryObject:(id) galleryObject
                                sizeInView:(CGSize) imageSize
                                  sizeHint:(FLGalleryImageSizeHint) sizeHint
                              eventHandler:(FLAsyncEventHandler*) eventHandler; // result is a UIImage
    

@end

// TODO: move elsewhere

@protocol FLGridViewUser <FLGridViewObject>

@end

@protocol FLGridViewUserDataProvider <NSObject>

- (void) beginLoadingUserByID:(id) userID
                 eventHandler:(FLAsyncEventHandler*) eventHandler; // result is a FLGridViewUser

@end


// concrete implementation.

@interface FLGalleryObject : NSObject<FLGalleryObject> {
@private
//    NSMutableArray* m_galleryItems;
    id m_gridViewObjectId;
    NSString* m_title;
    id m_ownerID;
    id m_parentID;
    FLGalleryObjectType m_galleryItemType;
    NSUInteger m_subItemCount;

// TODO: add in pointers to factories?
}
- (id) initWithGridViewDataID:(id) gridViewObjectId;
+ (id) galleryItem:(id) gridViewObjectId;

@property (readwrite, retain, nonatomic) id gridViewObjectId;
@property (readwrite, retain, nonatomic) NSString* gridViewDisplayName;
@property (readwrite, retain, nonatomic) id ownerID;
@property (readwrite, retain, nonatomic) id parentID;
@property (readwrite, assign, nonatomic) FLGalleryObjectType galleryItemType;
@property (readwrite, assign, nonatomic) NSUInteger subItemCount;
@end