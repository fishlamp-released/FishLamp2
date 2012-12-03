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

//		_assetName.themeAction = @selector(applyThemeToNameInTable:);
//		_assetDestinationName.themeAction = @selector(applyThemeToMessageInTable:);
//		_uploadDate.themeAction = @selector(applyThemeToMessageInTable:);
//		_countLabel.themeAction = @selector(applyThemeToMessageInTable:);

    
}

- (id) initWithFrame:(FLRect) frame
{
	if((self = [super initWithFrame:frame])) {
        
        self.wantsApplyTheme = YES;
        
		_gradient = [[FLGradientWidget alloc] initWithFrame:frame];
		_gradient.contentMode = FLContentModeFill;
        [self addWidget:_gradient];        

		self.arrangement = [FLSingleColumnRowArrangement arrangement];
		self.arrangement.outerInsets = UIEdgeInsetsMake(4,4,4,4);

// init left column
		_leftColumn = [[FLWidget alloc] initWithFrame:CGRectMake(0,0,kThumbSideSize,kThumbSideSize)];
		_leftColumn.arrangement = [FLSingleColumnRowArrangement arrangement];
		[self addWidget:_leftColumn];

		_thumbnail = [[FLThumbnailWidget alloc] initWithFrame:CGRectMake(0,0,kThumbSideSize,kThumbSideSize)];
//		_thumbnail.backgroundThumbnail = [ZfAssetManager squareEmptyPhotoImage];
		[_leftColumn addWidget:_thumbnail];
		

// init center column
		_centerColumn = [[FLWidget alloc] initWithFrame: CGRectMake(0,0,100, 60)];
		_centerColumn.arrangement = [FLSingleRowColumnArrangement arrangement];
		_centerColumn.arrangeableInsets = UIEdgeInsetsMake(0,4,0,4);
        _centerColumn.arrangeableGrowMode = FLArrangeableGrowModeFlexibleWidth;
		[self addWidget:_centerColumn];
		
		_assetName = [[FLLabelWidget alloc] initWithFrame: CGRectMake(0,0,100,20)];
		
		[_centerColumn addWidget:_assetName];

		_assetDestinationName = [[FLLabelWidget alloc] initWithFrame: CGRectMake(0,0,100,20)];
		[_centerColumn addWidget:_assetDestinationName ];

		_uploadDate = [[FLLabelWidget alloc] initWithFrame:CGRectZero];
		[_centerColumn addWidget:_uploadDate];

// init right column		
		_rightColumn = [[FLWidget alloc] initWithFrame:FLRectSetWidth(_centerColumn.frame, 80)];
		_rightColumn.arrangement = [FLSingleColumnRowArrangement arrangement];
		[self addWidget:_rightColumn];

		_countLabel = [[FLLabelWidget alloc] initWithFrame:CGRectZero];
		_countLabel.textAlignment = UITextAlignmentRight;
		[_rightColumn addWidget:_countLabel];
	}
	
	return self;
}

- (void) setUploadedAsset:(FLUploadedAsset*) asset count:(NSUInteger) count total:(NSUInteger) total
{
	FLRetainObject_(_uploadedAsset, asset);
	
	_thumbnail.foregroundThumbnail = asset.thumbnail;
	_assetName.text = asset.assetName;
	_assetDestinationName.text = [NSString stringWithFormat:(NSLocalizedString(@"Uploaded to: %@", nil)), asset.uploadDestinationName];
	_uploadDate.text = [NSString stringWithFormat:(NSLocalizedString(@"Upload time: %@", nil)), [FLDateFormatter displayFormatterDataToString:asset.uploadedDate]];
	_countLabel.text = [NSString stringWithFormat:(NSLocalizedString(@"%d of %d", nil)), count, total];
	
	[_assetName sizeToFitText];
	[_assetDestinationName sizeToFitText];
	[_uploadDate sizeToFitText];
	[_countLabel sizeToFitText];
	
	[self setNeedsLayout];
}


- (void) dealloc
{
	release_(_leftColumn);
	release_(_centerColumn);
	release_(_rightColumn);
	release_(_countLabel);
	release_(_uploadedAsset);
	release_(_gradient);
	release_(_thumbnail);
	release_(_assetName);
	release_(_assetDestinationName);
	release_(_uploadDate);
	super_dealloc_();
}

@end
