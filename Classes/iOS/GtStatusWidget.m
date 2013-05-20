//
//  GtStatusWidget.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/18/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtStatusWidget.h"

#define kBuffer 10.f
#define kUserNameHeight 16.0f
#define kMessageTop 30.0f
#define kTextLeft 60
#define kThumbSideSize 40

#import "GtFacebookTheme.h" // TODO: remove this

@implementation GtStatusWidget


@synthesize gradientWidget = m_gradient;
@synthesize userNameWidget = m_userName;
@synthesize messageWidget = m_message;
@synthesize postedTimeWidget = m_postedTime;
@synthesize thumbnailWidget = m_thumbnail;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
//		self.viewLayout = [GtColumnViewLayout viewLayout];
//		self.viewLayout.padding =  UIEdgeInsets10;
//
//		m_gradient = [[GtGradientWidget alloc] initWithFrame:frame];
//		self.backgroundWidget = m_gradient;
//
//		m_thumbnail = [[GtThumbnailWidget alloc] initWithFrame:CGRectMake(0,0,kThumbSideSize,kThumbSideSize)];
////		m_thumbnail.backgroundThumbnail = [ZfAssetManager squareEmptyPhotoImage];
//		[self addSubwidget:m_thumbnail];
//
//		m_rightColumn = [GtWidget widget];
//		m_rightColumn.viewLayoutBehavior = GtViewLayoutBehaviorFlexibleWidth | GtViewLayoutBehaviorAdjustToSubviewHeightAfterLayout;
//		m_rightColumn.viewLayout = [GtRowViewLayout viewLayout];
//		m_rightColumn.viewLayout.padding = UIEdgeInsetsMake(0,10,0,10);
//		[self addSubwidget:m_rightColumn];
//
//		m_nameAndPostDateWidget = [GtWidget widgetWithFrame:CGRectMake(0,0,100, 20)];
//		m_nameAndPostDateWidget.viewLayout = [GtColumnViewLayout viewLayout];
//		[m_rightColumn addSubwidget:m_nameAndPostDateWidget];
//
//		m_userName = [[GtLabelWidget alloc] initWithFrame: CGRectMake(0,0,100,20)];
//		m_userName.themeAction = @selector(applyThemeToNameInTable:);
//		m_userName.viewLayoutBehavior = GtViewLayoutBehaviorFlexibleWidth;
//		[m_nameAndPostDateWidget addSubwidget:m_userName];
//		
//		m_postedTime = [[GtLabelWidget alloc] initWithFrame:CGRectMake(0,0,140,20)];
//		m_postedTime.textAlignment = UITextAlignmentRight;
//		m_postedTime.themeAction = @selector(applyThemeToMessageInTable:);
//		[m_nameAndPostDateWidget addSubwidget:m_postedTime];
//
//		m_message = [[GtLabelWidget alloc] initWithFrame: CGRectMake(0,0,100,20)];
//		m_message.themeAction = @selector(applyThemeToMessageInTable:);
////		m_message.viewLayoutCallback = ^(id layoutView, CGRect layoutFrame) {
////			return GtRectSetHeight(layoutFrame, [layoutView heightOfTextForWidth:layoutFrame.size.width]); 
////		};
//		[m_rightColumn addSubwidget:m_message];
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_rightColumn);
	GtRelease(m_nameAndPostDateWidget);
	GtRelease(m_gradient);
	GtRelease(m_thumbnail);
	GtRelease(m_userName);
	GtRelease(m_message);
	GtRelease(m_postedTime);
	GtSuperDealloc();
}

- (void) layoutSubwidgets
{
	[super layoutSubwidgets];
	
//	[self.viewLayout layoutView:self];
//	[m_rightColumn.viewLayout layoutView:self];
//	[m_nameAndPostDateWidget.viewLayout layoutView:self];
}

- (CGFloat) calculateRowHeightInTableView:(UITableView*) tableView withData:(id) data
{
	self.frame = GtRectSetSize(self.frame, tableView.frame.size.width, 60.0f);

	[self setNeedsLayout];
//	[self.viewLayout setViewSize:self];
	
//	CGFloat textWidth = width - kBuffer - kTextLeft;
//	GtTextDescriptor* desc = [GtThemeManager queryTheme:@selector(textDescriptorForMessageTextInTable)];
//	return kMessageTop + kBuffer +  [m_message.text sizeWithFont:desc.font
//									constrainedToSize:CGSizeMake(textWidth, 2048.0)
//									lineBreakMode:UILineBreakModeWordWrap].height;

	return self.frame.size.height;
}

//+ (CGFloat) heightForRowWithWidth:(CGFloat) width andString:(NSString*) string
//{
//	CGFloat textWidth = width - kBuffer - kTextLeft;
//	GtTextDescriptor* desc = [GtThemeManager queryTheme:@selector(textDescriptorForMessageTextInTable)];
//	return kMessageTop + kBuffer +  [string sizeWithFont:desc.font
//									constrainedToSize:CGSizeMake(textWidth, 2048.0)
//									lineBreakMode:UILineBreakModeWordWrap].height;
//}

@end

