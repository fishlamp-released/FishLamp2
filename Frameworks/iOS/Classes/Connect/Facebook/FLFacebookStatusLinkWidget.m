////
////  FLFacebookStatusLinkWidget.m
////  Affable
////
////  Created by Mike Fullerton on 7/11/11.
////  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
////		self.arrangement = [FLColumnArrangement arrangement];
////		self.viewLayoutBehavior = FLArrangementBehaviorAdjustToSubviewHeightAfterLayout;
////
////		_picture = [[FLServerSideImageWidget alloc] initWithFrame:CGRectMake(0,0,kThumbSideSize,kThumbSideSize)];
//////		_thumbnail.backgroundThumbnail = [ZfAssetManager squareEmptyPhotoImage];
////		[self addWidget:_picture];
////
////		_rightColumn = [[FLWidget alloc] initWithFrame:FLRectSetWidth(frame, frame.size.width/2.0f)];
////		_rightColumn.arrangement = [FLSingleRowColumnArrangement arrangement ];
////		_rightColumn.arrangement.padding = UIEdgeInsetsMake(0,10,0,10);
////		_rightColumn.viewLayoutBehavior = FLArrangementBehaviorFlexibleWidth | FLArrangementBehaviorAdjustToSubviewHeightAfterLayout;
////		[self addWidget:_rightColumn];
////		
////		_name = [[FLLabelWidget alloc] initWithFrame:CGRectMake(0,0,140,20)];
////		_name.themeAction = @selector(applyThemeToMessageInTable:);
////		[_rightColumn addWidget:_name];
////
////		_caption = [[FLLabelWidget alloc] initWithFrame:CGRectMake(0,0,140,20)];
////		_caption.themeAction = @selector(applyThemeToMessageInTable:);
//////		_caption.viewLayoutCallback = ^(id layoutView, CGRect layoutFrame) {
//////			return FLRectSetHeight(layoutFrame, [layoutView heightOfTextForWidth:layoutFrame.size.width]); 
//////		};
////		[_rightColumn addWidget:_caption];
//	}
//	
//	return self;
//}
//
//- (void) setInfoWithPost:(FLFacebookPost*) post
//{
//	if(FLStringIsNotEmpty(post.picture))
//	{
//		[_picture setImageURL:post.picture];
//		_picture.hidden = NO;
//	}
//	else
//	{
//		_picture.hidden = YES;
//	}
//	_name.text = post.name;
//	_caption.text = post.caption;
//	
//	_name.hidden = FLStringIsEmpty(_name.text);
//	_caption.hidden = FLStringIsEmpty(_caption.text);
//	
//}
//
//@end
