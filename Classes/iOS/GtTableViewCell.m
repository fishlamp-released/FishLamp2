//
//	GtContentBehaviorTableViewCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/5/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTableViewCell.h"
#import "GtTableView.h"


//#define kLayoutRectIndentHorizontal 10.0f
//#define kLayoutRectIndentVertical 10.0f

@implementation GtTableViewCell

GtSynthesizeStructProperty(wasThemed, setWasThemed, BOOL, m_themeState);
GtSynthesizeStructProperty(themeAction, setThemeAction, SEL, m_themeState);

@synthesize sectionMargins = m_sectionMargins;
@synthesize sectionPadding = m_sectionPadding;
@synthesize sectionWidget = m_sectionWidget;
@synthesize accessoryWidget = m_accessory;
@synthesize cellHeight = m_cellHeight;

@synthesize customAccessoryType = m_customAccessoryType;
@synthesize customSelectionStyle = m_customSelectionStyle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]))
	{
		self.alpha = 1.0;
		self.opaque = YES;
		self.autoresizesSubviews = NO;
		m_customAccessoryType = UITableViewCellAccessoryNone;
		m_customSelectionStyle = UITableViewCellSelectionStyleNone;
		
		m_sectionWidget = [[GtTableViewCellSectionWidget alloc] initWithFrame:CGRectZero];
		
		self.contentView.backgroundColor = [UIColor clearColor];
		self.contentView.hidden = YES;
	}
	
	return self;
}

- (BOOL) willDrawSection
{
	return m_widgetCellState.tableWantsBorder;
}

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
	return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
}

+ (id) tableViewCell:(NSString *)reuseIdentifier
{
	return GtReturnAutoreleased([[[self class] alloc] initWithReuseIdentifier:reuseIdentifier]);
}

- (BOOL) disabled
{
	return m_widgetCellState.disabled;
}

- (void) enabledStateDidChange
{
	[self setNeedsLayout];
}

