//
//  FLStatusWidget.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/18/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLStatusWidget.h"

#define kBuffer 10.f
#define kUserNameHeight 16.0f
#define kMessageTop 30.0f
#define kTextLeft 60
#define kThumbSideSize 40

#import "FLFacebookTheme.h" // TODO: remove this

@implementation FLStatusWidget


@synthesize gradientWidget = m_gradient;
@synthesize userNameWidget = m_userName;
@synthesize messageWidget = m_message;
@synthesize postedTimeWidget = m_postedTime;
@synthesize thumbnailWidget = m_thumbnail;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
//		self.subviewArrangement = [FLColumnArrangement arrangement];
//		self.subviewArrangement.padding =  FLEdgeInsets10;
//
//		m_gradient = [[FLGradientWidget alloc] initWithFrame:frame];
//		self.backgroundWidget = m_gradient;
//
//		m_thumbnail = [[FLThumbnailWidget alloc] initWithFrame:CGRectMake(0,0,kThumbSideSize,kThumbSideSize)];
////		m_thumbnail.backgroundThumbnail = [ZfAssetManager squareEmptyPhotoImage];
//		[self addWidget:m_thumbnail];
//
//		m_rightColumn = [FLWidget widget];
//		m_rightColumn.viewLayoutBehavior = FLArrangementBehaviorFlexibleWidth | FLArrangementBehaviorAdjustToSubviewHeightAfterLayout;
//		m_rightColumn.subviewArrangement = [FLSingleRowColumnArrangement arrangement];
//		m_rightColumn.subviewArrangement.padding = UIEdgeInsetsMake(0,10,0,10);
//		[self addWidget:m_rightColumn];
//
//		m_nameAndPostDateWidget = [FLWidget widgetWithFrame:CGRectMake(0,0,100, 20)];
//		m_nameAndPostDateWidget.subviewArrangement = [FLColumnArrangement arrangement];
//		[m_rightColumn addWidget:m_nameAndPostDateWidget];
//
//		m_userName = [[FLLabelWidget alloc] initWithFrame: CGRectMake(0,0,100,20)];
//		m_userName.themeAction = @selector(applyThemeToNameInTable:);
//		m_userName.viewLayoutBehavior = FLArrangementBehaviorFlexibleWidth;
//		[m_nameAndPostDateWidget addWidget:m_userName];
//		
//		m_postedTime = [[FLLabelWidget alloc] initWithFrame:CGRectMake(0,0,140,20)];
//		m_postedTime.textAlignment = UITextAlignmentRight;
//		m_postedTime.themeAction = @selector(applyThemeToMessageInTable:);
//		[m_nameAndPostDateWidget addWidget:m_postedTime];
//
//		m_message = [[FLLabelWidget alloc] initWithFrame: CGRectMake(0,0,100,20)];
//		m_message.themeAction = @selector(applyThemeToMessageInTable:);
////		m_message.viewLayoutCallback = ^(id layoutView, CGRect layoutFrame) {
////			return FLRectSetHeight(layoutFrame, [layoutView heightOfTextForWidth:layoutFrame.size.width]); 
////		};
//		[m_rightColumn addWidget:m_message];
	}
	
	return self;
}

- (void) dealloc
{
	FLRelease(m_rightColumn);
	FLRelease(m_nameAndPostDateWidget);
	FLRelease(m_gradient);
	FLRelease(m_thumbnail);
	FLRelease(m_userName);
	FLRelease(m_message);
	FLRelease(m_postedTime);
	FLSuperDealloc();
}

- (void) layoutWidgets
{
	[super layoutWidgets];
	
//	[self.subviewArrangement layoutView:self];
//	[m_rightColumn.subviewArrangement layoutView:self];
//	[m_nameAndPostDateWidget.subviewArrangement layoutView:self];
}

- (CGFloat) calculateRowHeightInTableView:(UITableView*) tableView withData:(id) data
{
	self.frame = FLRectSetSize(self.frame, tableView.frame.size.width, 60.0f);

	[self setNeedsLayout];
//	[self.subviewArrangement setViewSize:self];
	
//	CGFloat textWidth = width - kBuffer - kTextLeft;
//	FLTextDescriptor* desc = [FLThemeManager queryTheme:@selector(textDescriptorForMessageTextInTable)];
//	return kMessageTop + kBuffer +  [m_message.text sizeWithFont:desc.font
//									constrainedToSize:CGSizeMake(textWidth, 2048.0)
//									lineBreakMode:UILineBreakModeWordWrap].height;

	return self.frame.size.height;
}

//+ (CGFloat) heightForRowWithWidth:(CGFloat) width andString:(NSString*) string
//{
//	CGFloat textWidth = width - kBuffer - kTextLeft;
//	FLTextDescriptor* desc = [FLThemeManager queryTheme:@selector(textDescriptorForMessageTextInTable)];
//	return kMessageTop + kBuffer +  [string sizeWithFont:desc.font
//									constrainedToSize:CGSizeMake(textWidth, 2048.0)
//									lineBreakMode:UILineBreakModeWordWrap].height;
//}

@end

