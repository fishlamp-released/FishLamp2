//
//  FLAsset.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/16/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLAsset.h"


@implementation FLAsset

@synthesize assetUID = m_assetUID;

- (void) dealloc
{
	FLRelease(m_assetUID);
	FLSuperDealloc();
}

- (NSURL*) assetURL
{
	return nil;
}

- (UIImage*) thumbnailImage
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

- (void) beginLoadingRepresentation:(FLErrorCallback) completionBlock
{
    if(completionBlock)
    {
        completionBlock(nil);
    }
}

@end
