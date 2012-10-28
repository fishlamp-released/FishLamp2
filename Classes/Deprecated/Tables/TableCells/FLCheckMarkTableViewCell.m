//
//	FLCheckMarkedTableCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/15/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLCheckMarkTableViewCell.h"
#import "FLGeometry.h"
#import "FLCheckMarkGroup.h"

#import "FLImage+Colorize.h"

@implementation FLCheckMarkTableViewCell

@synthesize checked = _checked;
@synthesize checkMarkGroup = _group;
@synthesize checkedValue = _checkedValue;

- (void) dealloc
{	
	FLRelease(_group);
	FLRelease(_checkedValue);
//	  FLRelease(_checkMark);
	FLRelease(_subLabel);
	FLSuperDealloc();
}

- (void) initSubLabel
{
	_subLabel = [[FLLabel alloc] initWithFrame:CGRectZero];
	_subLabel.font	 = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
	_subLabel.textColor = [UIColor grayColor];
	_subLabel.backgroundColor = [UIColor clearColor];
	[self addSubview:_subLabel];
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
	FLCheckMarkTableViewCell* cell = FLReturnAutoreleased([[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FLCheckMarkedTableCell"]);
	if(FLStringIsNotEmpty(labelOrNil))
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
		self.checked = [self.dataSourceObject isEqual:_checkedValue];
	} 
}

- (void) layoutSubviews
{
	[super layoutSubviews];

	[self _showCheckMark:self.checked];
	
	if(_subLabel.text.length > 0)
	{
		FLRect subLabelFrame = self.layoutRect;
		subLabelFrame.origin.x += SUBLABEL_INDENT;
		subLabelFrame.size.width -= SUBLABEL_INDENT;
		subLabelFrame.size.height = 18;
		subLabelFrame.origin.y = self.frame.size.height - subLabelFrame.size.height;
		
		_subLabel.frameOptimizedForSize = subLabelFrame;
	
		FLRect textFrame = self.label.frame;
		textFrame.origin.y -= 4;
		self.label.frameOptimizedForSize = textFrame;
	}
}

- (BOOL) checked
{
	return _checked;
}

- (void) setChecked:(BOOL) checked
{
	_checked = checked;
	if(_checked)
	{
		if(self.dataSource)
		{
			self.dataSourceObject = self.checkedValue;
		}
		if(_group)
        {
            [_group checkMarkWasSelected:self];
        }
	}
	[self setNeedsLayout];
}

- (NSString*) subText
{
	return _subLabel.text;
}

- (void) setSubText:(NSString*) subText
{
	_subLabel.text = subText;
}

@end


@implementation FLCircleView

@synthesize borderWidth = _borderWidth;
@synthesize borderColor = _color;

- (void) drawRect:(FLRect)rect
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
	FLRelease(_color);
	FLSuperDealloc();
}
@end

@implementation FLOnOffCheckMarkTableViewCell

@synthesize checked = _checked;

- (void) calculateCellHeightInTable:(UITableView *)tableView
{
	self.cellHeight = 50.0f; // DeviceIsPad() ? 50.0 : 36.0f; // TODO: set with theme.
}

+ (id) onOffCheckMarkTableViewCell:(NSString*) labelOrNil
{
	FLOnOffCheckMarkTableViewCell* cell = FLReturnAutoreleased([[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FLCheckMarkedTableCell"]);
	if(FLStringIsNotEmpty(labelOrNil))
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
	
        _check = [[UIImageView alloc] initWithImage:[UIImage whiteImageNamed:@"check.png"]];
        _check.hidden = YES;
        [_check resizeToImageSize];
        [self addSubview:_check];
        
        _circle = [[FLCircleView alloc] initWithFrame:CGRectMake(0,0,34,30)];
        _circle.backgroundColor = [UIColor clearColor];
        _circle.borderColor = [UIColor grayColor];
        _circle.borderWidth = 2.0f;
        [self addSubview:_circle];
    }
	
	return self;
}

- (void) dealloc
{
    FLRelease(_check);
    FLSuperDealloc();
}

#define kTextLeft 60.0f
#define kLeftBuffer 0.0f

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    FLRect layoutRect = self.layoutRect;
	_circle.frameOptimizedForSize = FLRectCenterRectInRectVertically(layoutRect, FLRectSetLeft(_circle.frame, layoutRect.origin.x + kLeftBuffer));
    _check.frame = FLRectCenterRectInRect(_circle.frame, _check.frame); 
        
    self.label.frameOptimizedForSize = FLRectCenterRectInRectVertically(layoutRect, FLRectSetLeft(self.label.frame, kTextLeft));
}

- (void) setChecked:(BOOL) checked
{
    _checked = checked;
    if(self.dataSource)
    {
        self.dataSourceObject = [NSNumber numberWithBool:_checked];
    }
    _check.hidden = !self.isChecked;

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

