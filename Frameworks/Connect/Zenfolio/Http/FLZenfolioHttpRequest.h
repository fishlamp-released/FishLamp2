//
//  FLZenfolioHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampCocoa.h"
#import "FLHttpRequest.h"

@class FLZenfolioPhotoSet;
@class FLZenfolioGroup;
@class FLZenfolioPhoto;

@protocol FLZenfolioHttpRequestFactory <NSObject>

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

+ (FLHttpRequest*) movePhotoHttpRequest:(FLZenfolioPhoto*) photo
                           fromPhotoSet:(FLZenfolioPhotoSet*) fromPhotoSet
                             toPhotoSet:(FLZenfolioPhotoSet*) toPhotoSet;

+ (FLHttpRequest*) addPhotoToCollectionHttpRequest:(FLZenfolioPhoto*) photo
                                        collection:(FLZenfolioPhotoSet*) toCollection;

+ (FLHttpRequest*) loadGroupHierarchyHttpRequest:(NSString*) loginName;

+ (FLHttpRequest*) loadGroupHttpRequest:(NSNumber*) groupID
                                  level:(NSString*) level
                        includeChildren:(BOOL) includeChildren;
          
@end

@interface FLZenfolioHttpRequest : NSObject<FLZenfolioHttpRequestFactory>

+ (void) setHttpRequestFactoryClass:(Class) factoryClass;
+ (Class) factoryClass;

@end

#define FLZenfolioScrapbookPrivilege @"UseScrapbooks"
#define FLZenfolioVideoPrivilege @"UseVideos"
