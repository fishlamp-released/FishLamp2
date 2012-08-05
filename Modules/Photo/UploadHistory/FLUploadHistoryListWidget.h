//
//  FLUploadHistoryListWidget.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/6/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWidget.h"
#import "FLUploadedAsset.h"
#import "FLThumbnailWidget.h"
#import "FLLabelWidget.h"
#import "FLGradientWidget.h"


@interface FLUploadHistoryListWidget : FLWidget {
@private
	FLUploadedAsset* m_uploadedAsset;
	
	FLGradientWidget* m_gradient;
	FLThumbnailWidget* m_thumbnail;
	FLLabelWidget* m_assetName;
	FLLabelWidget* m_assetDestinationName;
	FLLabelWidget* m_uploadDate;
	FLLabelWidget* m_countLabel;
	
	FLWidget* m_leftColumn;
	FLWidget* m_centerColumn;
	FLWidget* m_rightColumn;
}

- (void) setUploadedAsset:(FLUploadedAsset*) asset count:(NSUInteger) count total:(NSUInteger) total;

@end
