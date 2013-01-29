//
//  ZFSoapHttpRequestFactory.m
//  ZenLib
//
//  Created by Mike Fullerton on 10/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFSoapHttpRequestFactory.h"
//#import "NSError+FLExtras.h"
#import "ZFSoapHttpRequest.h"
//#import "FLUserLoginService.h"

//#import "FLNetworkServerContext.h"

#import "ZFApi1_6All.h"

#define ZFSoapHttpRequestFrom(__NAME__, __OUTPUT__) \
    [ZFSoapHttpRequestFactory convertToSoapHttpRequest:FLAutorelease([[__NAME__ alloc] init]) outputName:@#__OUTPUT__]

#define ZFForceCompilerToSetLevel(obj, level) FLPerformSelector1(obj, @selector(setLevel:), level)

//@interface ZFSoapHttpRequestFactory ()
//@property (readwrite, strong) ZFApiSoap* soapServer;
//@end

@implementation ZFSoapHttpRequestFactory

//@synthesize soapServer = _soapServer;
//
//- (id) init {
//    self = [super init];
//    if(self) {
//        self.soapServer = [ZFApiSoap apiSoap];
//    }
//    return self;
//}
//
//+ (id) soapWebService {
//    return FLAutorelease([[[self class] alloc] init]);
//}
//
//#if FL_MRC
//- (void) dealloc {
//    [_soapServer release];
//    [super dealloc];
//}
//#endif

+ (FLSoapHttpRequest*) convertToSoapHttpRequest:(id) operationDescriptor 
                                     outputName:(NSString*) outputName {

    static ZFApiSoap* s_soapServer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_soapServer = [[ZFApiSoap alloc] init];
    });


    ZFSoapHttpRequest* soapHttpRequest = [ZFSoapHttpRequest soapHttpRequestWithGeneratedObject:operationDescriptor 
                                                                                    serverInfo:s_soapServer];
    soapHttpRequest.responseDecoder = ^(id response) {
        return [response valueForKey:outputName];
    };
//    soapHttpRequest.requestContext = self.context.requestContext;
//    soapHttpRequest.userContext = self.context;
    return soapHttpRequest;
}

//+ (id) loginOperation {
//    return [ZFLoginHttpRequest loginHttpRequest:[self.context userLogin]];
//}

+ (FLHttpRequest*) loadPhotoSetHttpRequest:(NSNumber*) photoSetID
                                 level:(NSString*) level
                         includePhotos:(BOOL) includePhotos {

    FLSoapHttpRequest* httpRequest = ZFSoapHttpRequestFrom(ZFApiSoapLoadPhotoSet, LoadPhotoSetResult);
    [httpRequest.soapRequest setPhotoSetId:photoSetID];
    ZFForceCompilerToSetLevel(httpRequest.soapRequest, level);
    [httpRequest.soapRequest setIncludePhotosValue:includePhotos];
    return httpRequest;
}

+ (FLHttpRequest*) loadPhotoSetHttpRequest:(NSNumber*) photoSetID {
    return [self loadPhotoSetHttpRequest:photoSetID level:kZfInformatonLevelFull includePhotos:YES];
}

+ (FLHttpRequest*) challengeHttpRequest:(NSString*) loginName {
    FLSoapHttpRequest* httpRequest = ZFSoapHttpRequestFrom(ZFApiSoapGetChallenge, GetChallengeResult);
    [httpRequest.soapRequest setLoginName:loginName];
    return httpRequest;
}

+ (FLHttpRequest*) authenticateHttpRequest:(NSData*) challenge proof:(NSData*) proof  {
    FLSoapHttpRequest* authenticate = ZFSoapHttpRequestFrom(ZFApiSoapAuthenticate, AuthenticateResult);
    [authenticate.soapRequest setChallenge:challenge];
    [authenticate.soapRequest setProof:proof];
    return authenticate;
}

