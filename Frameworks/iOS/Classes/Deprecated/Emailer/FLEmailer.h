//
//	FLEmailer.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/12/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <MessageUI/MessageUI.h>

#import "FLViewController.h"

#define FL_JPEG_MIME_TYPE @"image/jpeg"
#define FL_TEXT_PLAIN_TYPE @"text/plain"
@protocol FLEmailerDelegate;

@interface FLEmailer : NSObject<MFMailComposeViewControllerDelegate> {
@private

	NSString* _subject;
	NSString* _body;

	NSArray* _toRecipients;
	
	NSData* _attachment;
	NSString* _attachmentMimeType;
	NSString* _attachmentFileName;
	
	FLViewController* _parentController;
	
	BOOL _bodyIsHtml;
	__unsafe_unretained id<FLEmailerDelegate> _delegate;
	
	UIStatusBarStyle _statusBarStyle;
	CGRect _frame;
	
	MFMailComposeViewController* _emailController;
}

@property (readonly, assign, nonatomic) BOOL canSendMail;
@property (readwrite, assign, nonatomic) id<FLEmailerDelegate> delegate;
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
			  

- (BOOL) composeEmail:(FLViewController*) parentController; // return YES if can send email.

@end

@protocol FLEmailerDelegate <NSObject>
@optional 

- (void) emailer:(FLEmailer *)controller 
	didFinishWithResult:(MFMailComposeResult)result 
				  error:(NSError *)error;
@end