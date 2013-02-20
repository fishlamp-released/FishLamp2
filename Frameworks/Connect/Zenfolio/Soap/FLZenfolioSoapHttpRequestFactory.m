//
//  FLZenfolioSoapHttpRequestFactory.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioSoapHttpRequestFactory.h"
//#import "NSError+FLExtras.h"
#import "FLZenfolioSoapHttpRequest.h"
//#import "FLUserLoginService.h"

//#import "FLNetworkServerContext.h"

#import "FLZenfolioApi1_6All.h"

#define FLZenfolioSoapHttpRequestFrom(__NAME__, __OUTPUT__) \
    [FLZenfolioSoapHttpRequestFactory convertToSoapHttpRequest:FLAutorelease([[__NAME__ alloc] init]) outputName:@#__OUTPUT__]

#define FLZenfolioForceCompilerToSetLevel(obj, level) FLPerformSelector1(obj, @selector(setLevel:), level)

//@interface FLZenfolioSoapHttpRequestFactory ()
//@property (readwrite, strong) FLZenfolioApiSoap* soapServer;
//@end

@implementation FLZenfolioSoapHttpRequestFactory

//@synthesize soapServer = _soapServer;
//
//- (id) init {
//    self = [super init];
//    if(self) {
//        self.soapServer = [FLZenfolioApiSoap apiSoap];
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

    static FLZenfolioApiSoap* s_soapServer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_soapServer = [[FLZenfolioApiSoap alloc] init];
    });


    FLZenfolioSoapHttpRequest* soapHttpRequest = [FLZenfolioSoapHttpRequest soapHttpRequestWithGeneratedObject:operationDescriptor 
                                                                                    serverInfo:s_soapServer];
    soapHttpRequest.responseDecoder = ^(id response) {
        return [response valueForKey:outputName];
    };

    return soapHttpRequest;
}


+ (FLHttpRequest*) loadPhotoSetHttpRequest:(NSNumber*) photoSetID
                                 level:(NSString*) level
                         includePhotos:(BOOL) includePhotos {

    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapLoadPhotoSet, LoadPhotoSetResult);
    [httpRequest.soapRequest setPhotoSetId:photoSetID];
    FLZenfolioForceCompilerToSetLevel(httpRequest.soapRequest, level);
    [httpRequest.soapRequest setIncludePhotosValue:includePhotos];
    return httpRequest;
}

+ (FLHttpRequest*) loadPhotoSetHttpRequest:(NSNumber*) photoSetID {
    return [self loadPhotoSetHttpRequest:photoSetID level:kZenfolioInformatonLevelFull includePhotos:YES];
}

+ (FLHttpRequest*) challengeHttpRequest:(NSString*) loginName {
    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapGetChallenge, GetChallengeResult);
    [httpRequest.soapRequest setLoginName:loginName];
    return httpRequest;
}

+ (FLHttpRequest*) authenticateRequest:(NSData*) challenge proof:(NSData*) proof  {
    FLSoapHttpRequest* authenticate = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapAuthenticate, AuthenticateResult);
    [authenticate.soapRequest setChallenge:challenge];
    [authenticate.soapRequest setProof:proof];
    return authenticate;
}

+ (FLHttpRequest*) loadPrivateProfileHttpRequest {
    return FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapLoadPrivateProfile, LoadPrivateProfileResult);
}

+ (FLHttpRequest*) loadPublicProfileHttpRequest:(NSString*) userName {
    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapLoadPublicProfile, LoadPublicProfileResult);
    [httpRequest.soapRequest setLoginName:userName];
    return httpRequest;
}

+ (FLHttpRequest*) checkPrivilegeHttpRequest:(NSString*) loginName 
                            privilegeName:(NSString*) privilegeName {
    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapCheckPrivilege, CheckPrivilegeResult);
    [httpRequest.soapRequest setLoginName:loginName];
    [httpRequest.soapRequest setPrivilegeName:privilegeName];
    return httpRequest;
}

+ (FLHttpRequest*) authenticateVisitorHttpRequest {
    FLSoapHttpRequest* authHttpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapAuthenticateVisitor, AuthenticateVisitorResult);
    return authHttpRequest;
}

+ (FLHttpRequest*) loadPhotoHttpRequest:(NSNumber*) photoID
                   level:(NSString*) level {
    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapLoadPhoto, LoadPhotoResult);
    [httpRequest.soapRequest setPhotoId:photoID];
    
    FLZenfolioForceCompilerToSetLevel(httpRequest.soapRequest, level);
    
    return httpRequest;
}

+ (FLHttpRequest*) movePhotoHttpRequest:(FLZenfolioPhoto*) photo
             fromPhotoSet:(FLZenfolioPhotoSet*) fromPhotoSet
               toPhotoSet:(FLZenfolioPhotoSet*) toPhotoSet {
    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapMovePhoto, MovePhotoResult);
    [httpRequest.soapRequest setSrcSetId:fromPhotoSet.Id];
    [httpRequest.soapRequest setPhotoId:photo.Id];
    [httpRequest.soapRequest setDestSetId:toPhotoSet.Id];
    [httpRequest.soapRequest setIndexValue:toPhotoSet.PhotoCountValue];
    return httpRequest;
}

+ (FLHttpRequest*) addPhotoToCollectionHttpRequest:(FLZenfolioPhoto*) photo
                          collection:(FLZenfolioPhotoSet*) toCollection {
    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapCollectionAddPhoto, CollectionAddPhotoResult);
    [httpRequest.soapRequest setCollectionId:toCollection.Id];
    [httpRequest.soapRequest setPhotoId:photo.Id];
    return httpRequest;
}

+ (FLHttpRequest*) loadGroupHierarchyHttpRequest:(NSString*) loginName {
    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapLoadGroupHierarchy, LoadGroupHierarchyResult);
    [httpRequest.soapRequest setLoginName:loginName];
    return httpRequest;
}

+ (FLHttpRequest*) loadGroupHttpRequest:(NSNumber*) groupID
                    level:(NSString*) level
          includeChildren:(BOOL) includeChildren {

    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapLoadGroup, LoadGroupResult);
    [httpRequest.soapRequest setGroupId:groupID];
    FLZenfolioForceCompilerToSetLevel(httpRequest.soapRequest, level);

    [httpRequest.soapRequest setIncludeChildrenValue:YES];
    return httpRequest;
}
@end

