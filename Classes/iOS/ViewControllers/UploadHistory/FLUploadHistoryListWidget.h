//
//  FLUploadHistoryListWidget.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/6/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLWidget.h"
#import "FLUploadedAsset.h"
#import "FLThumbnailWidget.h"
#import "FLLabelWidget.h"
#import "FLGradientWidget.h"


@interface FLUploadHistoryListWidget : FLWidget {
@private
	FLUploadedAsset* _uploadedAsset;
	
	FLGradientWidget* _gradient;
	FLThumbnailWidget* _thumbnail;
	FLLabelWidget* _assetName;
	FLLabelWidget* _assetDestinationName;
	FLLabelWidget* _uploadDate;
	FLLabelWidget* _countLabel;
	
	FLWidget* _leftColumn;
	FLWidget* _centerColumn;
	FLWidget* _rightColumn;
}

- (void) setUploadedAsset:(FLUploadedAsset*) asset count:(NSUInteger) count total:(NSUInteger) total;

@end
