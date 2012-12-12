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

//#import "FLActionContextManager.h"
#import "FLDisplayFormatters.h"

@implementation FLFacebookStatusTableCellWidget

@synthesize post = _post;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		_linkWidget = [[FLFacebookStatusLinkWidget alloc] initWithFrame:CGRectMake(0,0,100,20)];
		_linkWidget.hidden = YES;
	//	[self.rightColumn addWidget:_linkWidget];
	
		_likesAndCommentsWidget = [[FLLabelWidget alloc] initWithFrame:CGRectMake(0,0,100,20)];
		_likesAndCommentsWidget.themeAction = @selector(applyThemeToMessageInTable:);
	//	[self.rightColumn addWidget:_likesAndCommentsWidget];
	
	}
	
	return self;
	
}

- (void) dealloc
{	
	FLRelease(_likesAndCommentsWidget);
	FLRelease(_post);
	super_dealloc_();
}

- (void) setPost:(FLFacebookPost*) post
{
	if(_post != post)
	{
		FLAssignObjectWithRetain(_post, post);
        self.userNameWidget.text = post.from.name;
		self.messageWidget.text = post.message;
		self.postedTimeWidget.text = [FLDateFormatter displayFormatterDataToString:post.created_time];
		
		NSString* likesOrComments = nil;
		
		if(FLStringIsNotEmpty(post.link))
		{
			[_linkWidget setInfoWithPost:post];
			_linkWidget.hidden = NO;
		}
		else
		{
			_linkWidget.hidden = YES;
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
		
		_likesAndCommentsWidget.hidden = FLStringIsEmpty(likesOrComments);
		_likesAndCommentsWidget.text = likesOrComments;
		
        FLAction* action = [FLAction action];
        [action actionDescription].actionType = FLActionDescriptionTypeDownload;
        [action actionDescription].actionItemName = @"Profile Photo";

        FLFacebookLoadUserPictureOperation* operation = [FLFacebookLoadUserPictureOperation operation];
        [operation setUserId:post.from.id];
        [operation setPictureSize:FLFacebookLoadUserPictureOperationInputSizeSquare];
        [action addOperation:operation];
        
		[[FLActionContextManager instance].activeContext startAction:action completion: ^(id result) {
            self.thumbnailWidget.foregroundThumbnail =
                [[[action lastOperationOutput] imageFile] image];
            }]; 
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
//	_gradient.frame = self.frame;
//
//	_thumbnail.frame = FLRectSetOrigin(_thumbnail.frame, self.frame.origin.x + 5, self.frame.origin.y + 5);
//
//	CGFloat textWidth = FLRectGetRight(self.frame) - kBuffer - kTextLeft;
//
//	_userName.frame = CGRectMake(
//		kTextLeft,
//		kBuffer,
//		textWidth,
//		kUserNameHeight);
//		
//	_message.frame = CGRectMake(
//		kTextLeft,
//		kMessageTop,
//		textWidth,
//		[_message heightOfTextForWidth:textWidth]);
//	
//}

//+ (CGFloat) heightForRowWithWidth:(CGFloat) width andString:(NSString*) string
//{
//	CGFloat textWidth = width - kBuffer - kTextLeft;
//	FLTextDescriptor* desc = [FLThemeManager queryTheme:@selector(textDescriptorForMessageTextInTable)];
//	return kMessageTop + kBuffer +  [string sizeWithFont:desc.font
//									constrainedToSize:FLSizeMake(textWidth, 2048.0)
//									lineBreakMode:UILineBreakModeWordWrap].height;
//}

@end
#endif