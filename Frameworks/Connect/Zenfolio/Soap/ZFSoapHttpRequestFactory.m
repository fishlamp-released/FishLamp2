//
//  ZFSoapHttpRequestFactory.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFSoapHttpRequestFactory.h"
#import "ZFSoapHttpRequest.h"
#import "ZFApi1_6All.h"
#import "FLCoreTypes.h"
#import "FLSoapObjectBuilder.h"

#define ZFSoapHttpRequestFrom(__REQUEST_OBJECT_NAME__, __RESULT_OBJECT_NAME__, __RETURNED_OBJECT_NAME__) \
    [ZFSoapHttpRequestFactory soapHttpRequest:FLAutorelease([[__REQUEST_OBJECT_NAME__ alloc] init]) \
                                              element:[FLObjectDescriber objectDescriberForClass:[__RETURNED_OBJECT_NAME__ class] withObjectName:__RESULT_OBJECT_NAME__]]

@implementation ZFLoadPhotoSet (NSObject)
- (void) setRequestedResponseLevel:(NSString*) level {
    [self setLevel:level];
}
@end
@implementation ZFLoadPhoto (NSObject)
- (void) setRequestedResponseLevel:(NSString*) level {
    [self setLevel:level];
}
@end
@implementation ZFLoadGroup (NSObject)
- (void) setRequestedResponseLevel:(NSString*) level {
    [self setLevel:level];
}
@end

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

+ (FLResult) zenfolioResultFromSoapResponse:(FLParsedItem*) parsedSoap 
                                    element:(FLObjectDescriber*) element {
    FLAssertNotNil(parsedSoap);
    FLAssertNotNil(element);
    
    FLParsedItem* objectXML = [parsedSoap findElementWithName:element.objectName maxDepth:2];
    FLConfirmNotNil(objectXML);

#if 0    
    FLLog(@"element: %@", [element description]);
#endif
     
    id zenfolioObject = [[FLSoapObjectBuilder instance] objectFromXML:objectXML withObjectType:element];

    FLConfirmNotNilWithComment(zenfolioObject, @"object not inflated for type: %@", [element description]);
//    FLAssertIsClass(zenfolioObject, element.objectClass);
    
    return zenfolioObject;
}


+ (FLSoapHttpRequest*) soapHttpRequest:(id) operationDescriptor 
                               element:(FLObjectDescriber*) element {

    static ZFApiSoap* s_soapServer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_soapServer = [[ZFApiSoap alloc] init];
    });

    ZFSoapHttpRequest* soapHttpRequest = [ZFSoapHttpRequest soapHttpRequestWithGeneratedObject:operationDescriptor 
                                                                                    serverInfo:s_soapServer];
    
    soapHttpRequest.handleSoapResponseBlock = (FLResult) ^(FLParsedItem* item) {
        return [self zenfolioResultFromSoapResponse:item element:element];
    };
    
    
    return soapHttpRequest;
}


+ (FLHttpRequest*) loadPhotoSetHttpRequest:(NSNumber*) photoSetID
                                 level:(NSString*) level
                         includePhotos:(BOOL) includePhotos {

    FLSoapHttpRequest* httpRequest = ZFSoapHttpRequestFrom(ZFApiSoapLoadPhotoSet, @"LoadPhotoSetResult",  ZFPhotoSet);
    [httpRequest.soapInput setPhotoSetId:photoSetID];
    [httpRequest.soapInput setRequestedResponseLevel:level];
    [httpRequest.soapInput setIncludePhotosValue:includePhotos];
    return httpRequest;
}

+ (FLHttpRequest*) loadPhotoSetHttpRequest:(NSNumber*) photoSetID {
    return [self loadPhotoSetHttpRequest:photoSetID level:kZenfolioInformatonLevelFull includePhotos:YES];
}

+ (FLHttpRequest*) challengeHttpRequest:(NSString*) loginName {
    FLSoapHttpRequest* httpRequest = ZFSoapHttpRequestFrom(ZFApiSoapGetChallenge, @"GetChallengeResult", ZFAuthChallenge);
    [httpRequest.soapInput setLoginName:loginName];
    return httpRequest;
}

