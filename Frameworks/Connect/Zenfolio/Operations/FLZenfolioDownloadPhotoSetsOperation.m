//
//  FLZenfolioDownloadPhotoSetsOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/8/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioDownloadPhotoSetsOperation.h"
#import "FLZenfolioWebApi.h"

@interface FLZenfolioDownloadPhotoSetsOperation ()
@property (readwrite, strong) FLZenfolioGroup* group;
@end

@implementation FLZenfolioDownloadPhotoSetsOperation

@synthesize group = _group;

#if FL_MRC
- (void) dealloc {
    [_group release];
    [super dealloc];
}
#endif

- (id) initWithGroup:(FLZenfolioGroup*) group {
    self = [super init];
    if(self) {
        _group = [group copy];
    }   

    return self;
}

+ (id) downloadPhotoSetsWithGroup:(FLZenfolioGroup*) group {
    return FLAutorelease([[[self class] alloc] initWithGroup:group]);
}

- (void) runForGroup:(FLZenfolioGroup*) group inContext:(id) context withObserver:(id) observer {
    NSArray* elements = FLAutorelease([group.Elements copy]);
    
    for(FLZenfolioGroupElement* element in elements) {
        if(element.isGroupElement) {
            [self runForGroup:(FLZenfolioGroup*) element inContext:context withObserver:observer];
        }
        else {
            FLHttpRequest* request = [FLZenfolioHttpRequest loadPhotoSetHttpRequest:element.Id level:kZenfolioInformatonLevelFull includePhotos:NO];
            
            FLZenfolioPhotoSet* set = [context runWorker:request withObserver:observer];
            FLAssertNotNil_(set);
            [group replaceGroupElement:set];
            
            [observer postObservation:@selector(photoSetDownloader:didDownloadPhotoSet:) withObject:self withObject:set];
        }
        
        [self abortIfNeeded];
    }
}

- (FLResult) runOperationInContext:(id) context withObserver:(id) observer {
    [self runForGroup:_group inContext:context withObserver:observer];
    return _group;
}


@end
