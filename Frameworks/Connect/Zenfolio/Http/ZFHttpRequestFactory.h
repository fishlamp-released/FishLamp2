//
//  ZFHttpRequestFactory.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampCocoa.h"
#import "FLHttp.h"

@class ZFPhotoSet;
@class ZFGroup;
@class ZFPhoto;
@class ZFHttpRequestFactory;

@protocol ZFHttpRequestFactory <NSObject>

+ (id) loadPhotoSetHttpRequest:(NSNumber*) photoSetID
                                     level:(NSString*) level
                             includePhotos:(BOOL) includePhotos;

+ (id) loadPhotoSetHttpRequest:(NSNumber*) photoSetID;

+ (id) challengeHttpRequest:(NSString*) loginName;

+ (id) authenticateRequest:(NSData*) challenge proof:(NSData*) proof;

+ (id) loadPrivateProfileHttpRequest;

+ (id) loadPublicProfileHttpRequest:(NSString*) userName;

+ (id) checkPrivilegeHttpRequest:(NSString*) loginName 
                               privilegeName:(NSString*) privilegeName;

+ (id) authenticateVisitorHttpRequest;

+ (id) loadPhotoHttpRequest:(NSNumber*) photoID
                                  level:(NSString*) level;

+ (id) movePhotoHttpRequest:(ZFPhoto*) photo
                           fromPhotoSet:(ZFPhotoSet*) fromPhotoSet
                             toPhotoSet:(ZFPhotoSet*) toPhotoSet;

+ (id) addPhotoToCollectionHttpRequest:(ZFPhoto*) photo
                                        collection:(ZFPhotoSet*) toCollection;

+ (id) loadGroupHierarchyHttpRequest:(NSString*) loginName;

+ (id) loadGroupHttpRequest:(NSNumber*) groupID
                                  level:(NSString*) level
                        includeChildren:(BOOL) includeChildren;
          
@end

@interface ZFHttpRequestFactory : NSObject<ZFHttpRequestFactory>

+ (void) setHttpRequestFactoryClass:(Class) factoryClass;
+ (Class) factoryClass;

@end

#define ZFScrapbookPrivilege @"UseScrapbooks"
#define ZFVideoPrivilege @"UseVideos"
