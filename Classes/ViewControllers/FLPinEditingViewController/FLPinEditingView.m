//
//	FLPinEditingView.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/20/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLPinEditingView.h"
#import "FLGradientButton.h"
#import "FLImage+Colorize.h"

#define kButtonHeight 60.0f
#define kLabelSize 40.0f

#define kNumButtons 12
#define kNumNumberButtons 10

@implementation FLPinEditingView

@synthesize delegate = _delegate;
@synthesize pinToCheckAgainst = _pinToCheck;

- (FLLegacyButton*) cancelButton
{
	return [_buttons objectAtIndex:9];
}

- (FLLegacyButton*) backButton
{
	return [_buttons objectAtIndex:11];
}

- (FLLegacyButton*) buttonByNumber:(NSUInteger) button
{
	if(button == 0)
	{
		return [_buttons objectAtIndex:10];
	}
	
	return [_buttons objectAtIndex:button - 1];
}

- (void) _updateBackButton
{
	for(int i = 0; i < 4; i++)
	{
		UILabel* label = [_numberLabels objectAtIndex:i];
		if(FLStringIsNotEmpty(label.text))
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
	for(UILabel* label in _numberLabels)
	{
		[str appendString:label.text];
	}
	return str;
}

- (void) _didSetPin
{
	[_delegate pinEditView:self didSetPin:self.pin];
}

- (void) _didUnlock
{
	[_delegate pinEditViewUserDidEnterCorrectPin:self];
}

- (void) _didCancel
{
	[_delegate pinEditViewDidCancel:self];
}

- (void) _clear
{
	for(UILabel* label in _numberLabels)
	{
		label.text = @"";
	}
	
	[self _updateBackButton];
	[self setNeedsLayout];
}

- (void) _showError:(NSString*) error
{
	if(!_errorLabel)
	{
		_errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 24)];
		_errorLabel.textAlignment = UITextAlignmentCenter;
		_errorLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
		_errorLabel.textColor = [UIColor whiteColor];
		_errorLabel.backgroundColor = [UIColor colorWithRed:0.626712f green:0.003425f blue:0.078767f alpha:1.0f];
		_errorLabel.layer.cornerRadius = 4.0f;
		_errorLabel.layer.masksToBounds = YES;
		_errorLabel.layer.borderColor = _errorLabel.textColor.CGColor;
		_errorLabel.layer.borderWidth = 2.0f;

		[self addSubview:_errorLabel];
	}

	_errorLabel.text = error;
	[self setNeedsLayout];

	[self performSelector:@selector(_clear) withObject:nil afterDelay:0.3];

}

- (void) _setNextNumber:(NSUInteger) number
{
	for(int i = 0; i < 4; i++)
	{
		UILabel* label = [_numberLabels objectAtIndex:i];
		if(FLStringIsEmpty(label.text))
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

	if(_pinCheckMode)
	{
		++_attemptCount;
	
		if(FLStringsAreEqual(self.pin, _pinToCheck))
		{
			[self performSelector:@selector(_didUnlock) withObject:nil afterDelay:0.3];
		}
		else if(_attemptCount == _maxAttempts)
		{
			[self performSelector:@selector(_didCancel) withObject:nil afterDelay:0.3];
		}
		else
		{
			[self _showError:[NSString stringWithFormat:(NSLocalizedString(@"%d of %d Attempts", nil)), _attemptCount, _maxAttempts]];
		}
		 
	}
	else if(!_checkingNewPinMode)
	{
		_titleLabel.text = NSLocalizedString(@"Confirm New PIN", nil);
		_pinToCheck = retain_(self.pin);
		_checkingNewPinMode = YES;
		
		[self performSelector:@selector(_clear) withObject:nil afterDelay:0.3];
	}
	else if(FLStringsAreEqual(_pinToCheck, self.pin))
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
		UILabel* label = [_numberLabels objectAtIndex:i];
		if(FLStringIsNotEmpty(label.text))
		{
			label.text = @"";
			self.backButton.enabled = i > 0;
			return;
		}
	}

	self.backButton.enabled = NO;
}

