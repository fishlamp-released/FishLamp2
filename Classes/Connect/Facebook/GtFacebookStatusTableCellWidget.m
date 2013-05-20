//
//  GtFacebookStatusTableCell.m
//  fBee
//
//  Created by Mike Fullerton on 6/2/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookStatusTableCellWidget.h"
//#import "GtThemeManager.h"
//#import "GtFacebookTheme.h"
//#import "GtTextDescriptor.h"
#import "GtFacebookLoadUserPictureOperation.h"

//#define kBuffer 10.f
//#define kUserNameHeight 16.0f
//#define kMessageTop 30.0f
//#define kTextLeft 60
//#define kThumbSideSize 40
#import "GtCachedImage.h"

#import "GtActionContextManager.h"
#import "GtDisplayFormatters.h"

@implementation GtFacebookStatusTableCellWidget

@synthesize post = m_post;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		m_linkWidget = [[GtFacebookStatusLinkWidget alloc] initWithFrame:CGRectMake(0,0,100,20)];
		m_linkWidget.hidden = YES;
	//	[self.rightColumn addSubwidget:m_linkWidget];
	
		m_likesAndCommentsWidget = [[GtLabelWidget alloc] initWithFrame:CGRectMake(0,0,100,20)];
		m_likesAndCommentsWidget.themeAction = @selector(applyThemeToMessageInTable:);
	//	[self.rightColumn addSubwidget:m_likesAndCommentsWidget];
	
	}
	
	return self;
	
}

- (void) dealloc
{	
	GtRelease(m_likesAndCommentsWidget);
	GtRelease(m_post);
	GtSuperDealloc();
}

- (void) setPost:(GtFacebookPost*) post
{
	if(GtAssignObject(m_post, post))
	{
		self.userNameWidget.text = post.from.name;
		self.messageWidget.text = post.message;
		self.postedTimeWidget.text = [GtDateFormatter displayFormatterDataToString:post.created_time];
		
		NSString* likesOrComments = nil;
		
		if(GtStringIsNotEmpty(post.link))
		{
			[m_linkWidget setInfoWithPost:post];
			m_linkWidget.hidden = NO;
		}
		else
		{
			m_linkWidget.hidden = YES;
		}
		
		if(post.likes && post.likes.count)
		{	
			likesOrComments = [NSString stringWithFormat:@"%@ likes", post.likes.count];
		}
		
		if(post.comments && post.comments.count)
		{
			if(likesOrComments)
			{
				likesOrComments = [NSString stringWithFormat:@"%@, %@ Comments", likesOrComments, post.comments.count];
			}
			else
			{
				likesOrComments = [NSString stringWithFormat:@"%@ Comments", post.comments.count];
			}
		}
		
		m_likesAndCommentsWidget.hidden = GtStringIsEmpty(likesOrComments);
		m_likesAndCommentsWidget.text = likesOrComments;
		
		[[GtActionContextManager instance].activeContext beginAction:[GtAction action] configureAction:^(id action) {
			[action actionDescription].actionType = GtActionDescriptionTypeDownload;
			[action actionDescription].itemName = @"Profile Photo";
			[action queueOperation:[GtFacebookLoadUserPictureOperation operation] configureOperation:^(id operation) {
					[operation setUserId:post.from.id];
					[operation setPictureSize:GtFacebookLoadUserPictureOperationInputSizeSquare];
				}];
			
			[action setDidCompleteCallback:^{
				self.thumbnailWidget.foregroundThumbnail =
					[[[[action lastOperation] operationOutput] imageFile] image];
				}];
			
			}];
		
	}
}

- (CGFloat) calculateRowHeightInTableView:(UITableView*) tableView withData:(GtFacebookPost*) data
{
	self.userNameWidget.text = data.from.name;
	self.messageWidget.text = data.message;

	return [super calculateRowHeightInTableView:tableView withData:data];
}

//- (void) layoutSubwidgets
//{
//	m_gradient.frame = self.frame;
//
//	m_thumbnail.frame = GtRectSetOrigin(m_thumbnail.frame, self.frame.origin.x + 5, self.frame.origin.y + 5);
//
//	CGFloat textWidth = GtRectGetRight(self.frame) - kBuffer - kTextLeft;
//
//	m_userName.frame = CGRectMake(
//		kTextLeft,
//		kBuffer,
//		textWidth,
//		kUserNameHeight);
//		
//	m_message.frame = CGRectMake(
//		kTextLeft,
//		kMessageTop,
//		textWidth,
//		[m_message heightOfTextForWidth:textWidth]);
//	
//}

//+ (CGFloat) heightForRowWithWidth:(CGFloat) width andString:(NSString*) string
//{
//	CGFloat textWidth = width - kBuffer - kTextLeft;
//	GtTextDescriptor* desc = [GtThemeManager queryTheme:@selector(textDescriptorForMessageTextInTable)];
//	return kMessageTop + kBuffer +  [string sizeWithFont:desc.font
//									constrainedToSize:CGSizeMake(textWidth, 2048.0)
//									lineBreakMode:UILineBreakModeWordWrap].height;
//}

@end
