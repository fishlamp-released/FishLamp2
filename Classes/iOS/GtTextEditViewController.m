//
//  GtTextEditViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/4/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTextEditViewController.h"
#import "GtGradientView.h"

@implementation GtTextEditViewController

@synthesize textEditView = m_textEditView;
@synthesize returnKeyBeginsSave = m_returnKeyBeginsSave;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
	{
    }
	
	return self;
}

+ (GtTextEditViewController*) textEditViewController
{
	return GtReturnAutoreleased([[GtTextEditViewController alloc] initWithNibName:nil bundle:nil]);
}

- (NSInteger) maxSize
{
	return m_maxSize;
}

- (void) setMaxSize:(NSInteger) maxSize
{
    m_maxSize = maxSize;
	if(m_textEditView)
    {
        m_textEditView.maxSize = maxSize;
    }
}

- (NSString*) text
{
	return m_text;
}

- (void) setText:(NSString*) text
{
    GtAssignObject(m_text, text);
    
    if(m_textEditView)
    {
        m_textEditView.text = m_text;
    }
}

- (void) dealloc
{
    GtRelease(m_placeholderText);
    GtRelease(m_text);
    m_textEditView.delegate = nil;
	GtRelease(m_textEditView);
	GtSuperDealloc();
}

- (void) dismissViewControllerAnimated:(BOOL)animated 
{
    m_textEditView.delegate = nil;
    [super dismissViewControllerAnimated:animated];
}

- (NSUInteger) textLength
{
    return m_text.length;
}

- (BOOL) textIsTooLong
{
    return self.maxSize > 0 && self.maxSize < (NSInteger) m_text.length;
}

- (void) willBeginSaving
{
    if(self.textIsTooLong)
    {
        [self presentTextIsTooLongMessage];
    }
    else
    {
        [self beginSaving];
    }
}

- (void) presentTextIsTooLongMessage
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"The text is too long.", nil)
        message:[NSString stringWithFormat:(NSLocalizedString(@"The maximum length is %d characters.", nil)), self.maxSize]
        delegate:nil
        cancelButtonTitle:NSLocalizedString(@"OK", nil)
        otherButtonTitles:nil];
    GtAutorelease(alert);
        
    [alert show];
}

- (NSString*) truncatedText
{
    return self.textIsTooLong ? [m_text substringToIndex:self.maxSize - 1]: m_text;
}

- (void) truncateText
{
    if(self.textIsTooLong)
    {   
        [self setText:self.truncatedText];
    }
}

- (void) stopEditing
{
    [m_textEditView stopEditing];
}

- (void) startEditing
{
    [m_textEditView startEditing];
}

- (BOOL) canUpdateSaveButtonEnabledState
{
	return YES;
}

- (void) updateSaveButtonState
{
	if(self.canUpdateSaveButtonEnabledState)
	{
		self.saveButtonEnabled = GtStringIsNotEmpty(self.text);
	}
}

- (void) textEditView:(GtTextEditView*) textEditView userTappedReturnKey:(NSString*) text
{
    if(self.returnKeyBeginsSave)
    {
        [self willBeginSaving];
    }
    else
    {
        GtAssignObject(m_text, text);
        [self updateSaveButtonState];
    }
}

- (void) textEditView:(GtTextEditView*) textEditView textDidChange:(NSString*) text
{
    GtAssignObject(m_text, text);
	[self updateSaveButtonState];
}

- (void) viewDidUnload
{
    [super viewDidUnload];
   
    m_textEditView.delegate = nil;
	GtReleaseWithNil(m_textEditView);
}

- (NSString*) placeholderText
{
    return m_textEditView ? m_textEditView.placeholderText : m_placeholderText;
}

- (void) setPlaceholderText:(NSString *)placeholderText
{
    GtAssignObject(m_placeholderText, placeholderText);
    if(m_textEditView)
    {
        m_textEditView.placeholderText = placeholderText;
    }
}

- (void) setReturnKeyBeginsSave:(BOOL)returnKeyBeginsSave
{
    m_returnKeyBeginsSave = returnKeyBeginsSave;
    if(m_textEditView)
    {
        m_textEditView.dissallowReturnKey = m_returnKeyBeginsSave;
    }
}

- (void) viewDidLoad
{
    m_textEditView = [[GtTextEditView alloc] initWithFrame:CGRectMake(0,0,200,80)];
    m_textEditView.delegate = self;
    m_textEditView.maxSize = m_maxSize;
    m_textEditView.dissallowReturnKey = self.returnKeyBeginsSave;
    if(GtStringIsNotEmpty(m_text))
    {
        m_textEditView.text = m_text;
    }
    if(GtStringIsNotEmpty(m_placeholderText))
    {
        m_textEditView.placeholderText = m_placeholderText;
    }

    [super viewDidLoad];
}

- (void) configureContentView
{
    self.contentView.viewLayout = [GtRowViewLayout viewLayout];
    self.contentView.viewLayout.padding = UIEdgeInsets10;
	[self.contentView addSubview:m_textEditView];
}

- (void) viewDidAppear:(BOOL) animated
{
	[super viewDidAppear:animated];
	[self updateSaveButtonState];
	[self startEditing];
}

@end
