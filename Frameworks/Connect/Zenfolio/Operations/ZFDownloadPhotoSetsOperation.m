//
//  ZFDownloadPhotoSetsOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/8/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFDownloadPhotoSetsOperation.h"
#import "ZFWebApi.h"

@interface ZFDownloadPhotoSetsOperation ()
@property (readwrite, strong, nonatomic) ZFGroup* group;
@end

@implementation ZFDownloadPhotoSetsOperation

@synthesize group = _group;
@synthesize downloadedPhotoSetSelector = _downloadedPhotoSetSelector;

#if FL_MRC
- (void) dealloc {
    [_group release];
    [super dealloc];
}
#endif

- (id) initWithGroup:(ZFGroup*) group {
    self = [super init];
    if(self) {
        self.group = FLCopyWithAutorelease(group);
        self.downloadedPhotoSetSelector = @selector(photoSetDownloader:didDownloadPhotoSet:);
    }   

    return self;
}

+ (id) downloadPhotoSetsWithGroup:(ZFGroup*) group  {
    return FLAutorelease([[[self class] alloc] initWithGroup:group]);
}

- (void) runForGroup:(ZFGroup*) group {

    NSArray* elements = FLCopyWithAutorelease(group.Elements);
    for(ZFGroupElement* element in elements) {
        if(element.isGroupElement) {
            [self runForGroup:(ZFGroup*) element];
        }
        else {
            FLHttpRequest* request = [ZFHttpRequestFactory loadPhotoSetHttpRequest:element.Id level:kZenfolioInformatonLevelFull includePhotos:NO];

            FLResult set = [self runChildSynchronously:request];
            FLThrowIfError(set);
            
            FLAssertNotNil(set);
            
            [self.objectStorage writeObject:set];
            [group replaceElement:set];
            
            [self sendObservation:@selector(photoSetDownloader:didDownloadPhotoSet:) withObject:set];
        }
        
        [self abortIfNeeded];
    }
}

- (FLResult) performSynchronously {
    FLAssertNotNil(self.objectStorage);
    [self runForGroup:self.group];
    return self.group;
}


@end
