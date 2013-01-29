//
//  ZFWebService.m
//  ZenLib
//
//  Created by Mike Fullerton on 10/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#import "ZFHttpRequest.h"

@implementation ZFHttpRequest

static Class s_factoryClass = nil;

//+ (BOOL)instancesRespondToSelector:(SEL)aSelector {
//    return  [super instancesRespondToSelector:aSelector] ||
//            [s_factoryClassClass instancesRespondToSelector:aSelector];
//}

+ (void) setHttpRequestFactoryClass:(Class) factoryClass {
    s_factoryClass = factoryClass;
}
+ (Class) factoryClass {
    return s_factoryClass;
}

+ (FLHttpRequest*) loadPhotoSetHttpRequest:(NSNumber*) photoSetID
                         level:(NSString*) level
                 includePhotos:(BOOL) includePhotos {
                 
    return [s_factoryClass loadPhotoSetHttpRequest:photoSetID level:level includePhotos:includePhotos];
}

+ (FLHttpRequest*) loadPhotoSetHttpRequest:(NSNumber*) photoSetID {
    return [s_factoryClass loadPhotoSetHttpRequest:photoSetID];
}

+ (FLHttpRequest*) challengeHttpRequest:(NSString*) loginName {
    return [s_factoryClass challengeHttpRequest:loginName];
}

+ (FLHttpRequest*) authenticateHttpRequest:(NSData*) challenge proof:(NSData*) proof {
    return [s_factoryClass authenticateHttpRequest:challenge proof:proof];
}

+ (FLHttpRequest*) loadPrivateProfileHttpRequest {
    return [s_factoryClass loadPrivateProfileHttpRequest];
}

+ (FLHttpRequest*) loadPublicProfileHttpRequest:(NSString*) userName {
    return [s_factoryClass loadPublicProfileHttpRequest:userName];
}

+ (FLHttpRequest*) checkPrivilegeHttpRequest:(NSString*) loginName 
                               privilegeName:(NSString*) privilegeName {
    return [s_factoryClass checkPrivilegeHttpRequest:loginName privilegeName:privilegeName];
}                            

+ (FLHttpRequest*) authenticateVisitorHttpRequest {
    return [s_factoryClass authenticateVisitorHttpRequest];
}

+ (FLHttpRequest*) loadPhotoHttpRequest:(NSNumber*) photoID
                    level:(NSString*) level {
    return [s_factoryClass loadPhotoHttpRequest:photoID level:level];
}                    

+ (FLHttpRequest*) movePhotoHttpRequest:(ZFPhoto*) photo
             fromPhotoSet:(ZFPhotoSet*) fromPhotoSet
               toPhotoSet:(ZFPhotoSet*) toPhotoSet {
    return [s_factoryClass movePhotoHttpRequest:photo fromPhotoSet:fromPhotoSet toPhotoSet:toPhotoSet];
               
}               

+ (FLHttpRequest*) addPhotoToCollectionHttpRequest:(ZFPhoto*) photo
                          collection:(ZFPhotoSet*) toCollection {
    return [s_factoryClass addPhotoToCollectionHttpRequest:photo collection:toCollection];
}                          

+ (FLHttpRequest*) loadGroupHierarchyHttpRequest:(NSString*) loginName {
    return [s_factoryClass loadGroupHierarchyHttpRequest:loginName];
}

+ (FLHttpRequest*) loadGroupHttpRequest:(NSNumber*) groupID
                                  level:(NSString*) level
                        includeChildren:(BOOL) includeChildren {

    return [s_factoryClass loadGroupHttpRequest:groupID 
                                          level:level 
                                includeChildren:includeChildren];
}                        
          

@end