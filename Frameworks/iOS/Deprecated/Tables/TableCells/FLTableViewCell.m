//
//	FLContentBehaviorTableViewCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/5/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLTableViewCell.h"
#import "FLTableView.h"


//#define kLayoutRectIndentHorizontal 10.0f
//#define kLayoutRectIndentVertical 10.0f

@implementation FLTableViewCell

@synthesize sectionMargins = _sectionMargins;
@synthesize sectionPadding = _sectionPadding;
@synthesize sectionWidget = _sectionWidget;
@synthesize accessoryWidget = _accessory;
@synthesize cellHeight = _cellHeight;

@synthesize customAccessoryType = _customAccessoryType;
@synthesize customSelectionStyle = _customSelectionStyle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]))
	{
        self.wantsApplyTheme = YES;

		self.alpha = 1.0;
		self.opaque = YES;
		self.autoresizesSubviews = NO;
		_customAccessoryType = UITableViewCellAccessoryNone;
		_customSelectionStyle = UITableViewCellSelectionStyleNone;
		
		_sectionWidget = [[FLTableViewCellSectionWidget alloc] initWithFrame:CGRectZero];
		[self addWidget:_sectionWidget];
        
		self.contentView.backgroundColor = [UIColor clearColor];
		self.contentView.hidden = YES;
	}
	
	return self;
}

- (void) setAccessoryWidget:(FLTableViewCellAccessoryWidget*) widget
{
    if(_accessory)
    {
        [_accessory removeFromParent];
    }
    
    FLSetObjectWithRetain(_accessory, widget);
    [self addWidget:_accessory];
}

- (BOOL) willDrawSection
{
	return _widgetCellState.tableWantsBorder;
}

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
	return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
}

+ (id) tableViewCell:(NSString *)reuseIdentifier
{
	return FLAutorelease([[[self class] alloc] initWithReuseIdentifier:reuseIdentifier]);
}

- (BOOL) disabled
{
	return _widgetCellState.disabled;
}

- (void) enabledStateDidChange
{
	[self setNeedsLayout];
}

- (void) setDisabled:(BOOL) disabled
{
//	  if(enabled != _tableCellFlags.enabled)
	{
		_widgetCellState.disabled = disabled;
		[self enabledStateDidChange];
		
		if(self.label)
		{
			self.label.enabled = !disabled;
		}		 
		
		if(disabled && self.accessoryWidget.type == UITableViewCellAccessoryDisclosureIndicator)
		{
			self.accessoryWidget.hidden = YES;
		}
		else
		{
			self.accessoryWidget.hidden = NO;
		}
	}
}

- (void) setAccessoryType:(UITableViewCellAccessoryType) type
{
	if(_customAccessoryType != type)
	{
		_customAccessoryType = type;

		[super setAccessoryType:type == UITableViewCellAccessoryDetailDisclosureButton ? UITableViewCellAccessoryDetailDisclosureButton : UITableViewCellAccessoryNone];
		
		if(type != UITableViewCellAccessoryNone && !_accessory)
		{
			self.accessoryWidget = FLAutorelease([[FLTableViewCellAccessoryWidget alloc] init]);
		}

		if(_accessory)
		{
			_accessory.type = type;
			[self setNeedsLayout];
		}
	}
}

- (void) setCustomAccessoryType:(UITableViewCellAccessoryType)accessoryType
{
    self.accessoryType = accessoryType;
}

- (void) setSelectionStyle:(UITableViewCellSelectionStyle) style
{
	[super setSelectionStyle:UITableViewCellSelectionStyleNone];
	_customSelectionStyle = style;
}

- (void) setCustomSelectionStyle:(UITableViewCellSelectionStyle)customSelectionStyle
{
    self.selectionStyle = customSelectionStyle;
}

- (void) dealloc {
	FLRelease(_replacementLabel);
	FLRelease(_sectionWidget);
	FLRelease(_background);
	FLRelease(_accessory);
	FLRelease(_widget);
	FLSuperDealloc();
}

- (void) didMoveToSuperview
{
	[super didMoveToSuperview];
	if(self.superview)
	{
		[self applyThemeIfNeeded];
	}
}

