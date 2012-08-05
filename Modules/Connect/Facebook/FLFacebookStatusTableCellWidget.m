//
//  FLFacebookStatusTableCell.m
//  fBee
//
//  Created by Mike Fullerton on 6/2/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#if 0
#import "FLFacebookStatusTableCellWidget.h"
//#import "FLThemeManager.h"
//#import "FLFacebookTheme.h"
//#import "FLTextDescriptor.h"
#import "FLFacebookLoadUserPictureOperation.h"

//#define kBuffer 10.f
//#define kUserNameHeight 16.0f
//#define kMessageTop 30.0f
//#define kTextLeft 60
//#define kThumbSideSize 40
#import "FLCachedImage.h"

#import "FLActionContextManager.h"
#import "FLDisplayFormatters.h"

@implementation FLFacebookStatusTableCellWidget

@synthesize post = m_post;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		m_linkWidget = [[FLFacebookStatusLinkWidget alloc] initWithFrame:CGRectMake(0,0,100,20)];
		m_linkWidget.hidden = YES;
	//	[self.rightColumn addWidget:m_linkWidget];
	
		m_likesAndCommentsWidget = [[FLLabelWidget alloc] initWithFrame:CGRectMake(0,0,100,20)];
		m_likesAndCommentsWidget.themeAction = @selector(applyThemeToMessageInTable:);
	//	[self.rightColumn addWidget:m_likesAndCommentsWidget];
	
	}
	
	return self;
	
}

- (void) dealloc
{	
	FLRelease(m_likesAndCommentsWidget);
	FLRelease(m_post);
	FLSuperDealloc();
}

- (void) setPost:(FLFacebookPost*) post
{
	if(m_post != post)
	{
		FLAssignObject(m_post, post);
        self.userNameWidget.text = post.from.name;
		self.messageWidget.text = post.message;
		self.postedTimeWidget.text = [FLDateFormatter displayFormatterDataToString:post.created_time];
		
		NSString* likesOrComments = nil;
		
		if(FLStringIsNotEmpty(post.link))
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
		
		m_likesAndCommentsWidget.hidden = FLStringIsEmpty(likesOrComments);
		m_likesAndCommentsWidget.text = likesOrComments;
		
        FLAction* action = [FLAction action];
        [action actionDescription].actionType = FLActionDescriptionTypeDownload;
        [action actionDescription].actionItemName = @"Profile Photo";

        FLFacebookLoadUserPictureOperation* operation = [FLFacebookLoadUserPictureOperation operation];
        [operation setUserId:post.from.id];
        [operation setPictureSize:FLFacebookLoadUserPictureOperationInputSizeSquare];
        [action queueOperation:operation];
        
        [action setOnFinished:^(id theAction) {
            self.thumbnailWidget.foregroundThumbnail =
                [[[[theAction lastOperation] operationOutput] imageFile] image];
            }];
        
		[[FLActionContextManager instance].activeContext beginAction:action]; 
    }
}

- (CGFloat) calculateRowHeightInTableView:(UITableView*) tableView withData:(FLFacebookPost*) data
{
	self.userNameWidget.text = data.from.name;
	self.messageWidget.text = data.message;

	return [super calculateRowHeightInTableView:tableView withData:data];
}

//- (void) layoutWidgets
//{
//	m_gradient.frame = self.frame;
//
//	m_thumbnail.frame = FLRectSetOrigin(m_thumbnail.frame, self.frame.origin.x + 5, self.frame.origin.y + 5);
//
//	CGFloat textWidth = FLRectGetRight(self.frame) - kBuffer - kTextLeft;
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
//	FLTextDescriptor* desc = [FLThemeManager queryTheme:@selector(textDescriptorForMessageTextInTable)];
//	return kMessageTop + kBuffer +  [string sizeWithFont:desc.font
//									constrainedToSize:CGSizeMake(textWidth, 2048.0)
//									lineBreakMode:UILineBreakModeWordWrap].height;
//}

@end
#endif