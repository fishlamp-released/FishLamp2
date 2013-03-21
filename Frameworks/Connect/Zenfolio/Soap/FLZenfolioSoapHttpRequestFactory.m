//
//  FLZenfolioSoapHttpRequestFactory.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioSoapHttpRequestFactory.h"
#import "FLZenfolioSoapHttpRequest.h"
#import "FLZenfolioApi1_6All.h"
#import "FLCoreTypes.h"
#import "FLSoapObjectBuilder.h"

#define FLZenfolioSoapHttpRequestFrom(__REQUEST_OBJECT_NAME__, __RESULT_OBJECT_NAME__, __RETURNED_OBJECT_NAME__) \
    [FLZenfolioSoapHttpRequestFactory soapHttpRequest:FLAutorelease([[__REQUEST_OBJECT_NAME__ alloc] init]) \
                                              element:[FLObjectDescriber objectDescriber:__RESULT_OBJECT_NAME__ \
                                                                               objectClass:[__RETURNED_OBJECT_NAME__ class]]]

@implementation FLZenfolioLoadPhotoSet (NSObject)
- (void) setRequestedResponseLevel:(NSString*) level {
    [self setLevel:level];
}
@end
@implementation FLZenfolioLoadPhoto (NSObject)
- (void) setRequestedResponseLevel:(NSString*) level {
    [self setLevel:level];
}
@end
@implementation FLZenfolioLoadGroup (NSObject)
- (void) setRequestedResponseLevel:(NSString*) level {
    [self setLevel:level];
}
@end

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

    static FLZenfolioApiSoap* s_soapServer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_soapServer = [[FLZenfolioApiSoap alloc] init];
    });

    FLZenfolioSoapHttpRequest* soapHttpRequest = [FLZenfolioSoapHttpRequest soapHttpRequestWithGeneratedObject:operationDescriptor 
                                                                                    serverInfo:s_soapServer];
    
    soapHttpRequest.handleSoapResponseBlock = (FLResult) ^(FLParsedItem* item) {
        return [self zenfolioResultFromSoapResponse:item element:element];
    };
    
    
    return soapHttpRequest;
}


+ (FLHttpRequest*) loadPhotoSetHttpRequest:(NSNumber*) photoSetID
                                 level:(NSString*) level
                         includePhotos:(BOOL) includePhotos {

    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapLoadPhotoSet, @"LoadPhotoSetResult",  FLZenfolioPhotoSet);
    [httpRequest.soapInput setPhotoSetId:photoSetID];
    [httpRequest.soapInput setRequestedResponseLevel:level];
    [httpRequest.soapInput setIncludePhotosValue:includePhotos];
    return httpRequest;
}

+ (FLHttpRequest*) loadPhotoSetHttpRequest:(NSNumber*) photoSetID {
    return [self loadPhotoSetHttpRequest:photoSetID level:kZenfolioInformatonLevelFull includePhotos:YES];
}

+ (FLHttpRequest*) challengeHttpRequest:(NSString*) loginName {
    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapGetChallenge, @"GetChallengeResult", FLZenfolioAuthChallenge);
    [httpRequest.soapInput setLoginName:loginName];
    return httpRequest;
}

+ (FLHttpRequest*) authenticateRequest:(NSData*) challenge proof:(NSData*) proof  {
    FLSoapHttpRequest* authenticate = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapAuthenticate, @"AuthenticateResult", NSString);
    [authenticate.soapInput setChallenge:challenge];
    [authenticate.soapInput setProof:proof];
    return authenticate;
}

+ (FLHttpRequest*) loadPrivateProfileHttpRequest {
    return FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapLoadPrivateProfile, @"LoadPrivateProfileResult", FLZenfolioUser);
}

+ (FLHttpRequest*) loadPublicProfileHttpRequest:(NSString*) userName {
    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapLoadPublicProfile,  @"LoadPublicProfileResult", FLZenfolioUser);
    [httpRequest.soapInput setLoginName:userName];
    return httpRequest;
}

+ (FLHttpRequest*) checkPrivilegeHttpRequest:(NSString*) loginName 
                            privilegeName:(NSString*) privilegeName {
    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapCheckPrivilege,  @"CheckPrivilegeResult", FLBoolNumber);
    [httpRequest.soapInput setLoginName:loginName];
    [httpRequest.soapInput setPrivilegeName:privilegeName];
    return httpRequest;
}

+ (FLHttpRequest*) authenticateVisitorHttpRequest {
    FLSoapHttpRequest* authHttpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapAuthenticateVisitor,  @"AuthenticateVisitorResult", NSString);
    return authHttpRequest;
}

+ (FLHttpRequest*) loadPhotoHttpRequest:(NSNumber*) photoID
                   level:(NSString*) level {
    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapLoadPhoto, @"LoadPhotoResult", FLZenfolioPhoto);
    [httpRequest.soapInput setPhotoId:photoID];
    [httpRequest.soapInput setRequestedResponseLevel:level];
    return httpRequest;
}

+ (FLHttpRequest*) movePhotoHttpRequest:(FLZenfolioPhoto*) photo
             fromPhotoSet:(FLZenfolioPhotoSet*) fromPhotoSet
               toPhotoSet:(FLZenfolioPhotoSet*) toPhotoSet {
    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapMovePhoto, @"MovePhotoResult", NSString);
    [httpRequest.soapInput setSrcSetId:fromPhotoSet.Id];
    [httpRequest.soapInput setPhotoId:photo.Id];
    [httpRequest.soapInput setDestSetId:toPhotoSet.Id];
    [httpRequest.soapInput setIndexValue:toPhotoSet.PhotoCountValue];
    return httpRequest;
}

+ (FLHttpRequest*) addPhotoToCollectionHttpRequest:(FLZenfolioPhoto*) photo
                          collection:(FLZenfolioPhotoSet*) toCollection {
    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapCollectionAddPhoto, @"CollectionAddPhotoResult", NSString);
    [httpRequest.soapInput setCollectionId:toCollection.Id];
    [httpRequest.soapInput setPhotoId:photo.Id];
    return httpRequest;
}

+ (FLHttpRequest*) loadGroupHierarchyHttpRequest:(NSString*) loginName {
    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapLoadGroupHierarchy, @"LoadGroupHierarchyResult", FLZenfolioGroup);
    [httpRequest.soapInput setLoginName:loginName];
    return httpRequest;
}

+ (FLHttpRequest*) loadGroupHttpRequest:(NSNumber*) groupID
                    level:(NSString*) level
          includeChildren:(BOOL) includeChildren {

    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapLoadGroup, @"LoadGroupResult", FLZenfolioGroup);
    [httpRequest.soapInput setGroupId:groupID];
    [httpRequest.soapInput setRequestedResponseLevel:level];

    [httpRequest.soapInput setIncludeChildrenValue:YES];
    return httpRequest;
}
@end