- (void) updateWidgetFrames
{
	CGRect frame = self.bounds;
	frame = FLRectInsetRight(frame, self.sectionMargins.right);
	frame = FLRectInsetLeft(frame, self.sectionMargins.left);
	_sectionWidget.frame = frame;
	[_sectionWidget setNeedsLayout];

	if(_accessory)
	{
		[_accessory resizeToAccessorySize];
		
		_accessory.frameOptimizedForLocation = FLRectSetLeft(
			FLRectCenterRectInRectVertically(_sectionWidget.frame, _accessory.frame),
			FLRectGetRight(_sectionWidget.frame) - _accessory.frame.size.width - (self.willDrawSection ? _sectionPadding.right : 10.0f));
			
		[_accessory setNeedsLayout];
	}
	
	
	// TODO: pay attention to locationMOde
	_widget.frame = self.bounds;
	[_widget setNeedsLayout];
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	if(self.superview)
	{
		[self updateWidgetFrames];		  
		[self positionAndSizeTextLabel];
	}
}

- (void) calculateCellHeightInTable:(UITableView *)tableView
{
	[self updateWidgetFrames];		  

	if(_replacementLabel)
	{
		[self updateTextLabelSizeWithLayoutRectWidth:[self layoutRectWidthFromTableView:tableView]];
		CGFloat height = self.label.frame.size.height + self.sectionMargins.top + self.sectionMargins.bottom;
		if(self.willDrawSection)
		{
			height += self.sectionPadding.top + self.sectionPadding.bottom; 
		}
		self.cellHeight = height;
	}
}

+ (CGSize) calculateLabelSize:(UILabel*) label
	layoutRectWidth:(CGFloat) layoutRectWidth
	returnValidHeight:(BOOL) returnValidHeight
{
	if(label)
	{
		NSString* text = label.text;
		if(returnValidHeight && FLStringIsEmpty(text))
		{
			text = @"Ty";
		}
		
		FLAssertIsNotNil_(label.font);
		
		CGSize textSize = [text sizeWithFont:label.font
							constrainedToSize:CGSizeMake(layoutRectWidth,CGFLOAT_MAX)
							lineBreakMode:label.lineBreakMode];
		
		textSize.height += 2;
		
		return textSize;
	}
	
	return CGSizeZero;
}

- (void) updateTextLabelSizeWithLayoutRectWidth:(CGFloat) layoutRectWidth
{
	if(_replacementLabel)
	{
		CGSize size = [FLTableViewCell calculateLabelSize:_replacementLabel layoutRectWidth:layoutRectWidth returnValidHeight:YES];
		_replacementLabel.frameOptimizedForLocation = FLRectSetSize(_replacementLabel.frame, layoutRectWidth, size.height);
	}
}

- (CGSize) textLabelSizeForContentViewWidth:(CGFloat) width
{
	return [FLTableViewCell calculateLabelSize:self.label layoutRectWidth:width returnValidHeight:NO];
}
- (void) drawRect:(CGRect) rect
{
	[super drawRect:rect];
	
	if(_sectionWidget)
	{
		[_sectionWidget drawWidget:rect];
	}

//    if(_widget)
//    {
//        [_widget drawWidget:rect];
//    }
	
	if(!self.isEditing)
	{
		if(_accessory && CGRectIntersectsRect(rect, _accessory.frame))
		{
			_accessory.color= _sectionWidget.borderColor;
			_accessory.highlightedColor = [UIColor whiteColor];
			[_accessory drawWidget:rect];
		}
	}
    
}

- (FLWidget*) widget
{
	return _widget;
}

