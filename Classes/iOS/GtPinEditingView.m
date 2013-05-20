//
//	GtPinEditingView.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/20/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtPinEditingView.h"
#import "GtGradientButton.h"
#import "UIImage+GtColorize.h"

#define kButtonHeight 60.0f
#define kLabelSize 40.0f

#define kNumButtons 12
#define kNumNumberButtons 10

@implementation GtPinEditingView

@synthesize delegate = m_delegate;
@synthesize pinToCheckAgainst = m_pinToCheck;

- (GtButton*) cancelButton
{
	return [m_buttons objectAtIndex:9];
}

- (GtButton*) backButton
{
	return [m_buttons objectAtIndex:11];
}

- (GtButton*) buttonByNumber:(NSUInteger) button
{
	if(button == 0)
	{
		return [m_buttons objectAtIndex:10];
	}
	
	return [m_buttons objectAtIndex:button - 1];
}

- (void) _updateBackButton
{
	for(int i = 0; i < 4; i++)
	{
		UILabel* label = [m_numberLabels objectAtIndex:i];
		if(GtStringIsNotEmpty(label.text))
		{
			self.backButton.enabled = YES;
			return;
		}
	}
	
	self.backButton.enabled = NO;
}

- (NSString*) pin
{
	NSMutableString* str = [NSMutableString string];
	for(UILabel* label in m_numberLabels)
	{
		[str appendString:label.text];
	}
	return str;
}

- (void) _didSetPin
{
	[m_delegate pinEditView:self didSetPin:self.pin];
}

- (void) _didUnlock
{
	[m_delegate pinEditViewUserDidEnterCorrectPin:self];
}

- (void) _didCancel
{
	[m_delegate pinEditViewDidCancel:self];
}

- (void) _clear
{
	for(UILabel* label in m_numberLabels)
	{
		label.text = @"";
	}
	
	[self _updateBackButton];
	[self setNeedsLayout];
}

- (void) _showError:(NSString*) error
{
	if(!m_errorLabel)
	{
		m_errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 24)];
		m_errorLabel.textAlignment = UITextAlignmentCenter;
		m_errorLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
		m_errorLabel.textColor = [UIColor whiteColor];
		m_errorLabel.backgroundColor = [UIColor colorWithRed:0.626712f green:0.003425f blue:0.078767f alpha:1.0f];
		m_errorLabel.layer.cornerRadius = 4.0f;
		m_errorLabel.layer.masksToBounds = YES;
		m_errorLabel.layer.borderColor = m_errorLabel.textColor.CGColor;
		m_errorLabel.layer.borderWidth = 2.0f;

		[self addSubview:m_errorLabel];
	}

	m_errorLabel.text = error;
	[self setNeedsLayout];

	[self performSelector:@selector(_clear) withObject:nil afterDelay:0.3];

}

- (void) _setNextNumber:(NSUInteger) number
{
	for(int i = 0; i < 4; i++)
	{
		UILabel* label = [m_numberLabels objectAtIndex:i];
		if(GtStringIsEmpty(label.text))
		{
			label.text = [NSString stringWithFormat:@"%d", number];
			if(i < 3)
			{
				[self _updateBackButton];
				return;
			}
		}
	}
	
	[self _updateBackButton];

	if(m_pinCheckMode)
	{
		++m_attemptCount;
	
		if(GtStringsAreEqual(self.pin, m_pinToCheck))
		{
			[self performSelector:@selector(_didUnlock) withObject:nil afterDelay:0.3];
		}
		else if(m_attemptCount == m_maxAttempts)
		{
			[self performSelector:@selector(_didCancel) withObject:nil afterDelay:0.3];
		}
		else
		{
			[self _showError:[NSString stringWithFormat:(NSLocalizedString(@"%d of %d Attempts", nil)), m_attemptCount, m_maxAttempts]];
		}
		 
	}
	else if(!m_checkingNewPinMode)
	{
		m_titleLabel.text = NSLocalizedString(@"Confirm New PIN", nil);
		m_pinToCheck = GtRetain(self.pin);
		m_checkingNewPinMode = YES;
		
		[self performSelector:@selector(_clear) withObject:nil afterDelay:0.3];
	}
	else if(GtStringsAreEqual(m_pinToCheck, self.pin))
	{
		[self performSelector:@selector(_didSetPin) withObject:nil afterDelay:0.3];
	}
	else
	{
		[self _showError:NSLocalizedString(@"Pins don't match.", nil)];
	}
}

- (void) _removeNumber
{
	for(int i = 3; i >= 0; i--)
	{
		UILabel* label = [m_numberLabels objectAtIndex:i];
		if(GtStringIsNotEmpty(label.text))
		{
			label.text = @"";
			self.backButton.enabled = i > 0;
			return;
		}
	}

	self.backButton.enabled = NO;
}

- (void) _buttonCallback:(GtButton*) button
{
	NSInteger buttonNumber = button.tag + 1;

	switch(button.tag)
	{
		case 11:
			[self _removeNumber];
			return;
			break;
	
		case 9:
			[self.delegate pinEditViewDidCancel:self];
			return;
			break;
		case 10:
			buttonNumber = 0;
			break;
	}
	
	[self _setNextNumber:buttonNumber];	  
}

