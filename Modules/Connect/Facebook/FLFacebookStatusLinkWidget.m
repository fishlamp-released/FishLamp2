////
////  FLFacebookStatusLinkWidget.m
////  Affable
////
////  Created by Mike Fullerton on 7/11/11.
////  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
////
//
//#import "FLFacebookStatusLinkWidget.h"
//
//#define kThumbSideSize 80
//
//@implementation FLFacebookStatusLinkWidget
//
//- (id) initWithFrame:(CGRect) frame
//{
//	if((self = [super initWithFrame:frame]))
//	{
////		self.subviewArrangement = [FLColumnArrangement arrangement];
////		self.viewLayoutBehavior = FLArrangementBehaviorAdjustToSubviewHeightAfterLayout;
////
////		m_picture = [[FLServerSideImageWidget alloc] initWithFrame:CGRectMake(0,0,kThumbSideSize,kThumbSideSize)];
//////		m_thumbnail.backgroundThumbnail = [ZfAssetManager squareEmptyPhotoImage];
////		[self addWidget:m_picture];
////
////		m_rightColumn = [[FLWidget alloc] initWithFrame:FLRectSetWidth(frame, frame.size.width/2.0f)];
////		m_rightColumn.subviewArrangement = [FLSingleRowColumnArrangement arrangement ];
////		m_rightColumn.subviewArrangement.padding = UIEdgeInsetsMake(0,10,0,10);
////		m_rightColumn.viewLayoutBehavior = FLArrangementBehaviorFlexibleWidth | FLArrangementBehaviorAdjustToSubviewHeightAfterLayout;
////		[self addWidget:m_rightColumn];
////		
////		m_name = [[FLLabelWidget alloc] initWithFrame:CGRectMake(0,0,140,20)];
////		m_name.themeAction = @selector(applyThemeToMessageInTable:);
////		[m_rightColumn addWidget:m_name];
////
////		m_caption = [[FLLabelWidget alloc] initWithFrame:CGRectMake(0,0,140,20)];
////		m_caption.themeAction = @selector(applyThemeToMessageInTable:);
//////		m_caption.viewLayoutCallback = ^(id layoutView, CGRect layoutFrame) {
//////			return FLRectSetHeight(layoutFrame, [layoutView heightOfTextForWidth:layoutFrame.size.width]); 
//////		};
////		[m_rightColumn addWidget:m_caption];
//	}
//	
//	return self;
//}
//
//- (void) setInfoWithPost:(FLFacebookPost*) post
//{
//	if(FLStringIsNotEmpty(post.picture))
//	{
//		[m_picture setImageURL:post.picture];
//		m_picture.hidden = NO;
//	}
//	else
//	{
//		m_picture.hidden = YES;
//	}
//	m_name.text = post.name;
//	m_caption.text = post.caption;
//	
//	m_name.hidden = FLStringIsEmpty(m_name.text);
//	m_caption.hidden = FLStringIsEmpty(m_caption.text);
//	
//}
//
//@end