- (void) _buttonCallback:(FLLegacyButton*) button
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
	self.layer.shadowOffset = FLSizeMake(0,3);
	self.clipsToBounds = NO;
	
	self.layer.cornerRadius = 8.0f;
	self.layer.masksToBounds = YES;
	self.layer.borderColor = [FLRgbColor(100, 103, 107, 1.0) CGColor];
	self.layer.borderWidth = 1.0f;
	
	_buttons = [[NSMutableArray alloc] init];
	for(int i = 0; i < kNumButtons; i++)
	{
		FLLegacyButton* button = [FLGradientButton gradientButton:@"" target:self action:@selector(_buttonCallback:)];
		button.tag = i;
		button.cornerRadius = 1.0f;
		[_buttons addObject:button];
		[self addSubview:button];
		FLTextDescriptor* text = button.titleLabel.textDescriptor;
		text.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
		button.titleLabel.textDescriptor = text;
	}
	for(int i = 0; i < kNumNumberButtons; i++)
	{
		FLLegacyButton* button = [self buttonByNumber:i];
		button.title = [NSString stringWithFormat:@"%d", i];
	}
	self.cancelButton.title = NSLocalizedString(@"Cancel", nil);
	self.backButton.image = [[UIImage imageNamed:@"arrow_left.png"] colorizeImage:[UIColor whiteColor] blendMode:kCGBlendModeOverlay];
	self.backButton.enabled = NO;
			
	_numberLabels = [[NSMutableArray alloc] init];
   
	for(int i = 0; i < 4; i++)
	{
		UILabel* label = autorelease_([[UILabel alloc] initWithFrame:CGRectMake(0,0,kLabelSize,kLabelSize)]);
		label.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
		label.textAlignment = UITextAlignmentCenter;
		label.backgroundColor = [UIColor gray85Color];
		label.textColor = [UIColor blackColor];
		label.shadowColor = [UIColor whiteColor];
		
		label.layer.cornerRadius = 8.0f;
		label.layer.masksToBounds = YES;
		label.layer.borderColor = [UIColor grayColor].CGColor;
		label.layer.borderWidth = 1.0f;

		
		[_numberLabels addObject:label];
		[self addSubview:label];
	}
	
	_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,20,0,40)];
	_titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
	_titleLabel.textAlignment = UITextAlignmentCenter;
	_titleLabel.backgroundColor = [UIColor clearColor];
	_titleLabel.textColor = [UIColor whiteColor];
	_titleLabel.shadowColor = [UIColor blackColor];
	_titleLabel.text = NSLocalizedString(@"Create New PIN", nil);
	[self addSubview:_titleLabel];
	
}

#if FL_MRC
- (void) dealloc
{
	release_(_errorLabel);
	release_(_pinToCheck);
	release_(_titleLabel);
    release_(_numberLabels);
	release_(_buttons);
	super_dealloc_();
}
#endif

- (void) setPinCheckMode:(NSString*) pinToCheck maxAttempts:(NSUInteger) maxAttempts
{
	_titleLabel.text = NSLocalizedString(@"Enter PIN", nil);
	FLRetainObject_(_pinToCheck, pinToCheck);
	_maxAttempts = maxAttempts;
	_pinCheckMode = YES;
	[self setNeedsLayout];
}

- (id) initWithFrame:(FLRect) frame
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

	if(_errorLabel)
	{
		_errorLabel.newFrame = FLRectCenterRectInRectHorizontally(self.bounds, FLRectSetTop(_errorLabel.frame, buttonTop - 30));
	}
		
	CGFloat width = self.bounds.size.width;
	_titleLabel.newFrame = FLRectSetWidth(_titleLabel.frame, width);
	
	CGFloat bufferWidth = (width - (kLabelSize*4.0f)) / 5.0f;
	CGFloat left = bufferWidth;
	for(int i = 0; i < 4; i++)
	{
		UILabel* label = [_numberLabels objectAtIndex:i];
		label.frameOptimizedForSize = 
			FLRectSetOrigin(
				FLRectSetSize(label.frame, kLabelSize, kLabelSize), left, buttonTop / 2.0f);
				
		left += (bufferWidth + kLabelSize);
	}
	
	CGFloat buttonWidth = (width / 3.0f);
	left = 0;
	for(int i = 0; i < kNumButtons; i++)
	{
		FLLegacyButton* button = [_buttons objectAtIndex:i];
		if(i > 0 && (i % 3) == 0)
		{
			left = 0.0f;
			buttonTop += (kButtonHeight - 1);
		}
		
		button.frameOptimizedForSize = 
			FLRectSetOrigin(
				FLRectSetSize(button.frame, buttonWidth, kButtonHeight), left, buttonTop);

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