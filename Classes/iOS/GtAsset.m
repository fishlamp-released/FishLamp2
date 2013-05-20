//
//  GtAsset.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/16/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtAsset.h"


@implementation GtAsset

@synthesize assetUID = m_assetUID;

- (void) dealloc
{
	GtRelease(m_assetUID);
	GtSuperDealloc();
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

- (void) beginLoadingRepresentation:(GtErrorCallback) completionBlock
{
    if(completionBlock)
    {
        completionBlock(nil);
    }
}

@end
