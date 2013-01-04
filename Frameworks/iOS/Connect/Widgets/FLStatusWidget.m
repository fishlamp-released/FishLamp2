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


@synthesize gradientWidget = _gradient;
@synthesize userNameWidget = _userName;
@synthesize messageWidget = _message;
@synthesize postedTimeWidget = _postedTime;
@synthesize thumbnailWidget = _thumbnail;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
//		self.arrangement = [FLColumnArrangement arrangement];
//		self.arrangement.padding =  FLEdgeInsets10;
//
//		_gradient = [[FLGradientWidget alloc] initWithFrame:frame];
//		self.backgroundWidget = _gradient;
//
//		_thumbnail = [[FLThumbnailWidget alloc] initWithFrame:CGRectMake(0,0,kThumbSideSize,kThumbSideSize)];
////		_thumbnail.backgroundThumbnail = [ZfAssetManager squareEmptyPhotoImage];
//		[self addWidget:_thumbnail];
//
//		_rightColumn = [FLWidget widget];
//		_rightColumn.viewLayoutBehavior = FLArrangementBehaviorFlexibleWidth | FLArrangementBehaviorAdjustToSubviewHeightAfterLayout;
//		_rightColumn.arrangement = [FLSingleRowColumnArrangement arrangement];
//		_rightColumn.arrangement.padding = UIEdgeInsetsMake(0,10,0,10);
//		[self addWidget:_rightColumn];
//
//		_nameAndPostDateWidget = [FLWidget widgetWithFrame:CGRectMake(0,0,100, 20)];
//		_nameAndPostDateWidget.arrangement = [FLColumnArrangement arrangement];
//		[_rightColumn addWidget:_nameAndPostDateWidget];
//
//		_userName = [[FLLabelWidget alloc] initWithFrame: CGRectMake(0,0,100,20)];
//		_userName.themeAction = @selector(applyThemeToNameInTable:);
//		_userName.viewLayoutBehavior = FLArrangementBehaviorFlexibleWidth;
//		[_nameAndPostDateWidget addWidget:_userName];
//		
//		_postedTime = [[FLLabelWidget alloc] initWithFrame:CGRectMake(0,0,140,20)];
//		_postedTime.textAlignment = UITextAlignmentRight;
//		_postedTime.themeAction = @selector(applyThemeToMessageInTable:);
//		[_nameAndPostDateWidget addWidget:_postedTime];
//
//		_message = [[FLLabelWidget alloc] initWithFrame: CGRectMake(0,0,100,20)];
//		_message.themeAction = @selector(applyThemeToMessageInTable:);
////		_message.viewLayoutCallback = ^(id layoutView, CGRect layoutFrame) {
////			return FLRectSetHeight(layoutFrame, [layoutView heightOfTextForWidth:layoutFrame.size.width]); 
////		};
//		[_rightColumn addWidget:_message];
	}
	
	return self;
}

- (void) dealloc
{
	FLRelease(_rightColumn);
	FLRelease(_nameAndPostDateWidget);
	FLRelease(_gradient);
	FLRelease(_thumbnail);
	FLRelease(_userName);
	FLRelease(_message);
	FLRelease(_postedTime);
	FLSuperDealloc();
}

- (void) layoutSubWidgets
{
	[super layoutSubWidgets];
	
//	[self.arrangement layoutView:self];
//	[_rightColumn.arrangement layoutView:self];
//	[_nameAndPostDateWidget.arrangement layoutView:self];
}

- (CGFloat) calculateRowHeightInTableView:(UITableView*) tableView withData:(id) data
{
	self.frame = FLRectSetSize(self.frame, tableView.frame.size.width, 60.0f);

	[self setNeedsLayout];
//	[self.arrangement setViewSize:self];
	
//	CGFloat textWidth = width - kBuffer - kTextLeft;
//	FLTextDescriptor* desc = [FLThemeManager queryTheme:@selector(textDescriptorForMessageTextInTable)];
//	return kMessageTop + kBuffer +  [_message.text sizeWithFont:desc.font
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

