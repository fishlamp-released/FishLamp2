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
        self.group = group;
    }   

    return self;
}

+ (id) downloadPhotoSetsWithGroup:(FLZenfolioGroup*) group {
    return FLAutorelease([[[self class] alloc] initWithGroup:group]);
}

- (void) runForGroup:(FLZenfolioGroup*) group {
    NSMutableArray* newList = [NSMutableArray array];
    for(FLZenfolioGroupElement* element in group.Elements) {
        if(element.isGroupElement) {
            [self runForGroup:(FLZenfolioGroup*) element];
            [newList addObject:element];
        }
        else {
            FLHttpRequest* request = [FLZenfolioHttpRequest loadPhotoSetHttpRequest:element.Id level:kZenfolioInformatonLevelFull includePhotos:NO];
            
            
            FLZenfolioPhotoSet* set = [self sendHttpRequest:request];
            FLAssertNotNil_(set);
            
            [newList addObject:set];
            
//            [self postObservation:@selector(photoSetDownloader:didDownloadPhotoSet:) withObject:set];
        }
    }
    group.Elements = newList;
}

- (FLResult) runOperation {
    [self runForGroup:_group];
    return _group;
}


@end
