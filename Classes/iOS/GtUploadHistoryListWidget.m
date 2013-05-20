//
//  GtUploadHistoryListWidget.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/6/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtUploadHistoryListWidget.h"
#import "GtMobileConnectTheme.h"

#import "GtDateMgr.h"
#import "GtDisplayFormatters.h"

#define kBuffer 10.f
#define kUserNameHeight 16.0f
#define kMessageTop 10.0f
#define kTextLeft 800
#define kThumbSideSize 52


@implementation GtUploadHistoryListWidget

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		m_gradient = [[GtGradientWidget alloc] initWithFrame:frame];
		self.backgroundWidget = m_gradient;

		self.viewLayout = [GtColumnViewLayout viewLayout];
		self.viewLayout.padding = UIEdgeInsetsMake(4,4,4,4);

// init left column
		m_leftColumn = [[GtWidget alloc] initWithFrame:CGRectMake(0,0,kThumbSideSize,kThumbSideSize)];
		m_leftColumn.viewLayout = [GtRowViewLayout viewLayout];
		[self addSubwidget:m_leftColumn];

		m_thumbnail = [[GtThumbnailWidget alloc] initWithFrame:CGRectMake(0,0,kThumbSideSize,kThumbSideSize)];
//		m_thumbnail.backgroundThumbnail = [ZfAssetManager squareEmptyPhotoImage];
		[m_leftColumn addSubwidget:m_thumbnail];
		

// init center column
		m_centerColumn = [[GtWidget alloc] initWithFrame: CGRectMake(0,0,100, 60)];
		m_centerColumn.viewLayout = [GtRowViewLayout viewLayout];
		m_centerColumn.viewLayout.padding = UIEdgeInsetsMake(0,4,0,4);
        m_centerColumn.viewLayoutBehavior = [GtViewLayoutBehavior viewLayoutBehavior];
        m_centerColumn.viewLayoutBehavior.resizeMask = GtViewLayoutResizeMaskFlexibleWidth;
		[self addSubwidget:m_centerColumn];
		
		m_assetName = [[GtLabelWidget alloc] initWithFrame: CGRectMake(0,0,100,20)];
		m_assetName.themeAction = @selector(applyThemeToNameInTable:);
		
		[m_centerColumn addSubwidget:m_assetName];

		m_assetDestinationName = [[GtLabelWidget alloc] initWithFrame: CGRectMake(0,0,100,20)];
		m_assetDestinationName.themeAction = @selector(applyThemeToMessageInTable:);
		[m_centerColumn addSubwidget:m_assetDestinationName ];

		m_uploadDate = [[GtLabelWidget alloc] initWithFrame:CGRectZero];
		m_uploadDate.themeAction = @selector(applyThemeToMessageInTable:);
		[m_centerColumn addSubwidget:m_uploadDate];

// init right column		
		m_rightColumn = [[GtWidget alloc] initWithFrame:GtRectSetWidth(m_centerColumn.frame, 80)];
		m_rightColumn.viewLayout = [GtRowViewLayout viewLayout];
		[self addSubwidget:m_rightColumn];

		m_countLabel = [[GtLabelWidget alloc] initWithFrame:CGRectZero];
		m_countLabel.textAlignment = UITextAlignmentRight;
		m_countLabel.themeAction = @selector(applyThemeToMessageInTable:);
		[m_rightColumn addSubwidget:m_countLabel];
	}
	
	return self;
}

- (void) setUploadedAsset:(GtUploadedAsset*) asset count:(NSUInteger) count total:(NSUInteger) total
{
	GtAssignObject(m_uploadedAsset, asset);
	
	m_thumbnail.foregroundThumbnail = asset.thumbnail;
	m_assetName.text = asset.assetName;
	m_assetDestinationName.text = [NSString stringWithFormat:(NSLocalizedString(@"Uploaded to: %@", nil)), asset.uploadDestinationName];
	m_uploadDate.text = [NSString stringWithFormat:(NSLocalizedString(@"Upload time: %@", nil)), [GtDateFormatter displayFormatterDataToString:asset.uploadedDate]];
	m_countLabel.text = [NSString stringWithFormat:(NSLocalizedString(@"%d of %d", nil)), count, total];
	
	[m_assetName sizeToFitText];
	[m_assetDestinationName sizeToFitText];
	[m_uploadDate sizeToFitText];
	[m_countLabel sizeToFitText];
	
	[self setNeedsLayout];
}


- (void) dealloc
{
	GtRelease(m_leftColumn);
	GtRelease(m_centerColumn);
	GtRelease(m_rightColumn);
	GtRelease(m_countLabel);
	GtRelease(m_uploadedAsset);
	GtRelease(m_gradient);
	GtRelease(m_thumbnail);
	GtRelease(m_assetName);
	GtRelease(m_assetDestinationName);
	GtRelease(m_uploadDate);
	GtSuperDealloc();
}

@end
