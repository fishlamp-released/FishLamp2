//
//	FLDisplayFormatter.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/13/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

@interface NSObject (FLDisplayFormatter)
+ (NSString*) displayFormatterDataToString:(id) data; 
+ (id) displayFormatterStringToData:(NSString*) string;
- (NSString*) formattedStringForDisplay;
@end

