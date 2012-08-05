//
//  FLUploadHistoryListWidget.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/6/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLUploadHistoryListWidget.h"
#import "FLMobileConnectTheme.h"

#import "FLDateMgr.h"
#import "FLDisplayFormatters.h"

#import "FLArrangement.h"
#import "FLSingleColumnRowArrangement.h"
#import "FLSingleRowColumnArrangement.h"

#define kBuffer 10.f
#define kUserNameHeight 16.0f
#define kMessageTop 10.0f
#define kTextLeft 800
#define kThumbSideSize 52

@implementation FLUploadHistoryListWidget

- (void) applyTheme:(FLTheme*) theme {
    [super applyTheme:theme];

//		m_assetName.themeAction = @selector(applyThemeToNameInTable:);
//		m_assetDestinationName.themeAction = @selector(applyThemeToMessageInTable:);
//		m_uploadDate.themeAction = @selector(applyThemeToMessageInTable:);
//		m_countLabel.themeAction = @selector(applyThemeToMessageInTable:);

    
}

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame])) {
        
        self.wantsApplyTheme = YES;
        
		m_gradient = [[FLGradientWidget alloc] initWithFrame:frame];
		m_gradient.contentMode = FLContentModeFill;
        [self addWidget:m_gradient];        

		self.subwidgetArrangement = [FLSingleColumnRowArrangement arrangement];
		self.subwidgetArrangement.arrangementInsets = UIEdgeInsetsMake(4,4,4,4);

// init left column
		m_leftColumn = [[FLWidget alloc] initWithFrame:CGRectMake(0,0,kThumbSideSize,kThumbSideSize)];
		m_leftColumn.subwidgetArrangement = [FLSingleColumnRowArrangement arrangement];
		[self addWidget:m_leftColumn];

		m_thumbnail = [[FLThumbnailWidget alloc] initWithFrame:CGRectMake(0,0,kThumbSideSize,kThumbSideSize)];
//		m_thumbnail.backgroundThumbnail = [ZfAssetManager squareEmptyPhotoImage];
		[m_leftColumn addWidget:m_thumbnail];
		

// init center column
		m_centerColumn = [[FLWidget alloc] initWithFrame: CGRectMake(0,0,100, 60)];
		m_centerColumn.subwidgetArrangement = [FLSingleRowColumnArrangement arrangement];
		m_centerColumn.arrangeableInsets = UIEdgeInsetsMake(0,4,0,4);
        m_centerColumn.arrangeableFillMode = FLArrangeableFillModeFlexibleWidth;
		[self addWidget:m_centerColumn];
		
		m_assetName = [[FLLabelWidget alloc] initWithFrame: CGRectMake(0,0,100,20)];
		
		[m_centerColumn addWidget:m_assetName];

		m_assetDestinationName = [[FLLabelWidget alloc] initWithFrame: CGRectMake(0,0,100,20)];
		[m_centerColumn addWidget:m_assetDestinationName ];

		m_uploadDate = [[FLLabelWidget alloc] initWithFrame:CGRectZero];
		[m_centerColumn addWidget:m_uploadDate];

// init right column		
		m_rightColumn = [[FLWidget alloc] initWithFrame:FLRectSetWidth(m_centerColumn.frame, 80)];
		m_rightColumn.subwidgetArrangement = [FLSingleColumnRowArrangement arrangement];
		[self addWidget:m_rightColumn];

		m_countLabel = [[FLLabelWidget alloc] initWithFrame:CGRectZero];
		m_countLabel.textAlignment = UITextAlignmentRight;
		[m_rightColumn addWidget:m_countLabel];
	}
	
	return self;
}

- (void) setUploadedAsset:(FLUploadedAsset*) asset count:(NSUInteger) count total:(NSUInteger) total
{
	FLAssignObject(m_uploadedAsset, asset);
	
	m_thumbnail.foregroundThumbnail = asset.thumbnail;
	m_assetName.text = asset.assetName;
	m_assetDestinationName.text = [NSString stringWithFormat:(NSLocalizedString(@"Uploaded to: %@", nil)), asset.uploadDestinationName];
	m_uploadDate.text = [NSString stringWithFormat:(NSLocalizedString(@"Upload time: %@", nil)), [FLDateFormatter displayFormatterDataToString:asset.uploadedDate]];
	m_countLabel.text = [NSString stringWithFormat:(NSLocalizedString(@"%d of %d", nil)), count, total];
	
	[m_assetName sizeToFitText];
	[m_assetDestinationName sizeToFitText];
	[m_uploadDate sizeToFitText];
	[m_countLabel sizeToFitText];
	
	[self setNeedsLayout];
}


- (void) dealloc
{
	FLRelease(m_leftColumn);
	FLRelease(m_centerColumn);
	FLRelease(m_rightColumn);
	FLRelease(m_countLabel);
	FLRelease(m_uploadedAsset);
	FLRelease(m_gradient);
	FLRelease(m_thumbnail);
	FLRelease(m_assetName);
	FLRelease(m_assetDestinationName);
	FLRelease(m_uploadDate);
	FLSuperDealloc();
}

@end