+ (FLHttpRequest*) loadPrivateProfileHttpRequest {
    return ZFSoapHttpRequestFrom(ZFApiSoapLoadPrivateProfile, LoadPrivateProfileResult);
}

+ (FLHttpRequest*) loadPublicProfileHttpRequest:(NSString*) userName {
    FLSoapHttpRequest* httpRequest = ZFSoapHttpRequestFrom(ZFApiSoapLoadPublicProfile, LoadPublicProfileResult);
    [httpRequest.soapRequest setLoginName:userName];
    return httpRequest;
}

+ (FLHttpRequest*) checkPrivilegeHttpRequest:(NSString*) loginName 
                            privilegeName:(NSString*) privilegeName {
    FLSoapHttpRequest* httpRequest = ZFSoapHttpRequestFrom(ZFApiSoapCheckPrivilege, CheckPrivilegeResult);
    [httpRequest.soapRequest setLoginName:loginName];
    [httpRequest.soapRequest setPrivilegeName:privilegeName];
    return httpRequest;
}

+ (FLHttpRequest*) authenticateVisitorHttpRequest {
    FLSoapHttpRequest* authHttpRequest = ZFSoapHttpRequestFrom(ZFApiSoapAuthenticateVisitor, AuthenticateVisitorResult);
    return authHttpRequest;
}

+ (FLHttpRequest*) loadPhotoHttpRequest:(NSNumber*) photoID
                   level:(NSString*) level {
    FLSoapHttpRequest* httpRequest = ZFSoapHttpRequestFrom(ZFApiSoapLoadPhoto, LoadPhotoResult);
    [httpRequest.soapRequest setPhotoId:photoID];
    
    ZFForceCompilerToSetLevel(httpRequest.soapRequest, level);
    
    return httpRequest;
}

+ (FLHttpRequest*) movePhotoHttpRequest:(ZFPhoto*) photo
             fromPhotoSet:(ZFPhotoSet*) fromPhotoSet
               toPhotoSet:(ZFPhotoSet*) toPhotoSet {
    FLSoapHttpRequest* httpRequest = ZFSoapHttpRequestFrom(ZFApiSoapMovePhoto, MovePhotoResult);
    [httpRequest.soapRequest setSrcSetId:fromPhotoSet.Id];
    [httpRequest.soapRequest setPhotoId:photo.Id];
    [httpRequest.soapRequest setDestSetId:toPhotoSet.Id];
    [httpRequest.soapRequest setIndexValue:toPhotoSet.PhotoCountValue];
    return httpRequest;
}

+ (FLHttpRequest*) addPhotoToCollectionHttpRequest:(ZFPhoto*) photo
                          collection:(ZFPhotoSet*) toCollection {
    FLSoapHttpRequest* httpRequest = ZFSoapHttpRequestFrom(ZFApiSoapCollectionAddPhoto, CollectionAddPhotoResult);
    [httpRequest.soapRequest setCollectionId:toCollection.Id];
    [httpRequest.soapRequest setPhotoId:photo.Id];
    return httpRequest;
}

+ (FLHttpRequest*) loadGroupHierarchyHttpRequest:(NSString*) loginName {
    FLSoapHttpRequest* httpRequest = ZFSoapHttpRequestFrom(ZFApiSoapLoadGroupHierarchy, LoadGroupHierarchyResult);
    [httpRequest.soapRequest setLoginName:loginName];
    return httpRequest;
}

+ (FLHttpRequest*) loadGroupHttpRequest:(NSNumber*) groupID
                    level:(NSString*) level
          includeChildren:(BOOL) includeChildren {

    FLSoapHttpRequest* httpRequest = ZFSoapHttpRequestFrom(ZFApiSoapLoadGroup, LoadGroupResult);
    [httpRequest.soapRequest setGroupId:groupID];
    ZFForceCompilerToSetLevel(httpRequest.soapRequest, level);

    [httpRequest.soapRequest setIncludeChildrenValue:YES];
    return httpRequest;
}
@end

