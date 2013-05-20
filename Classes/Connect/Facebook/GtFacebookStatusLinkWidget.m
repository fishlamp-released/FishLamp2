//
//  GtFacebookStatusLinkWidget.m
//  Affable
//
//  Created by Mike Fullerton on 7/11/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookStatusLinkWidget.h"

#define kThumbSideSize 80

@implementation GtFacebookStatusLinkWidget

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
//		self.viewLayout = [GtColumnViewLayout viewLayout];
//		self.viewLayoutBehavior = GtViewLayoutBehaviorAdjustToSubviewHeightAfterLayout;
//
//		m_picture = [[GtServerSideImageWidget alloc] initWithFrame:CGRectMake(0,0,kThumbSideSize,kThumbSideSize)];
////		m_thumbnail.backgroundThumbnail = [ZfAssetManager squareEmptyPhotoImage];
//		[self addSubwidget:m_picture];
//
//		m_rightColumn = [[GtWidget alloc] initWithFrame:GtRectSetWidth(frame, frame.size.width/2.0f)];
//		m_rightColumn.viewLayout = [GtRowViewLayout viewLayout ];
//		m_rightColumn.viewLayout.padding = UIEdgeInsetsMake(0,10,0,10);
//		m_rightColumn.viewLayoutBehavior = GtViewLayoutBehaviorFlexibleWidth | GtViewLayoutBehaviorAdjustToSubviewHeightAfterLayout;
//		[self addSubwidget:m_rightColumn];
//		
//		m_name = [[GtLabelWidget alloc] initWithFrame:CGRectMake(0,0,140,20)];
//		m_name.themeAction = @selector(applyThemeToMessageInTable:);
//		[m_rightColumn addSubwidget:m_name];
//
//		m_caption = [[GtLabelWidget alloc] initWithFrame:CGRectMake(0,0,140,20)];
//		m_caption.themeAction = @selector(applyThemeToMessageInTable:);
////		m_caption.viewLayoutCallback = ^(id layoutView, CGRect layoutFrame) {
////			return GtRectSetHeight(layoutFrame, [layoutView heightOfTextForWidth:layoutFrame.size.width]); 
////		};
//		[m_rightColumn addSubwidget:m_caption];
	}
	
	return self;
}

- (void) setInfoWithPost:(GtFacebookPost*) post
{
	if(GtStringIsNotEmpty(post.picture))
	{
		[m_picture setImageURL:post.picture];
		m_picture.hidden = NO;
	}
	else
	{
		m_picture.hidden = YES;
	}
	m_name.text = post.name;
	m_caption.text = post.caption;
	
	m_name.hidden = GtStringIsEmpty(m_name.text);
	m_caption.hidden = GtStringIsEmpty(m_caption.text);
	
}

@end
