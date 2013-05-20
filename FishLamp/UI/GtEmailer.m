//
//  GtEmailer.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/12/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtEmailer.h"
#import "GtUserNotificationView.h"
#import "GtActionContextManager.h"

@implementation GtEmailer

@synthesize bodyIsHtml = m_bodyIsHtml;
@synthesize delegate = m_delegate;

GtSynthesize(attachment, setAttachment, NSData, m_attachment);
GtSynthesize(attachmentMimeType, setAttachmentMimeType, NSString, m_attachmentMimeType);
GtSynthesize(attachmentFileName, setAttachmentFileName, NSString, m_attachmentFileName);

GtSynthesizeString(subject, setSubject);
GtSynthesizeString(body, setBody);
GtSynthesize(toRecipients, setToRecipients, NSArray, m_toRecipients);

- (id) init
{
	if(self = [super init])
	{
		self.bodyIsHtml = YES;
        self.mailComposeDelegate = self;
			
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_context);
	GtRelease(m_subject);
	GtRelease(m_body);
	GtRelease(m_attachmentFileName);
	GtRelease(m_attachmentMimeType);
	GtRelease(m_attachment);
	GtRelease(m_toRecipients);
    GtRelease(m_error);
		
	[super dealloc];
}

- (void) setAttachment:(NSData*) data
	fileName:(NSString*) fileName
	mimeType:(NSString*) mimeType
{
	self.attachment = data;
	self.attachmentFileName = fileName;
	self.attachmentMimeType = mimeType;
}

- (void) composeEmail:(UIViewController*) parentController
{
	m_context = [GtAlloc(GtManagedActionContext) initAndActivate:YES];

#if DEBUG
    [m_context setDelegateTypeWithClass:[self class]];
#endif
	
	[self retain];

	m_parentController = parentController;
	m_statusBarStyle = [UIApplication sharedApplication].statusBarStyle;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    m_frame = parentController.view.frame;
    
	RunOnlyOnSdkVersion3
	{
		if(![MFMailComposeViewController canSendMail])
		{
			UIAlertView* alert = [GtAlloc(UIAlertView) initWithTitle:NSLocalizedStringFromTable(@"GT_CHECK_EMAIL_CONFIG_STR", @"FishLamp", nil) 
						message:@""
						delegate:nil 
						cancelButtonTitle:NSLocalizedStringFromTable(@"GT_OK_STR", @"FishLamp", nil) otherButtonTitles:nil];
				
			[alert show];
			GtRelease(alert);
		}
		else
		{
			
			[self setSubject:m_subject];
			[self setMessageBody:m_body isHTML:m_bodyIsHtml]; 
			
			if(m_toRecipients)
			{
				[self setToRecipients:m_toRecipients];
			}
			
			
			if(m_attachment)
			{
				[self addAttachmentData:m_attachment 
					mimeType:m_attachmentMimeType // @"image/jpeg" 
					fileName:m_attachmentFileName];
			}
			
			[parentController presentModalViewController:self animated:YES];
		}
	}
	
#if FISHLAMP_IPHONE_2_SDK			
	DontRunOnSdkVersion3
	{
		UIAlertView* alert = [GtAlloc(UIAlertView) initWithTitle:NSLocalizedStringFromTable(@"GT_CANT_SEND_OLDSDK_STR", @"FishLamp", nil)  
					message:@""
					delegate:nil 
					cancelButtonTitle:NSLocalizedStringFromTable(@"GT_OK_STR", @"FishLamp", nil) otherButtonTitles:nil];
			
		[alert show];
		GtRelease(alert);
/*	
		NSString *recipients = @"mailto:first@example.com?cc=second@example.com,third@example.com&subject=Hello from California!";
		NSString *body = @"&body=It is raining in sunny California!";
    
		NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
		email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
*/
	}
#endif	
}

- (void)viewDidDisappear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = m_statusBarStyle;
    m_parentController.view.frame = m_frame;
    
    GtReleaseWithNil(m_context);
    
    if(m_delegate)
	{
		[m_delegate emailer:self didFinishWithResult:m_result error:m_error];
	}
	else
	{
		[self promptUserWithResults:m_result error:m_error];
	}
}

- (void) dismiss
{
	[self dismissModalViewControllerAnimated:YES];
}

- (void) promptUserWithResults:(MFMailComposeResult)result 
		error:(NSError *)error
{
	switch(result)
	{
		case MFMailComposeResultFailed:
		{
			UIAlertView* alert = [GtAlloc(UIAlertView) initWithTitle:NSLocalizedStringFromTable(@"GT_UNABLE_TO_SEND_EMAIL_STR", @"FishLamp", nil) 
						message:error ? [error description] : NSLocalizedStringFromTable(@"GT_CHECK_EMAIL_CONFIG_STR", @"FishLamp", nil)
						delegate:nil 
						cancelButtonTitle:NSLocalizedStringFromTable(@"GT_OK_STR", @"FishLamp", nil) otherButtonTitles:nil];
				
			[alert show];
			GtRelease(alert);
		}
		break;
			
		case MFMailComposeResultSaved:
		{
			GtUserNotificationView* view = [GtAlloc(GtUserNotificationView) initAsInfoNotification];;
			view.autoCloseDelay = GT_AUTO_DISMISS_INTERVAL;
			view.location = GtNotificationViewLocationBottomAboveToolBar;
			view.title = @"Your email will be sent later";
			[view.text appendString:NSLocalizedStringFromTable(@"GT_EMAIL_SAVED_STR", @"FishLamp", nil)];
			[m_parentController.view addSubview:view];
			GtRelease(view);
		}
		break;
	
		case MFMailComposeResultSent:
		{
		/*
			GtUserNotificationView* view = [GtAlloc(GtUserNotificationView) initAsInfoNotification];;
			view.autoCloseDelay = GT_AUTO_DISMISS_INTERVAL;
			view.location = GtNotificationViewLocationBottomAboveToolBar;
			view.text = NSLocalizedStringFromTable(@"GT_EMAIL_SENT_STR", @"FishLamp", nil);
			[self.parentController.view addSubview:view];
			GtRelease(view);
		*/
		}
		break;
	}
}

- (void)mailComposeController:(MFMailComposeViewController *)controller 
	didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    m_result = result;
    m_error = [error retain];
	[self dismiss];
}

@end
