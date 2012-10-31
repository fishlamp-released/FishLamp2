//
//	FLSingleLineTextEditCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/28/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLSingleLineTextEditCell.h"

#import "FLGeometry.h"

@implementation FLSingleLineTextEditCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		self.cellHeight = FLSingleLingTextEditCellHeight;
		self.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	return self;
}

+ (FLSingleLineTextEditCell*) singleLineTextEditCell:(NSString*) titleLabelOrNil
{
	FLSingleLineTextEditCell* cell = autorelease_([[FLSingleLineTextEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FLSingleLineTextEditCell"]);
	if(FLStringIsNotEmpty(titleLabelOrNil))
	{
		cell.textLabelText = titleLabelOrNil;
	}
	return cell;
}

- (FLTextField*) textField
{
	return (FLTextField*) self.valueLabel.textField;
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

- (void) applyTheme:(FLTheme*) theme {
//	field.textDescriptor = self.valueDescriptor;
}

- (UIView*) createValueLabel
{
	FLTextField* textField = autorelease_([[FLTextField alloc] initWithFrame:CGRectZero]);
	textField.clearButtonMode = UITextFieldViewModeWhileEditing;
	textField.backgroundColor = [UIColor clearColor];
	textField.autoresizingMask = UIViewAutoresizingNone;
	[textField addTarget:self action:@selector(tappedKey:) forControlEvents:UIControlEventEditingChanged];
	textField.delegate = self;
	
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
	mrc_super_dealloc_();
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

	if(willStartEditing)
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

@implementation FLPasswordTextEditCell

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

+ (FLPasswordTextEditCell*) passwordTextEditCell:(NSString*) titleLabelOrNil
{
	FLPasswordTextEditCell* cell = autorelease_([[FLPasswordTextEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FLSingleLineTextEditCell"]);
	if(FLStringIsNotEmpty(titleLabelOrNil))
	{
		cell.textLabelText = titleLabelOrNil;
	}
	return cell;
}

@end