- (void) setDisabled:(BOOL) disabled
{
//	  if(enabled != m_tableCellFlags.enabled)
	{
		m_widgetCellState.disabled = disabled;
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
	if(m_customAccessoryType != type)
	{
		m_customAccessoryType = type;

		[super setAccessoryType:type == UITableViewCellAccessoryDetailDisclosureButton ? UITableViewCellAccessoryDetailDisclosureButton : UITableViewCellAccessoryNone];
		
		if(type != UITableViewCellAccessoryNone && !m_accessory)
		{
			m_accessory = [[GtTableViewCellAccessoryWidget alloc] init];
			[self addWidget:m_accessory];
		}

		if(m_accessory)
		{
			m_accessory.type = type;
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
	m_customSelectionStyle = style;
}

- (void) setCustomSelectionStyle:(UITableViewCellSelectionStyle)customSelectionStyle
{
    self.selectionStyle = customSelectionStyle;
}

- (void) dealloc
{
	[m_widget teardown];
	[m_accessory teardown];
	[m_sectionWidget teardown];
	GtRelease(m_textLabel);
	GtRelease(m_sectionWidget);
	GtRelease(m_background);
	GtRelease(m_accessory);
	GtRelease(m_widget);
	GtSuperDealloc();
}

- (void) didMoveToSuperview
{
	[super didMoveToSuperview];
	if(self.superview)
	{
		[self applyTheme];
	}
}

- (void) updateWidgetFrames
{
	CGRect frame = self.bounds;
	frame = GtRectInsetRight(frame, self.sectionMargins.right);
	frame = GtRectInsetLeft(frame, self.sectionMargins.left);
	m_sectionWidget.frame = frame;
	[m_sectionWidget setNeedsLayout];

	if(m_accessory)
	{
		[m_accessory resizeToAccessorySize];
		
		m_accessory.frameOptimizedForLocation = GtRectSetLeft(
			GtRectCenterRectInRectVertically(m_sectionWidget.frame, m_accessory.frame),
			GtRectGetRight(m_sectionWidget.frame) - m_accessory.frame.size.width - (self.willDrawSection ? m_sectionPadding.right : 10.0f));
			
		[m_accessory setNeedsLayout];
	}
	
	
	// TODO: pay attention to locationMOde
	m_widget.frame = self.bounds;
	[m_widget setNeedsLayout];
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

	if(m_textLabel)
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
		if(returnValidHeight && GtStringIsEmpty(text))
		{
			text = @"Ty";
		}
		
		GtAssertNotNil(label.font);
		
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
	if(m_textLabel)
	{
		CGSize size = [GtTableViewCell calculateLabelSize:m_textLabel layoutRectWidth:layoutRectWidth returnValidHeight:YES];
		m_textLabel.frameOptimizedForLocation = GtRectSetSize(m_textLabel.frame, layoutRectWidth, size.height);
	}
}

- (CGSize) textLabelSizeForContentViewWidth:(CGFloat) width
{
	return [GtTableViewCell calculateLabelSize:self.label layoutRectWidth:width returnValidHeight:NO];
}
- (void) drawRect:(CGRect) rect
{
	[super drawRect:rect];
	
	if(m_sectionWidget)
	{
		[m_sectionWidget drawInRect:rect];
	}
	
	if(!self.isEditing)
	{
		if(m_accessory && CGRectIntersectsRect(rect, m_accessory.frame))
		{
			m_accessory.color= m_sectionWidget.borderColor;
			m_accessory.highlightedColor = [UIColor whiteColor];
			[m_accessory drawInRect:rect];
		}
	}
}

- (GtWidget*) widget
{
	return m_widget;
}

- (void) setWidget:(GtWidget*) widget
{
	if(m_widget)
	{
		[m_widget removeFromParent];
	}

	GtAssignObject(m_widget, widget);
	[m_sectionWidget addSubwidget:m_widget];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
	[super setHighlighted:highlighted animated:animated];
	
	if(m_customSelectionStyle != UITableViewCellSelectionStyleNone)
	{
		m_sectionWidget.highlighted = highlighted;
		m_accessory.highlighted = highlighted;
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	
	if(m_customSelectionStyle != UITableViewCellSelectionStyleNone)
	{
		m_sectionWidget.selected = selected;
		m_accessory.selected = selected;
	}
}

- (CGFloat) calculateRowHeightInTableView:(UITableView*) tableView withData:(id) data
{
	[self calculateCellHeightInTable:tableView];
	return self.cellHeight;
}

- (void) willShowInTable:(GtTableView*) tableView atIndexPath:(NSIndexPath*) indexPath
{
	if(!self.cellHeight)
	{
		self.cellHeight = tableView.rowHeight;
	}

	self.sectionMargins = tableView.sectionMargins;
	self.sectionPadding = tableView.sectionPadding;
	m_widgetCellState.tableWantsBorder = tableView.drawSectionBorders;

	self.sectionWidget.separatorLine = tableView.cellSeparatorLine;
	
	if(self.willDrawSection)
	{
		BOOL isLast = (indexPath.row == (NSIndexPathRowType) ([tableView.dataSource tableView:tableView numberOfRowsInSection:indexPath.section] - 1));
		
		if(indexPath.row == 0)
		{
			if(isLast)
			{
				self.sectionWidget.positionInSection = GtTableViewCellSectionWidgetPositionInSectionAll;
			}
			else
			{
				self.sectionWidget.positionInSection = GtTableViewCellSectionWidgetPositionInSectionTop;
			}
		}
		else if (isLast)
		{
			self.sectionWidget.positionInSection = GtTableViewCellSectionWidgetPositionInSectionBottom;
		}
		else
		{
			self.sectionWidget.positionInSection = GtTableViewCellSectionWidgetPositionInSectionMiddle;
		}
	}
	else 
	{
		self.sectionWidget.positionInSection = GtTableViewCellSectionWidgetPositionInSectionNone;
	}
	
	[self setNeedsLayout];
}

- (CGRect) layoutRect
{
	CGRect layout = m_sectionWidget.frame;
	if(self.willDrawSection)
	{
		layout = GtRectInsetLeft(layout, self.sectionPadding.left);
		layout = GtRectInsetRight(layout, self.sectionPadding.right);
		layout = GtRectInsetTop(layout, self.sectionPadding.top);
		layout = GtRectInsetBottom(layout, self.sectionPadding.bottom);
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

- (GtLabel*) label
{
	if(!m_textLabel)
	{
		m_textLabel = [[GtLabel alloc] initWithFrame:CGRectZero];
		m_textLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
		m_textLabel.backgroundColor = [UIColor clearColor];
		m_textLabel.autoresizingMask = UIViewAutoresizingNone;
		m_textLabel.themeAction = @selector(applyThemeToTableViewCellTitleLabel:);
		[self addSubview:m_textLabel];
	}
	
	return m_textLabel;
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
	if(m_textLabel)
	{
		CGRect layoutRect = self.layoutRect;
		[self updateTextLabelSizeWithLayoutRectWidth:layoutRect.size.width];
		self.label.frameOptimizedForLocation = 
			GtRectSetLeft(GtRectCenterRectInRectVertically(layoutRect, self.label.frame), layoutRect.origin.x);
	}
}

@end

@implementation GtSimpleTextItemTableViewCell
- (void) positionAndSizeTextLabel
{
	if(self.label)
	{
		CGRect layoutRect = self.layoutRect;
		[self updateTextLabelSizeWithLayoutRectWidth:layoutRect.size.width];
		self.label.frameOptimizedForLocation = 
			GtRectSetLeft(GtRectCenterRectInRectVertically(layoutRect, self.label.frame), layoutRect.origin.x + 10.0f);
	}
}
@end

