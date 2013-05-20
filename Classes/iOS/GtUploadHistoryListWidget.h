//
//  GtUploadHistoryListWidget.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/6/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtWidget.h"
#import "GtUploadedAsset.h"
#import "GtThumbnailWidget.h"
#import "GtLabelWidget.h"
#import "GtGradientWidget.h"


@interface GtUploadHistoryListWidget : GtWidget {
@private
	GtUploadedAsset* m_uploadedAsset;
	
	GtGradientWidget* m_gradient;
	GtThumbnailWidget* m_thumbnail;
	GtLabelWidget* m_assetName;
	GtLabelWidget* m_assetDestinationName;
	GtLabelWidget* m_uploadDate;
	GtLabelWidget* m_countLabel;
	
	GtWidget* m_leftColumn;
	GtWidget* m_centerColumn;
	GtWidget* m_rightColumn;
}

- (void) setUploadedAsset:(GtUploadedAsset*) asset count:(NSUInteger) count total:(NSUInteger) total;

@end