- (void) setWidget:(FLWidget*) widget
{
	if(_widget)
	{
		[_widget removeFromParent];
	}
    
	FLSetObjectWithRetain(_widget, widget);
	[_sectionWidget addWidget:_widget];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
	[super setHighlighted:highlighted animated:animated];
	
	if(_customSelectionStyle != UITableViewCellSelectionStyleNone)
	{
		_sectionWidget.highlighted = highlighted;
		_accessory.highlighted = highlighted;
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	
	if(_customSelectionStyle != UITableViewCellSelectionStyleNone)
	{
		_sectionWidget.selected = selected;
		_accessory.selected = selected;
	}
}

- (CGFloat) calculateRowHeightInTableView:(UITableView*) tableView withData:(id) data
{
	[self calculateCellHeightInTable:tableView];
	return self.cellHeight;
}

- (void) willShowInTable:(FLTableView*) tableView atIndexPath:(NSIndexPath*) indexPath
{
	if(!self.cellHeight)
	{
		self.cellHeight = tableView.rowHeight;
	}

	self.sectionMargins = tableView.sectionMargins;
	self.sectionPadding = tableView.sectionPadding;
	_widgetCellState.tableWantsBorder = tableView.drawSectionBorders;

	self.sectionWidget.separatorLine = tableView.cellSeparatorLine;
	
	if(self.willDrawSection)
	{
		BOOL isLast = (indexPath.row == (NSIndexPathRowType) ([tableView.dataSource tableView:tableView numberOfRowsInSection:indexPath.section] - 1));
		
		if(indexPath.row == 0)
		{
			if(isLast)
			{
				self.sectionWidget.positionInSection = FLTableViewCellSectionWidgetPositionInSectionAll;
			}
			else
			{
				self.sectionWidget.positionInSection = FLTableViewCellSectionWidgetPositionInSectionTop;
			}
		}
		else if (isLast)
		{
			self.sectionWidget.positionInSection = FLTableViewCellSectionWidgetPositionInSectionBottom;
		}
		else
		{
			self.sectionWidget.positionInSection = FLTableViewCellSectionWidgetPositionInSectionMiddle;
		}
	}
	else 
	{
		self.sectionWidget.positionInSection = FLTableViewCellSectionWidgetPositionInSectionNone;
	}
	
	[self setNeedsLayout];
}

- (CGRect) layoutRect
{
	CGRect layout = _sectionWidget.frame;
	if(self.willDrawSection)
	{
		layout = FLRectInsetLeft(layout, self.sectionPadding.left);
		layout = FLRectInsetRight(layout, self.sectionPadding.right);
		layout = FLRectInsetTop(layout, self.sectionPadding.top);
		layout = FLRectInsetBottom(layout, self.sectionPadding.bottom);
	}
	return layout; 
}

- (CGFloat) layoutRectWidthFromTableView:(UITableView*) tableView
{
	CGFloat width = tableView.frame.size.width - self.sectionMargins.left - self.sectionMargins.right;
	if(self.willDrawSection)
	{
		width -= self.sectionPadding.left - self.sectionPadding.right;
	}

	return width;
}

- (void) applyTheme:(FLTheme*) theme {
// 	label.textDescriptor = self.titleDescriptor;
}

- (FLLabel*) label
{
	if(!_replacementLabel)
	{
		_replacementLabel = [[FLLabel alloc] initWithFrame:CGRectZero];
		_replacementLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
		_replacementLabel.backgroundColor = [UIColor clearColor];
		_replacementLabel.autoresizingMask = UIViewAutoresizingNone;
		[self addSubview:_replacementLabel];
	}
	
	return _replacementLabel;
}

- (NSString*) textLabelText
{
	return self.label.text;
}

- (void) setTextLabelText:(NSString*) banner
{
	self.label.text = banner;
}

- (void) positionAndSizeTextLabel
{
	if(_replacementLabel)
	{
		CGRect layoutRect = self.layoutRect;
		[self updateTextLabelSizeWithLayoutRectWidth:layoutRect.size.width];
		self.label.frameOptimizedForLocation = 
			FLRectSetLeft(FLRectCenterRectInRectVertically(layoutRect, self.label.frame), layoutRect.origin.x);
	}
}

@end

@implementation FLSimpleTextItemTableViewCell
- (void) positionAndSizeTextLabel
{
	if(self.label)
	{
		CGRect layoutRect = self.layoutRect;
		[self updateTextLabelSizeWithLayoutRectWidth:layoutRect.size.width];
		self.label.frameOptimizedForLocation = 
			FLRectSetLeft(FLRectCenterRectInRectVertically(layoutRect, self.label.frame), layoutRect.origin.x + 10.0f);
	}
}
@end

