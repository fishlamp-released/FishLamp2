//
//	GtErrorDescription.h
//	FishLamp
//
//	Created by Mike Fullerton on 4/22/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@protocol GtErrorDescription <NSObject>
@property (readwrite, retain, nonatomic) NSString* title;
@property (readwrite, retain, nonatomic) NSString* description;
@property (readwrite, retain, nonatomic) NSError* error;
@end

@interface GtErrorDescription : NSObject<GtErrorDescription> {
@private
	NSError* m_error;
	NSString* m_title;
	NSString* m_description;
}
- (id) initWithTitle:(NSString*) title description:(NSString*) description;
+ (GtErrorDescription*) errorDescription;
+ (GtErrorDescription*) errorDescriptionWithTitle:(NSString*) title description:(NSString*) description;
@end