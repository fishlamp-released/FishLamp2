//
//  FLAsset.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/16/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLAsset.h"


@implementation FLAsset

@synthesize assetUID = _assetUID;

- (id) initWithQueuedAsset:(FLQueuedAsset *)asset {
    FLAssertIsOverridden_v(nil);
    return self;
}

- (void) dealloc
{
	FLRelease(_assetUID);
	FLSuperDealloc();
}

- (NSURL*) assetURL
{
	return nil;
}

- (FLImage*) thumbnailImage
{
	return nil;
}

- (BOOL)isEqual:(id)object
{
	return [self.assetURL isEqual:[object assetURL]];
}

- (NSUInteger)hash
{
	return [self.assetURL hash];
}

- (NSString*) description
{
	return [NSMutableString stringWithFormat:@"%@: UID: %@, URL: %@", [super description], self.assetUID, self.assetURL];
}

- (void) deleteFromAssetStorage
{

}

- (void) beginLoadingRepresentation:(void (^)(NSError* error)) completionBlock
{
    if(completionBlock)
    {
        completionBlock(nil);
    }
}

@end

@implementation NSObject (FLAsset)
+ (NSString*) assetURLScheme {
    return nil;
}
@end