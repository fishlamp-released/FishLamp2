//
//	GtCheckMarkedTableCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/15/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtCheckMarkTableViewCell.h"
#import "GtGeometry.h"
#import "GtCheckMarkGroup.h"

#import "UIImage+GtColorize.h"

@implementation GtCheckMarkTableViewCell

@synthesize checked = m_checked;
@synthesize checkMarkGroup = m_group;
@synthesize checkedValue = m_checkedValue;

- (void) dealloc
{	
	GtRelease(m_group);
	GtRelease(m_checkedValue);
//	  GtRelease(m_checkMark);
	GtRelease(m_subLabel);
	GtSuperDealloc();
}

- (void) initSubLabel
{
	m_subLabel = [[GtLabel alloc] initWithFrame:CGRectZero];
	m_subLabel.font	 = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
	m_subLabel.textColor = [UIColor grayColor];
	m_subLabel.backgroundColor = [UIColor clearColor];
	[self addSubview:m_subLabel];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{	
		self.accessoryType = UITableViewCellAccessoryNone;
		self.selectionStyle = UITableViewCellSelectionStyleBlue;
		[self initSubLabel];
	}
	
	return self;
}

- (void) calculateCellHeightInTable:(UITableView *)tableView
{
	self.cellHeight = 50.0f; // DeviceIsPad() ? 50.0 : 36.0f; // TODO: set with theme.
}

+ (id) checkMarkedTableCell:(NSString*) labelOrNil checked:(BOOL) checked checkedValue:(id) checkedValue
{
	GtCheckMarkTableViewCell* cell = GtReturnAutoreleased([[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GtCheckMarkedTableCell"]);
	if(GtStringIsNotEmpty(labelOrNil))
	{
		cell.textLabelText = labelOrNil;
	}
	cell.checkedValue = checkedValue;
	cell.checked = checked;
	return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

	[super setSelected:selected animated:animated];

	if(selected && self.canEditData)
	{
		self.checked = YES;
	}
}

#define SUBLABEL_INDENT 40

- (void) _showCheckMark:(BOOL) checked
{
	if(checked)
	{
		self.label.selected = YES;
		self.accessoryType = UITableViewCellAccessoryCheckmark;
		
	}
	else
	{
		self.label.selected = NO;
		self.accessoryType = UITableViewCellAccessoryNone;
	}
}

- (void) updateCellState
{
	if(self.dataSource)
	{
		self.checked = [self.dataSourceObject isEqual:m_checkedValue];
	} 
}

- (void) layoutSubviews
{
	[super layoutSubviews];

	[self _showCheckMark:self.checked];
	
	if(m_subLabel.text.length > 0)
	{
		CGRect subLabelFrame = self.layoutRect;
		subLabelFrame.origin.x += SUBLABEL_INDENT;
		subLabelFrame.size.width -= SUBLABEL_INDENT;
		subLabelFrame.size.height = 18;
		subLabelFrame.origin.y = self.frame.size.height - subLabelFrame.size.height;
		
		m_subLabel.frameOptimizedForSize = subLabelFrame;
	
		CGRect textFrame = self.label.frame;
		textFrame.origin.y -= 4;
		self.label.frameOptimizedForSize = textFrame;
	}
}

- (BOOL) checked
{
	return m_checked;
}

- (void) setChecked:(BOOL) checked
{
	m_checked = checked;
	if(m_checked)
	{
		if(self.dataSource)
		{
			self.dataSourceObject = self.checkedValue;
		}
		if(m_group)
        {
            [m_group checkMarkWasSelected:self];
        }
	}
	[self setNeedsLayout];
}

- (NSString*) subText
{
	return m_subLabel.text;
}

- (void) setSubText:(NSString*) subText
{
	m_subLabel.text = subText;
}

@end


@implementation GtCircleView

@synthesize borderWidth = m_borderWidth;
@synthesize borderColor = m_color;

- (void) drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

	[self.borderColor setStroke];
	
    CGContextSetLineWidth(context, self.borderWidth);
    CGContextStrokeEllipseInRect(context, CGRectInset(self.bounds, self.borderWidth, self.borderWidth));    
            	
    CGContextRestoreGState(context);
}

- (void) dealloc
{
	GtRelease(m_color);
	GtSuperDealloc();
}
@end

@implementation GtOnOffCheckMarkTableViewCell

@synthesize checked = m_checked;

- (void) calculateCellHeightInTable:(UITableView *)tableView
{
	self.cellHeight = 50.0f; // DeviceIsPad() ? 50.0 : 36.0f; // TODO: set with theme.
}

+ (id) onOffCheckMarkTableViewCell:(NSString*) labelOrNil
{
	GtOnOffCheckMarkTableViewCell* cell = GtReturnAutoreleased([[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GtCheckMarkedTableCell"]);
	if(GtStringIsNotEmpty(labelOrNil))
	{
		cell.textLabelText = labelOrNil;
	}
	return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

	[super setSelected:selected animated:animated];

	if(selected && self.canEditData)
	{
		self.checked = !self.checked;
	}
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{	
        self.accessoryType = UITableViewCellAccessoryNone;
		self.selectionStyle = UITableViewCellSelectionStyleBlue;
	
        m_check = [[UIImageView alloc] initWithImage:[UIImage whiteImageNamed:@"check.png"]];
        m_check.hidden = YES;
        [m_check resizeToImageSize];
        [self addSubview:m_check];
        
        m_circle = [[GtCircleView alloc] initWithFrame:CGRectMake(0,0,34,30)];
        m_circle.backgroundColor = [UIColor clearColor];
        m_circle.borderColor = [UIColor grayColor];
        m_circle.borderWidth = 2.0f;
        [self addSubview:m_circle];
    }
	
	return self;
}

- (void) dealloc
{
    GtRelease(m_check);
    GtSuperDealloc();
}

#define kTextLeft 60.0f
#define kLeftBuffer 0.0f

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect layoutRect = self.layoutRect;
	m_circle.frameOptimizedForSize = GtRectCenterRectInRectVertically(layoutRect, GtRectSetLeft(m_circle.frame, layoutRect.origin.x + kLeftBuffer));
    m_check.frame = GtRectCenterRectInRect(m_circle.frame, m_check.frame); 
        
    self.label.frameOptimizedForSize = GtRectCenterRectInRectVertically(layoutRect, GtRectSetLeft(self.label.frame, kTextLeft));
}

- (void) setChecked:(BOOL) checked
{
    m_checked = checked;
    if(self.dataSource)
    {
        self.dataSourceObject = [NSNumber numberWithBool:m_checked];
    }
    m_check.hidden = !self.isChecked;

   	[self setNeedsLayout];
}

- (void) updateCellState
{
    if(self.dataSource)
	{
		self.checked = [self.dataSourceObject isEqual:[NSNumber numberWithBool:YES]];
	} 
}


@end

