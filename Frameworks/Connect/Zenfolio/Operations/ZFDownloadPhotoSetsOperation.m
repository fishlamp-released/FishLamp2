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
@property (readwrite, strong) ZFGroup* group;
@end

@implementation ZFDownloadPhotoSetsOperation

@synthesize group = _group;

#if FL_MRC
- (void) dealloc {
    [_group release];
    [super dealloc];
}
#endif

- (id) initWithGroup:(ZFGroup*) group  objectStorage:(id<FLObjectStorage>) objectStorage{
    self = [super initWithObjectStorage:objectStorage];
    if(self) {
        FLAssertNotNil(objectStorage);

        _group = [group copy];
    }   

    return self;
}

+ (id) downloadPhotoSetsWithGroup:(ZFGroup*) group objectStorage:(id<FLObjectStorage>) objectStorage {
    return FLAutorelease([[[self class] alloc] initWithGroup:group objectStorage:objectStorage]);
}

- (void) runForGroup:(ZFGroup*) group inContext:(id) context withObserver:(id) observer {
    NSArray* elements = FLAutorelease([group.Elements copy]);
    
    for(ZFGroupElement* element in elements) {
        if(element.isGroupElement) {
            [self runForGroup:(ZFGroup*) element inContext:context withObserver:observer];
        }
        else {
            FLHttpRequest* request = [ZFHttpRequest loadPhotoSetHttpRequest:element.Id level:kZenfolioInformatonLevelFull includePhotos:NO];
            
            ZFPhotoSet* set = FLThrowIfError([context runWorker:request withObserver:observer]);
            FLAssertNotNil(set);
            [self.objectStorage writeObject:set];
            
            [self sendMessage:@selector(photoSetDownloader:didDownloadPhotoSet:) toListener:observer withObject:set];
        }
        
        [self abortIfNeeded];
    }
}

- (FLResult) runOperationInContext:(id) context withObserver:(id) observer {
    [self runForGroup:_group inContext:context withObserver:observer];
    return _group;
}


@end
