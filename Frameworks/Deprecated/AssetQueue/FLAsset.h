//
//  FLAsset.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/16/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLStorableObject.h"

@class FLQueuedAsset;

@protocol FLAsset <NSObject>

//- (id) initWithQueuedAsset:(FLQueuedAsset*) asset;

@property (readwrite, strong, nonatomic) NSString* assetUID; //
@property (readonly, strong, nonatomic) NSURL* assetURL; // file: or assets-library:
@property (readonly, strong, nonatomic) UIImage* thumbnailImage;

//- (void) deleteFromAssetStorage;

//- (FLFinisher*) startLoadingRepresentation:(FLDispatchBlockWithResult) completionBlock;

@end

@interface FLAsset : NSObject {
@private
	NSString* _assetUID;
}
@property (readwrite, strong) NSString* assetUID;
@end

@interface NSObject (FLAsset)
+ (NSString*) assetURLScheme; // e.g. file, or asset-library
@end
