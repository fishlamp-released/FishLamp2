//
// GtObject.h
// FishLamp
//
// Copywrite 2010 GreentTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtStringBuilder.h"

@interface NSObject (GtStreamableObject)

//- (NSString*) debugDescription;
- (void) debugDescription:(NSString*) name stringBuilder:(GtStringBuilder*) stringBuilder;
- (BOOL) describeSelfToStringBuilder:(GtStringBuilder*) stringBuilder;

@end

