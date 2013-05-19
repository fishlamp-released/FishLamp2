//
//	FLEmailer.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/12/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLEmailer.h"
#import "FLOldUserNotificationView.h"
#import "FLAlert.h"
#import "FLButtons.h"

@interface FLEmailer ()
@property (readwrite, retain, nonatomic) NSData* attachment;
@property (readwrite, retain, nonatomic) NSString* attachmentFileName;
@property (readwrite, retain, nonatomic) NSString* attachmentMimeType;
@property (readwrite, retain, nonatomic) MFMailComposeViewController* emailController;
@end

@implementation FLEmailer

@synthesize bodyIsHtml = _bodyIsHtml;
@synthesize delegate = _delegate;

@synthesize attachment = _attachment;
@synthesize attachmentMimeType = _attachmentMimeType;
@synthesize attachmentFileName = _attachmentFileName;

@synthesize subject = _subject;
@synthesize body = _body;
@synthesize toRecipients = _toRecipients;
@synthesize emailController = _emailController;

- (id) init {
	if((self = [super init])) {
		 self.bodyIsHtml = YES;
	}
	
	return self;
}

- (void) dealloc {
//	_context.actionContextDelegate = nil;
	_emailController.mailComposeDelegate = nil;
	
	FLReleaseWithNil(_emailController);
//	FLReleaseWithNil(_context);
	FLReleaseWithNil(_subject);
	FLReleaseWithNil(_body);
	FLReleaseWithNil(_attachmentFileName);
	FLReleaseWithNil(_attachmentMimeType);
	FLReleaseWithNil(_attachment);
	FLReleaseWithNil(_toRecipients);
		
	FLSuperDealloc();
}

- (void) setAttachment:(NSData*) data
	fileName:(NSString*) fileName
	mimeType:(NSString*) mimeType {
	self.attachment = data;
	self.attachmentFileName = fileName;
	self.attachmentMimeType = mimeType;
}

//- (UIViewController*) actionContextGetViewController:(FLOperationContext*) context {
//	return _parentController;
//}

- (BOOL) canSendMail {
	return [MFMailComposeViewController canSendMail];
}

- (BOOL) composeEmail:(FLViewController*) parentController {
	mrc_retain_(self);
	
	if(![MFMailComposeViewController canSendMail]) {
		FLAlert* alert = [FLAlert alertViewController:NSLocalizedString(@"Unable to compose E-mail", nil)
					message:NSLocalizedString(@"Please check your email configuration and try again.", nil)];

        [alert addButton:[FLConfirmButton okButton]];
        [alert showViewControllerAnimated:YES];
		FLAutorelease(self);	   
		return NO;
	}

// TODO: do we need this context???

//	_context = [[FLExclusiveOperationContext alloc] initWithViewController:parentController];
//    [_context addObserver:self];
	
	_parentController = parentController;
	
	_emailController = [[MFMailComposeViewController alloc] init];
	_emailController.mailComposeDelegate = self;
	
	_statusBarStyle = [UIApplication sharedApplication].statusBarStyle;
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
	_frame = parentController.view.frame;
	
	[_emailController setSubject:_subject];
	[_emailController setMessageBody:_body isHTML:_bodyIsHtml]; 
	
	if(_toRecipients) {
		[_emailController setToRecipients:_toRecipients];
	}
	
	if(_attachment) {
		[_emailController addAttachmentData:_attachment 
			mimeType:_attachmentMimeType // @"image/jpeg" 
			fileName:_attachmentFileName];
	}
	
	[_parentController presentModalViewController:_emailController animated:YES];
	
	return YES;
}

- (void)mailComposeController:(MFMailComposeViewController *)controller 
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	[UIApplication sharedApplication].statusBarStyle = _statusBarStyle;
	[_parentController dismissModalViewControllerAnimated:YES];
	
	if(_delegate && [_delegate respondsToSelector:@selector(emailer:didFinishWithResult:error:)]) {
		[_delegate emailer:self didFinishWithResult:result error:error];
	}
	_emailController.mailComposeDelegate = nil;
	FLReleaseWithNil(_emailController);
//	FLReleaseWithNil(_context);
	_parentController = nil;
	_delegate = nil;
	
	FLAutorelease(self);
}

@end
