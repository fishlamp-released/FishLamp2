//
//	FLDisplayFormatter.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/13/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

@interface NSObject (FLDisplayFormatter)
+ (NSString*) displayFormatterDataToString:(id) data; 
+ (id) displayFormatterStringToData:(NSString*) string;
- (NSString*) formattedStringForDisplay;
@end