- (void) _initPinEditingView
{
	self.backgroundColor = [UIColor gray10Color];
	self.autoresizesSubviews = NO;
	self.autoresizingMask = UIViewAutoresizingFlexibleEverything;

	self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
	self.layer.shadowOpacity = 0.5;
	self.layer.shadowRadius = 5.0;
	self.layer.shadowOffset = CGSizeMake(0,3);
	self.clipsToBounds = NO;
	
	self.layer.cornerRadius = 8.0f;
	self.layer.masksToBounds = YES;
	self.layer.borderColor = [GtRgbColor(100, 103, 107, 1.0) CGColor];
	self.layer.borderWidth = 1.0f;
	
	m_buttons = [[NSMutableArray alloc] init];
	for(int i = 0; i < kNumButtons; i++)
	{
		GtButton* button = [GtGradientButton gradientButton:@"" target:self action:@selector(_buttonCallback:)];
		button.tag = i;
		button.cornerRadius = 1.0f;
		[m_buttons addObject:button];
		[self addSubview:button];
		GtTextDescriptor* text = button.titleLabel.textDescriptor;
		text.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
		button.titleLabel.textDescriptor = text;
	}
	for(int i = 0; i < kNumNumberButtons; i++)
	{
		GtButton* button = [self buttonByNumber:i];
		button.title = [NSString stringWithFormat:@"%d", i];
	}
	self.cancelButton.title = NSLocalizedString(@"Cancel", nil);
	self.backButton.image = [[UIImage imageNamed:@"arrow_left.png"] colorizeImage:[UIColor whiteColor] blendMode:kCGBlendModeOverlay];
	self.backButton.enabled = NO;
			
	m_numberLabels = [[NSMutableArray alloc] init];
   
	for(int i = 0; i < 4; i++)
	{
		UILabel* label = GtReturnAutoreleased([[UILabel alloc] initWithFrame:CGRectMake(0,0,kLabelSize,kLabelSize)]);
		label.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
		label.textAlignment = UITextAlignmentCenter;
		label.backgroundColor = [UIColor gray85Color];
		label.textColor = [UIColor blackColor];
		label.shadowColor = [UIColor whiteColor];
		
		label.layer.cornerRadius = 8.0f;
		label.layer.masksToBounds = YES;
		label.layer.borderColor = [UIColor grayColor].CGColor;
		label.layer.borderWidth = 1.0f;

		
		[m_numberLabels addObject:label];
		[self addSubview:label];
	}
	
	m_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,20,0,40)];
	m_titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
	m_titleLabel.textAlignment = UITextAlignmentCenter;
	m_titleLabel.backgroundColor = [UIColor clearColor];
	m_titleLabel.textColor = [UIColor whiteColor];
	m_titleLabel.shadowColor = [UIColor blackColor];
	m_titleLabel.text = NSLocalizedString(@"Create New PIN", nil);
	[self addSubview:m_titleLabel];
	
}

- (void) dealloc
{
	GtRelease(m_errorLabel);
	GtRelease(m_pinToCheck);
	GtRelease(m_titleLabel);
	[m_numberLabels	 release];
	GtRelease(m_buttons);
	GtSuperDealloc();
}

- (void) setPinCheckMode:(NSString*) pinToCheck maxAttempts:(NSUInteger) maxAttempts
{
	m_titleLabel.text = NSLocalizedString(@"Enter PIN", nil);
	GtAssignObject(m_pinToCheck, pinToCheck);
	m_maxAttempts = maxAttempts;
	m_pinCheckMode = YES;
	[self setNeedsLayout];
}

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		[self _initPinEditingView];
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder])) 
	{	
		[self _initPinEditingView];
	}
	
	return self;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	CGFloat buttonTop = self.bounds.size.height - (kButtonHeight * 4) + 4;

	if(m_errorLabel)
	{
		m_errorLabel.newFrame = GtRectCenterRectInRectHorizontally(self.bounds, GtRectSetTop(m_errorLabel.frame, buttonTop - 30));
	}
		
	CGFloat width = self.bounds.size.width;
	m_titleLabel.newFrame = GtRectSetWidth(m_titleLabel.frame, width);
	
	CGFloat bufferWidth = (width - (kLabelSize*4)) / 5.0;
	CGFloat left = bufferWidth;
	for(int i = 0; i < 4; i++)
	{
		UILabel* label = [m_numberLabels objectAtIndex:i];
		label.frameOptimizedForSize = 
			GtRectSetOrigin(
				GtRectSetSize(label.frame, kLabelSize, kLabelSize), left, buttonTop / 2.0f);
				
		left += (bufferWidth + kLabelSize);
	}
	
	CGFloat buttonWidth = (width / 3.0f);
	left = 0;
	for(int i = 0; i < kNumButtons; i++)
	{
		GtButton* button = [m_buttons objectAtIndex:i];
		if(i > 0 && (i % 3) == 0)
		{
			left = 0.0f;
			buttonTop += (kButtonHeight - 1);
		}
		
		button.frameOptimizedForSize = 
			GtRectSetOrigin(
				GtRectSetSize(button.frame, buttonWidth, kButtonHeight), left, buttonTop);

		left += buttonWidth;
	}
	

}

- (void) setCornerRadius:(CGFloat) radius
{
	self.layer.cornerRadius = radius;
}

- (CGFloat) cornerRadius
{
	return self.layer.cornerRadius;
}

- (CGFloat) borderWidth
{
	return self.layer.borderWidth;
}

- (void) setBorderWidth:(CGFloat) width
{
	self.layer.borderWidth = width;
}

- (UIColor*) borderColor
{
	return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void) setBorderColor:(UIColor*) color
{
	self.layer.borderColor = color.CGColor;
}

@end