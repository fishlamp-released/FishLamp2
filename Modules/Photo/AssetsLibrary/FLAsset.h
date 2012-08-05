//
//  FLAsset.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/16/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLAsset <NSObject>
@property (readwrite, retain, nonatomic) NSString* assetUID; // 
@property (readonly, retain, nonatomic) NSURL* assetURL; // file: or assets-library:
@property (readonly, retain, nonatomic) UIImage* thumbnailImage;

- (void) deleteFromAssetStorage;

- (void) beginLoadingRepresentation:(FLErrorCallback) completionBlock;

@end

@interface FLAsset : NSObject<FLAsset> {
@private
	NSString* m_assetUID;
}
@end