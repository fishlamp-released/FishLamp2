//
//  ZFHttpRequest.h
//  ZenLib
//
//  Created by Mike Fullerton on 10/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampCocoa.h"
#import "FLHttpRequest.h"

@class ZFPhotoSet;
@class ZFGroup;
@class ZFPhoto;

@protocol ZFHttpRequestFactory <NSObject>

+ (FLHttpRequest*) loadPhotoSetHttpRequest:(NSNumber*) photoSetID
                         level:(NSString*) level
                 includePhotos:(BOOL) includePhotos;

+ (FLHttpRequest*) loadPhotoSetHttpRequest:(NSNumber*) photoSetID;

+ (FLHttpRequest*) challengeHttpRequest:(NSString*) loginName;

+ (FLHttpRequest*) authenticateHttpRequest:(NSData*) challenge proof:(NSData*) proof;

+ (FLHttpRequest*) loadPrivateProfileHttpRequest;

+ (FLHttpRequest*) loadPublicProfileHttpRequest:(NSString*) userName;

+ (FLHttpRequest*) checkPrivilegeHttpRequest:(NSString*) loginName 
                               privilegeName:(NSString*) privilegeName;

+ (FLHttpRequest*) authenticateVisitorHttpRequest;

+ (FLHttpRequest*) loadPhotoHttpRequest:(NSNumber*) photoID
                    level:(NSString*) level;

+ (FLHttpRequest*) movePhotoHttpRequest:(ZFPhoto*) photo
             fromPhotoSet:(ZFPhotoSet*) fromPhotoSet
               toPhotoSet:(ZFPhotoSet*) toPhotoSet;

+ (FLHttpRequest*) addPhotoToCollectionHttpRequest:(ZFPhoto*) photo
                          collection:(ZFPhotoSet*) toCollection;

+ (FLHttpRequest*) loadGroupHierarchyHttpRequest:(NSString*) loginName;

+ (FLHttpRequest*) loadGroupHttpRequest:(NSNumber*) groupID
                                  level:(NSString*) level
                        includeChildren:(BOOL) includeChildren;
          
@end

@interface ZFHttpRequest : NSObject<ZFHttpRequestFactory>

+ (void) setHttpRequestFactoryClass:(Class) factoryClass;
+ (Class) factoryClass;

@end

#define ZFScrapbookPrivilege @"UseScrapbooks"
#define ZFVideoPrivilege @"UseVideos"
