//
//  FLAsset.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/16/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLQueuedAsset;

@protocol FLAsset <NSObject>

- (id) initWithQueuedAsset:(FLQueuedAsset*) asset;

@property (readwrite, strong, nonatomic) NSString* assetUID; //
@property (readonly, strong, nonatomic) NSURL* assetURL; // file: or assets-library:
@property (readonly, strong, nonatomic) FLImage* thumbnailImage;

- (void) deleteFromAssetStorage;

- (void) beginLoadingRepresentation:(void (^)(NSError* error)) completionBlock;

@end

@interface FLAsset : NSObject<FLAsset> {
@private
	NSString* _assetUID;
}
@end

@interface NSObject (FLAsset)
+ (NSString*) assetURLScheme; // e.g. file, or asset-library
@end
