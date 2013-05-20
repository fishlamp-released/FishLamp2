//
//  CFStreamWrapper.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/22/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@protocol CFReadStreamWrapperDelegate;

@interface CFReadStreamWrapper : NSObject {
@private
    CFReadStreamRef m_readStream;
    id<CFReadStreamWrapperDelegate> m_delegate;
}

@property (readonly, assign, nonatomic) CFReadStreamRef readStreamRef;
@property (readwrite, assign, nonatomic) id<CFReadStreamWrapperDelegate> delegate;
@property (readonly, retain, nonatomic) NSError* error;

@property (readonly, assign, nonatomic) BOOL hasBytesAvaialable;
- (NSInteger)read:(uint8_t *)buffer maxLength:(NSUInteger)len;

- (id) initWithReadStreamRef:(CFReadStreamRef) ref;

- (void)scheduleInRunLoop:(NSRunLoop *)aRunLoop forMode:(NSString *)mode;
- (void)removeFromRunLoop:(NSRunLoop *)aRunLoop forMode:(NSString *)mode;

- (BOOL) open;
- (void) close;

@end

@protocol CFReadStreamWrapperDelegate <NSObject>
- (void) readStreamBytesAvailable:(CFReadStreamWrapper*) readStream;
- (void) readStreamEndEncountered:(CFReadStreamWrapper*) readStream;
- (void) readStreamOpenCompleted:(CFReadStreamWrapper*) readStream;
- (void) readStreamErrorOccurred:(CFReadStreamWrapper*) readStream;
- (void) readStreamCanAcceptBytes:(CFReadStreamWrapper*) readStream;
@end