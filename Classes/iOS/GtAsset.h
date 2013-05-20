//
//  GtAsset.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/16/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@protocol GtAsset <NSObject>
@property (readwrite, retain, nonatomic) NSString* assetUID; // 
@property (readonly, retain, nonatomic) NSURL* assetURL; // file: or assets-library:
@property (readonly, retain, nonatomic) UIImage* thumbnailImage;

- (void) deleteFromAssetStorage;

- (void) beginLoadingRepresentation:(GtErrorCallback) completionBlock;

@end

@interface GtAsset : NSObject<GtAsset> {
@private
	NSString* m_assetUID;
}
@end