+ (FLHttpRequest*) authenticateRequest:(NSData*) challenge proof:(NSData*) proof  {
    FLSoapHttpRequest* authenticate = ZFSoapHttpRequestFrom(ZFApiSoapAuthenticate, @"AuthenticateResult", NSString);
    [authenticate.soapInput setChallenge:challenge];
    [authenticate.soapInput setProof:proof];
    return authenticate;
}

+ (FLHttpRequest*) loadPrivateProfileHttpRequest {
    return ZFSoapHttpRequestFrom(ZFApiSoapLoadPrivateProfile, @"LoadPrivateProfileResult", ZFUser);
}

+ (FLHttpRequest*) loadPublicProfileHttpRequest:(NSString*) userName {
    FLSoapHttpRequest* httpRequest = ZFSoapHttpRequestFrom(ZFApiSoapLoadPublicProfile,  @"LoadPublicProfileResult", ZFUser);
    [httpRequest.soapInput setLoginName:userName];
    return httpRequest;
}

+ (FLHttpRequest*) checkPrivilegeHttpRequest:(NSString*) loginName 
                            privilegeName:(NSString*) privilegeName {
    FLSoapHttpRequest* httpRequest = ZFSoapHttpRequestFrom(ZFApiSoapCheckPrivilege,  @"CheckPrivilegeResult", FLBoolNumber);
    [httpRequest.soapInput setLoginName:loginName];
    [httpRequest.soapInput setPrivilegeName:privilegeName];
    return httpRequest;
}

+ (FLHttpRequest*) authenticateVisitorHttpRequest {
    FLSoapHttpRequest* authHttpRequest = ZFSoapHttpRequestFrom(ZFApiSoapAuthenticateVisitor,  @"AuthenticateVisitorResult", NSString);
    return authHttpRequest;
}

+ (FLHttpRequest*) loadPhotoHttpRequest:(NSNumber*) photoID
                   level:(NSString*) level {
    FLSoapHttpRequest* httpRequest = ZFSoapHttpRequestFrom(ZFApiSoapLoadPhoto, @"LoadPhotoResult", ZFPhoto);
    [httpRequest.soapInput setPhotoId:photoID];
    [httpRequest.soapInput setRequestedResponseLevel:level];
    return httpRequest;
}

+ (FLHttpRequest*) movePhotoHttpRequest:(ZFPhoto*) photo
             fromPhotoSet:(ZFPhotoSet*) fromPhotoSet
               toPhotoSet:(ZFPhotoSet*) toPhotoSet {
    FLSoapHttpRequest* httpRequest = ZFSoapHttpRequestFrom(ZFApiSoapMovePhoto, @"MovePhotoResult", NSString);
    [httpRequest.soapInput setSrcSetId:fromPhotoSet.Id];
    [httpRequest.soapInput setPhotoId:photo.Id];
    [httpRequest.soapInput setDestSetId:toPhotoSet.Id];
    [httpRequest.soapInput setIndexValue:toPhotoSet.PhotoCountValue];
    return httpRequest;
}

+ (FLHttpRequest*) addPhotoToCollectionHttpRequest:(ZFPhoto*) photo
                          collection:(ZFPhotoSet*) toCollection {
    FLSoapHttpRequest* httpRequest = ZFSoapHttpRequestFrom(ZFApiSoapCollectionAddPhoto, @"CollectionAddPhotoResult", NSString);
    [httpRequest.soapInput setCollectionId:toCollection.Id];
    [httpRequest.soapInput setPhotoId:photo.Id];
    return httpRequest;
}

+ (FLHttpRequest*) loadGroupHierarchyHttpRequest:(NSString*) loginName {
    FLSoapHttpRequest* httpRequest = ZFSoapHttpRequestFrom(ZFApiSoapLoadGroupHierarchy, @"LoadGroupHierarchyResult", ZFGroup);
    [httpRequest.soapInput setLoginName:loginName];
    return httpRequest;
}

+ (FLHttpRequest*) loadGroupHttpRequest:(NSNumber*) groupID
                    level:(NSString*) level
          includeChildren:(BOOL) includeChildren {

    FLSoapHttpRequest* httpRequest = ZFSoapHttpRequestFrom(ZFApiSoapLoadGroup, @"LoadGroupResult", ZFGroup);
    [httpRequest.soapInput setGroupId:groupID];
    [httpRequest.soapInput setRequestedResponseLevel:level];

    [httpRequest.soapInput setIncludeChildrenValue:YES];
    return httpRequest;
}
@end

