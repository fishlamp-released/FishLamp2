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

#define FLZenfolioSoapHttpRequestFrom(__NAME__, __PATH__, __OBJ__, __CLASS__) \
    [FLZenfolioSoapHttpRequestFactory soapHttpRequest:FLAutorelease([[__NAME__ alloc] init]) parentPath:@"Envelope/Body/"\
        __PATH__ \
        element:[FLPropertyType propertyType:__OBJ__ propertyClass:[__CLASS__ class]]]

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
                               parentPath:(NSString*) parentPath 
                               element:(FLPropertyType*) element {
    FLAssertNotNil_(parsedSoap);
    FLAssertNotNil_(parentPath);
    FLAssertNotNil_(element);
    
    FLParsedItem* objectXML = [parsedSoap elementAtPath:parentPath];
    FLConfirmNotNil_(objectXML);
    
    FLLog(@"parent: %@, element: %@", parentPath, [element description]);
     
    id zenfolioObject = [[FLSoapObjectBuilder instance] objectFromXML:objectXML withObjectType:element];

    FLConfirmNotNil_v(zenfolioObject, @"object not inflated for type: %@", [element description]);
    FLAssertIsClass(zenfolioObject, element.propertyClass);
    
    return zenfolioObject;
}


+ (FLSoapHttpRequest*) soapHttpRequest:(id) operationDescriptor 
                            parentPath:(NSString*) parentPath 
                               element:(FLPropertyType*) element {

    static FLZenfolioApiSoap* s_soapServer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_soapServer = [[FLZenfolioApiSoap alloc] init];
    });

    FLZenfolioSoapHttpRequest* soapHttpRequest = [FLZenfolioSoapHttpRequest soapHttpRequestWithGeneratedObject:operationDescriptor 
                                                                                    serverInfo:s_soapServer];
    
    soapHttpRequest.handleSoapResponseBlock = (FLResult) ^(FLParsedItem* item) {
        return [self zenfolioResultFromSoapResponse:item parentPath:parentPath element:element];
    };
    
    
    return soapHttpRequest;
}


+ (FLHttpRequest*) loadPhotoSetHttpRequest:(NSNumber*) photoSetID
                                 level:(NSString*) level
                         includePhotos:(BOOL) includePhotos {

    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapLoadPhotoSet, @"LoadPhotoSetResponse", @"LoadPhotoSetResult",  FLZenfolioPhotoSet);
    [httpRequest.soapInput setPhotoSetId:photoSetID];
    [httpRequest.soapInput setRequestedResponseLevel:level];
    [httpRequest.soapInput setIncludePhotosValue:includePhotos];
    return httpRequest;
}

+ (FLHttpRequest*) loadPhotoSetHttpRequest:(NSNumber*) photoSetID {
    return [self loadPhotoSetHttpRequest:photoSetID level:kZenfolioInformatonLevelFull includePhotos:YES];
}

+ (FLHttpRequest*) challengeHttpRequest:(NSString*) loginName {
    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapGetChallenge, @"GetChallengeResponse", @"GetChallengeResult", FLZenfolioAuthChallenge);
    [httpRequest.soapInput setLoginName:loginName];
    return httpRequest;
}

+ (FLHttpRequest*) authenticateRequest:(NSData*) challenge proof:(NSData*) proof  {
    FLSoapHttpRequest* authenticate = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapAuthenticate, @"AuthenticateResponse", @"AuthenticateResult", NSString);
    [authenticate.soapInput setChallenge:challenge];
    [authenticate.soapInput setProof:proof];
    return authenticate;
}

+ (FLHttpRequest*) loadPrivateProfileHttpRequest {
    return FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapLoadPrivateProfile, @"LoadPrivateProfileResponse", @"LoadPrivateProfileResult", FLZenfolioUser);
}

+ (FLHttpRequest*) loadPublicProfileHttpRequest:(NSString*) userName {
    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapLoadPublicProfile, @"LoadPublicProfileResponse", @"LoadPublicProfileResult", FLZenfolioUser);
    [httpRequest.soapInput setLoginName:userName];
    return httpRequest;
}

+ (FLHttpRequest*) checkPrivilegeHttpRequest:(NSString*) loginName 
                            privilegeName:(NSString*) privilegeName {
    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapCheckPrivilege, @"CheckPrivilegeResponse", @"CheckPrivilegeResult", FLBoolNumber);
    [httpRequest.soapInput setLoginName:loginName];
    [httpRequest.soapInput setPrivilegeName:privilegeName];
    return httpRequest;
}

+ (FLHttpRequest*) authenticateVisitorHttpRequest {
    FLSoapHttpRequest* authHttpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapAuthenticateVisitor, @"AuthenticateVisitorResponse", @"AuthenticateVisitorResult", NSString);
    return authHttpRequest;
}

+ (FLHttpRequest*) loadPhotoHttpRequest:(NSNumber*) photoID
                   level:(NSString*) level {
    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapLoadPhoto, @"LoadPhotoResponse", @"LoadPhotoResult", FLZenfolioPhoto);
    [httpRequest.soapInput setPhotoId:photoID];
    [httpRequest.soapInput setRequestedResponseLevel:level];
    return httpRequest;
}

+ (FLHttpRequest*) movePhotoHttpRequest:(FLZenfolioPhoto*) photo
             fromPhotoSet:(FLZenfolioPhotoSet*) fromPhotoSet
               toPhotoSet:(FLZenfolioPhotoSet*) toPhotoSet {
    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapMovePhoto, "MovePhotoResponse", @"MovePhotoResult", NSString);
    [httpRequest.soapInput setSrcSetId:fromPhotoSet.Id];
    [httpRequest.soapInput setPhotoId:photo.Id];
    [httpRequest.soapInput setDestSetId:toPhotoSet.Id];
    [httpRequest.soapInput setIndexValue:toPhotoSet.PhotoCountValue];
    return httpRequest;
}

+ (FLHttpRequest*) addPhotoToCollectionHttpRequest:(FLZenfolioPhoto*) photo
                          collection:(FLZenfolioPhotoSet*) toCollection {
    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapCollectionAddPhoto, @"CollectionAddPhotoResponse", @"CollectionAddPhotoResult", NSString);
    [httpRequest.soapInput setCollectionId:toCollection.Id];
    [httpRequest.soapInput setPhotoId:photo.Id];
    return httpRequest;
}

+ (FLHttpRequest*) loadGroupHierarchyHttpRequest:(NSString*) loginName {
    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapLoadGroupHierarchy, @"LoadGroupHierarchyResponse", @"LoadGroupHierarchyResult", FLZenfolioGroup);
    [httpRequest.soapInput setLoginName:loginName];
    return httpRequest;
}

+ (FLHttpRequest*) loadGroupHttpRequest:(NSNumber*) groupID
                    level:(NSString*) level
          includeChildren:(BOOL) includeChildren {

    FLSoapHttpRequest* httpRequest = FLZenfolioSoapHttpRequestFrom(FLZenfolioApiSoapLoadGroup, @"LoadGroupResponse", @"LoadGroupResult", FLZenfolioGroup);
    [httpRequest.soapInput setGroupId:groupID];
    [httpRequest.soapInput setRequestedResponseLevel:level];

    [httpRequest.soapInput setIncludeChildrenValue:YES];
    return httpRequest;
}
@end

