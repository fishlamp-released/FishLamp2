//
//	GtSingleLineTextEditCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/28/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSingleLineTextEditCell.h"

#import "GtGeometry.h"

@implementation GtSingleLineTextEditCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		self.cellHeight = GtSingleLingTextEditCellHeight;
		self.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	return self;
}

+ (GtSingleLineTextEditCell*) singleLineTextEditCell:(NSString*) titleLabelOrNil
{
	GtSingleLineTextEditCell* cell = GtReturnAutoreleased([[GtSingleLineTextEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GtSingleLineTextEditCell"]);
	if(GtStringIsNotEmpty(titleLabelOrNil))
	{
		cell.textLabelText = titleLabelOrNil;
	}
	return cell;
}

- (GtTextField*) textField
{
	return (GtTextField*) self.valueLabel.textField;
}

- (void) clear
{
	[self setValueLabelText: @""];
}

- (BOOL) isEditing
{
	return [self.textField isEditing];
}

- (void) tappedKey:(id) sender
{
	[self showHelpText];
	[self showWarningIcon];
	[self updateCountdownLabel];

	if(self.dataSource)
	{
		self.formattedDisplayString = self.textField.text;
	}
}

- (void) showHelpText
{
	self.textField.placeholder = self.helpText; 
}

- (void) setValueLabelText:(NSString*) text
{
// TODO: I don't like this here. Should be app logic.
	text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

	[super setValueLabelText:text];
	
	[self showHelpText];
	[self showWarningIcon];
	[self updateCountdownLabel];

	if(self.dataSource)
	{
		self.formattedDisplayString = text;
	}
}

- (UIView*) createValueLabel
{
	GtTextField* textField = GtReturnAutoreleased([[GtTextField alloc] initWithFrame:CGRectZero]);
	textField.clearButtonMode = UITextFieldViewModeWhileEditing;
	textField.backgroundColor = [UIColor clearColor];
	textField.autoresizingMask = UIViewAutoresizingNone;
	[textField addTarget:self action:@selector(tappedKey:) forControlEvents:UIControlEventEditingChanged];
	textField.delegate = self;
	textField.themeAction = @selector(applyThemeToTableViewCellTextField:); 
	return textField;
}

- (void) _beginEditing
{
	self.textField.canResignFirstResponder = NO;
	[self.textField becomeFirstResponder];
}

- (void) beginEditing
{
	[super beginEditing];
	if(!self.disabled && ![self.textField isFirstResponder])
	{
		[self _beginEditing];
		[self setNeedsLayout];
	}
}

- (void) dealloc
{
	self.textField.delegate = nil;
	self.textField.canResignFirstResponder = YES;
	GtSuperDealloc();
}

- (void) endEditing
{
	[super endEditing];

	self.textField.canResignFirstResponder = YES;
	[self.textField resignFirstResponder];
	
	[self didStopEditing];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString* curtext = textField.text;
    if( self.maxLength && 
        range.location == curtext.length && 
        ((curtext.length + string.length) > self.maxLength))
    {   
        return NO;
    }

    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if(self.nextCellToEdit)
	{
		self.textField.returnKeyType = UIReturnKeyNext;
	}
	else
	{
		self.textField.returnKeyType = UIReturnKeyDone;
	}

	BOOL willStartEditing = self.canEditData && 
		[self.textEditingCellDelegate textEditCellDoStartEditing:self];

	if(OSVersionIsAtLeast3_2() && willStartEditing)
	{
		self.textField.inputAccessoryView = 
			[self.textEditingCellDelegate textEditCellGetInputAccessoryView:self];
	}
	
	return willStartEditing;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	self.textField.canResignFirstResponder = NO;
	if(self.textField.clearsOnBeginEditing)
	{
		self.valueLabelText = @"";
	}
	
	[self showHelpText];
	[self updateCountdownLabel];
   
	[super textDidBeginEditing];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	[super textDidEndEditing:self.valueLabelText];
}

- (void) allowResponderToResign
{
	self.textField.canResignFirstResponder = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if(self.nextCellToEdit)
	{
		[self onNext:nil];
	}
	else
	{
		if(self.textEditingCellDelegate)
		{
			[self.textEditingCellDelegate textEditCellDidEndEditingText:self withDoneButtonPress:YES];
		}
	}

	return NO;
}

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//	  return NO;
//}

@end

@implementation GtPasswordTextEditCell

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	BOOL shouldStart = [super textFieldShouldBeginEditing:textField];
	textField.clearsOnBeginEditing = YES;
	textField.keyboardType = UIKeyboardTypeDefault;
	textField.secureTextEntry = YES;
	textField.autocorrectionType = UITextAutocorrectionTypeNo;
	textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	return shouldStart;
}

+ (GtPasswordTextEditCell*) passwordTextEditCell:(NSString*) titleLabelOrNil
{
	GtPasswordTextEditCell* cell = GtReturnAutoreleased([[GtPasswordTextEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GtSingleLineTextEditCell"]);
	if(GtStringIsNotEmpty(titleLabelOrNil))
	{
		cell.textLabelText = titleLabelOrNil;
	}
	return cell;
}

@end
