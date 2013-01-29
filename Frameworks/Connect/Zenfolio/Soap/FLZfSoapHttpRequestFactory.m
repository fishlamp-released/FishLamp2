//
//  FLZfSoapHttpRequestFactory.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZfSoapHttpRequestFactory.h"
//#import "NSError+FLExtras.h"
#import "FLZfSoapHttpRequest.h"
//#import "FLUserLoginService.h"

//#import "FLNetworkServerContext.h"

#import "FLZfApi1_6All.h"

#define FLZfSoapHttpRequestFrom(__NAME__, __OUTPUT__) \
    [FLZfSoapHttpRequestFactory convertToSoapHttpRequest:FLAutorelease([[__NAME__ alloc] init]) outputName:@#__OUTPUT__]

#define FLZfForceCompilerToSetLevel(obj, level) FLPerformSelector1(obj, @selector(setLevel:), level)

//@interface FLZfSoapHttpRequestFactory ()
//@property (readwrite, strong) FLZfApiSoap* soapServer;
//@end

@implementation FLZfSoapHttpRequestFactory

//@synthesize soapServer = _soapServer;
//
//- (id) init {
//    self = [super init];
//    if(self) {
//        self.soapServer = [FLZfApiSoap apiSoap];
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

    static FLZfApiSoap* s_soapServer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_soapServer = [[FLZfApiSoap alloc] init];
    });


    FLZfSoapHttpRequest* soapHttpRequest = [FLZfSoapHttpRequest soapHttpRequestWithGeneratedObject:operationDescriptor 
                                                                                    serverInfo:s_soapServer];
    soapHttpRequest.responseDecoder = ^(id response) {
        return [response valueForKey:outputName];
    };
//    soapHttpRequest.requestContext = self.context.requestContext;
//    soapHttpRequest.userContext = self.context;
    return soapHttpRequest;
}

//+ (id) loginOperation {
//    return [FLZfLoginHttpRequest loginHttpRequest:[self.context userLogin]];
//}

+ (FLHttpRequest*) loadPhotoSetHttpRequest:(NSNumber*) photoSetID
                                 level:(NSString*) level
                         includePhotos:(BOOL) includePhotos {

    FLSoapHttpRequest* httpRequest = FLZfSoapHttpRequestFrom(FLZfApiSoapLoadPhotoSet, LoadPhotoSetResult);
    [httpRequest.soapRequest setPhotoSetId:photoSetID];
    FLZfForceCompilerToSetLevel(httpRequest.soapRequest, level);
    [httpRequest.soapRequest setIncludePhotosValue:includePhotos];
    return httpRequest;
}

+ (FLHttpRequest*) loadPhotoSetHttpRequest:(NSNumber*) photoSetID {
    return [self loadPhotoSetHttpRequest:photoSetID level:kZfInformatonLevelFull includePhotos:YES];
}

+ (FLHttpRequest*) challengeHttpRequest:(NSString*) loginName {
    FLSoapHttpRequest* httpRequest = FLZfSoapHttpRequestFrom(FLZfApiSoapGetChallenge, GetChallengeResult);
    [httpRequest.soapRequest setLoginName:loginName];
    return httpRequest;
}

+ (FLHttpRequest*) authenticateHttpRequest:(NSData*) challenge proof:(NSData*) proof  {
    FLSoapHttpRequest* authenticate = FLZfSoapHttpRequestFrom(FLZfApiSoapAuthenticate, AuthenticateResult);
    [authenticate.soapRequest setChallenge:challenge];
    [authenticate.soapRequest setProof:proof];
    return authenticate;
}

+ (FLHttpRequest*) loadPrivateProfileHttpRequest {
    return FLZfSoapHttpRequestFrom(FLZfApiSoapLoadPrivateProfile, LoadPrivateProfileResult);
}

+ (FLHttpRequest*) loadPublicProfileHttpRequest:(NSString*) userName {
    FLSoapHttpRequest* httpRequest = FLZfSoapHttpRequestFrom(FLZfApiSoapLoadPublicProfile, LoadPublicProfileResult);
    [httpRequest.soapRequest setLoginName:userName];
    return httpRequest;
}

+ (FLHttpRequest*) checkPrivilegeHttpRequest:(NSString*) loginName 
                            privilegeName:(NSString*) privilegeName {
    FLSoapHttpRequest* httpRequest = FLZfSoapHttpRequestFrom(FLZfApiSoapCheckPrivilege, CheckPrivilegeResult);
    [httpRequest.soapRequest setLoginName:loginName];
    [httpRequest.soapRequest setPrivilegeName:privilegeName];
    return httpRequest;
}

+ (FLHttpRequest*) authenticateVisitorHttpRequest {
    FLSoapHttpRequest* authHttpRequest = FLZfSoapHttpRequestFrom(FLZfApiSoapAuthenticateVisitor, AuthenticateVisitorResult);
    return authHttpRequest;
}

+ (FLHttpRequest*) loadPhotoHttpRequest:(NSNumber*) photoID
                   level:(NSString*) level {
    FLSoapHttpRequest* httpRequest = FLZfSoapHttpRequestFrom(FLZfApiSoapLoadPhoto, LoadPhotoResult);
    [httpRequest.soapRequest setPhotoId:photoID];
    
    FLZfForceCompilerToSetLevel(httpRequest.soapRequest, level);
    
    return httpRequest;
}

+ (FLHttpRequest*) movePhotoHttpRequest:(FLZfPhoto*) photo
             fromPhotoSet:(FLZfPhotoSet*) fromPhotoSet
               toPhotoSet:(FLZfPhotoSet*) toPhotoSet {
    FLSoapHttpRequest* httpRequest = FLZfSoapHttpRequestFrom(FLZfApiSoapMovePhoto, MovePhotoResult);
    [httpRequest.soapRequest setSrcSetId:fromPhotoSet.Id];
    [httpRequest.soapRequest setPhotoId:photo.Id];
    [httpRequest.soapRequest setDestSetId:toPhotoSet.Id];
    [httpRequest.soapRequest setIndexValue:toPhotoSet.PhotoCountValue];
    return httpRequest;
}

+ (FLHttpRequest*) addPhotoToCollectionHttpRequest:(FLZfPhoto*) photo
                          collection:(FLZfPhotoSet*) toCollection {
    FLSoapHttpRequest* httpRequest = FLZfSoapHttpRequestFrom(FLZfApiSoapCollectionAddPhoto, CollectionAddPhotoResult);
    [httpRequest.soapRequest setCollectionId:toCollection.Id];
    [httpRequest.soapRequest setPhotoId:photo.Id];
    return httpRequest;
}

+ (FLHttpRequest*) loadGroupHierarchyHttpRequest:(NSString*) loginName {
    FLSoapHttpRequest* httpRequest = FLZfSoapHttpRequestFrom(FLZfApiSoapLoadGroupHierarchy, LoadGroupHierarchyResult);
    [httpRequest.soapRequest setLoginName:loginName];
    return httpRequest;
}

+ (FLHttpRequest*) loadGroupHttpRequest:(NSNumber*) groupID
                    level:(NSString*) level
          includeChildren:(BOOL) includeChildren {

    FLSoapHttpRequest* httpRequest = FLZfSoapHttpRequestFrom(FLZfApiSoapLoadGroup, LoadGroupResult);
    [httpRequest.soapRequest setGroupId:groupID];
    FLZfForceCompilerToSetLevel(httpRequest.soapRequest, level);

    [httpRequest.soapRequest setIncludeChildrenValue:YES];
    return httpRequest;
}
@end

