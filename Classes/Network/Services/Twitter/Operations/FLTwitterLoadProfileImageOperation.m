//
//  FLTwitterLoadProfileImageOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/9/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLTwitterLoadProfileImageOperation.h"

#if IOS
#import "FLHttpImageDownloadNetworkResponseHandler.h"
#endif

#import "FLTwitterMgr.h"
#import "FLOperationCacheHandler.h"
#import "FLUserDataStorageService.h"

@implementation FLTwitterLoadProfileImageOperation

@synthesize imageSize = _imageSize;
@synthesize username = _username;

- (id) initWithURL:(NSURL*) url {
    self = [super initWithURL:url];
    if(self) {
	
#if IOS
    // TODO: refactor this
        self.responseHandler = [FLHttpImageDownloadNetworkResponseHandler instance];
#endif    

        self.imageSize = FLTwitterImageSizeNormal;

        [self addObserver:
            [FLOperationCacheHandler operationCacheHandler:[self.services storageService].cacheDatabase
                                              behavior:FLHttpOperationCacheBehaviorAll]];
    }
    
    return self;
}

- (void) dealloc
{
	release_(_username);
	release_(_imageSize);
	super_dealloc_();
}

- (void) runSelf {
    self.URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.twitter.com/1/users/profile_image/%@.json?size=%@", _username, _imageSize]];
    FLAssertNotNil_(self.URL);
    [super runSelf];
}

@end
