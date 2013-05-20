//
//	GtEmailer.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/12/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtEmailer.h"
#import "GtUserNotificationView.h"
#import "GtActionContextManager.h"

@interface GtEmailer ()
@property (readwrite, retain, nonatomic) NSData* attachment;
@property (readwrite, retain, nonatomic) NSString* attachmentFileName;
@property (readwrite, retain, nonatomic) NSString* attachmentMimeType;
@property (readwrite, retain, nonatomic) MFMailComposeViewController* emailController;
@end

@implementation GtEmailer

@synthesize bodyIsHtml = m_bodyIsHtml;
@synthesize delegate = m_delegate;

@synthesize attachment = m_attachment;
@synthesize attachmentMimeType = m_attachmentMimeType;
@synthesize attachmentFileName = m_attachmentFileName;

@synthesize subject = m_subject;
@synthesize body = m_body;
@synthesize toRecipients = m_toRecipients;
@synthesize emailController = m_emailController;

- (id) init
{
	if((self = [super init]))
	{
		 self.bodyIsHtml = YES;
	}
	
	return self;
}

- (void) dealloc
{
	m_context.actionContextDelegate = nil;
	m_emailController.mailComposeDelegate = nil;
	
	GtReleaseWithNil(m_emailController);
	GtReleaseWithNil(m_context);
	GtReleaseWithNil(m_subject);
	GtReleaseWithNil(m_body);
	GtReleaseWithNil(m_attachmentFileName);
	GtReleaseWithNil(m_attachmentMimeType);
	GtReleaseWithNil(m_attachment);
	GtReleaseWithNil(m_toRecipients);
		
	GtSuperDealloc();
}

- (void) setAttachment:(NSData*) data
	fileName:(NSString*) fileName
	mimeType:(NSString*) mimeType
{
	self.attachment = data;
	self.attachmentFileName = fileName;
	self.attachmentMimeType = mimeType;
}

- (UIViewController*) actionContextGetViewController:(GtActionContext*) context
{
	return m_parentController;
}

- (BOOL) canSendMail
{
	return [MFMailComposeViewController canSendMail];
}

- (BOOL) composeEmail:(GtViewController*) parentController
{
	GtRetain(self);
	
	if(![MFMailComposeViewController canSendMail])
	{
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Unable to compose E-mail", nil)
					message:NSLocalizedString(@"Please check your email configuration and try again.", nil) 
					delegate:nil 
					cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
			
		[alert show];
		GtReleaseWithNil(alert);
		GtAutorelease(self);	   
		return NO;
	}

	m_context = [[GtManagedActionContext alloc] initAndActivate:YES];
	m_context.actionContextDelegate = self;
	
	m_parentController = parentController;
	
	m_emailController = [[MFMailComposeViewController alloc] init];
	m_emailController.mailComposeDelegate = self;
	
	m_statusBarStyle = [UIApplication sharedApplication].statusBarStyle;
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
	m_frame = parentController.view.frame;
	
	[m_emailController setSubject:m_subject];
	[m_emailController setMessageBody:m_body isHTML:m_bodyIsHtml]; 
	
	if(m_toRecipients)
	{
		[m_emailController setToRecipients:m_toRecipients];
	}
	
	if(m_attachment)
	{
		[m_emailController addAttachmentData:m_attachment 
			mimeType:m_attachmentMimeType // @"image/jpeg" 
			fileName:m_attachmentFileName];
	}
	
	[m_parentController presentModalViewController:m_emailController animated:YES];
	
	return YES;
}

- (void)mailComposeController:(MFMailComposeViewController *)controller 
	didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	[UIApplication sharedApplication].statusBarStyle = m_statusBarStyle;
	[m_parentController dismissModalViewControllerAnimated:YES];
	
	if(m_delegate && [m_delegate respondsToSelector:@selector(emailer:didFinishWithResult:error:)])
	{
		[m_delegate emailer:self didFinishWithResult:result error:error];
	}
	m_emailController.mailComposeDelegate = nil;
	GtReleaseWithNil(m_emailController);
	GtReleaseWithNil(m_context);
	m_parentController = nil;
	m_delegate = nil;
	
	GtAutorelease(self);
}

@end
