//
//  FLTwitterLoadProfileImageOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/9/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLTwitterLoadProfileImageHttpRequest.h"
#import "FLTwitterService.h"
#import "FLOperationCacheHandler.h"

@implementation FLTwitterLoadProfileImageHttpRequest

@synthesize imageSize = _imageSize;
@synthesize username = _username;

- (id) initWithTwitterURL:(NSURL*) url {
    self = [super initWithTwitterURL:url];
    if(self) {
	    self.imageSize = FLTwitterImageSizeNormal;


// FIXME
//        [self addObserver:
//            [FLOperationCacheHandler operationCacheHandler:[[self.context storageService] cacheDatabase]
//                                              behavior:FLHttpOperationCacheBehaviorAll]];
    }
    
    return self;
}

- (void) dealloc
{
	FLRelease(_username);
	FLRelease(_imageSize);
	FLSuperDealloc();
}

//- (FLResult) runOperationInContext:(id) context withObserver:(id) observer {
//    self.twitterURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.twitter.com/1/users/profile_image/%@.json?size=%@", _username, _imageSize]];
//    FLAssertNotNil_(self.httpRequestURL);
//    
//FIXME(@"need the behavior but not the operation");
//  
////        self.responseHandler = [FLHttpImageDownloadNetworkResponseHandler instance];
////        self.operationInput = [FLCachedImage cachedImage];
//  
//    
//    return [super runOperation];
//}

@end
