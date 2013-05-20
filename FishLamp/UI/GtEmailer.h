//
//  GtEmailer.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/12/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <MessageUI/MessageUI.h>

#import "GtManagedActionContext.h"

#define GT_JPEG_MIME_TYPE @"image/jpeg"
#define GT_TEXT_PLAIN_TYPE @"text/plain"

@interface GtEmailer : MFMailComposeViewController<MFMailComposeViewControllerDelegate> 
{
	NSString* m_subject;
	NSString* m_body;
	NSString* m_jpegAttachment;

	NSArray* m_toRecipients;
	
	NSData* m_attachment;
	NSString* m_attachmentMimeType;
	NSString* m_attachmentFileName;
	
	UIViewController* m_parentController;
	
	BOOL m_bodyIsHtml;
	id m_delegate;
	
	GtManagedActionContext* m_context;
    
    UIStatusBarStyle m_statusBarStyle;
    CGRect m_frame;
    
    MFMailComposeResult m_result;
    NSError* m_error;
}

@property (readwrite, assign, nonatomic) id delegate;

@property (readwrite, assign, nonatomic) BOOL bodyIsHtml;

@property (readwrite, assign, nonatomic) NSString* subject;
@property (readwrite, assign, nonatomic) NSString* body;

@property (readwrite, assign, nonatomic) NSArray* toRecipients;
// TODO: add cc/bcc recipients

// attachment
- (void) setAttachment:(NSData*) data
	          fileName:(NSString*) fileName
	          mimeType:(NSString*) mimeType;
              
@property (readonly, assign, nonatomic) NSData* attachment;
@property (readonly, assign, nonatomic) NSString* attachmentFileName;
@property (readonly, assign, nonatomic) NSString* attachmentMimeType;

// show/hide ui
- (void) composeEmail:(UIViewController*) parentController;
- (void) dismiss;
- (void) promptUserWithResults:(MFMailComposeResult)result 
		                 error:(NSError *)error;

@end

@protocol GtEmailerDelegate <NSObject>
@optional 

- (void) emailer:(GtEmailer *)controller 
	didFinishWithResult:(MFMailComposeResult)result 
	              error:(NSError *)error;
@end