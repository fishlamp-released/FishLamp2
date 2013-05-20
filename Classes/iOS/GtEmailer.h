//
//	GtEmailer.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/12/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <MessageUI/MessageUI.h>

#import "GtManagedActionContext.h"
#import "GtViewController.h"

#define GT_JPEG_MIME_TYPE @"image/jpeg"
#define GT_TEXT_PLAIN_TYPE @"text/plain"
@protocol GtEmailerDelegate;

@interface GtEmailer : NSObject<MFMailComposeViewControllerDelegate, GtActionContextDelegate> {
@private

	NSString* m_subject;
	NSString* m_body;

	NSArray* m_toRecipients;
	
	NSData* m_attachment;
	NSString* m_attachmentMimeType;
	NSString* m_attachmentFileName;
	
	GtViewController* m_parentController;
	
	BOOL m_bodyIsHtml;
	id<GtEmailerDelegate> m_delegate;
	
	GtManagedActionContext* m_context;
	
	UIStatusBarStyle m_statusBarStyle;
	CGRect m_frame;
	
	MFMailComposeViewController* m_emailController;
}

@property (readonly, assign, nonatomic) BOOL canSendMail;
@property (readwrite, assign, nonatomic) id<GtEmailerDelegate> delegate;
@property (readwrite, assign, nonatomic) BOOL bodyIsHtml;

@property (readwrite, retain, nonatomic) NSString* subject;
@property (readwrite, retain, nonatomic) NSString* body;
@property (readwrite, retain, nonatomic) NSArray* toRecipients;
@property (readonly, retain, nonatomic) NSData* attachment;
@property (readonly, retain, nonatomic) NSString* attachmentFileName;
@property (readonly, retain, nonatomic) NSString* attachmentMimeType;

// TODO: add cc/bcc recipients

// attachment
- (void) setAttachment:(NSData*) data
			  fileName:(NSString*) fileName
			  mimeType:(NSString*) mimeType;
			  

- (BOOL) composeEmail:(GtViewController*) parentController; // return YES if can send email.

@end

@protocol GtEmailerDelegate <NSObject>
@optional 

- (void) emailer:(GtEmailer *)controller 
	didFinishWithResult:(MFMailComposeResult)result 
				  error:(NSError *)error;
@end