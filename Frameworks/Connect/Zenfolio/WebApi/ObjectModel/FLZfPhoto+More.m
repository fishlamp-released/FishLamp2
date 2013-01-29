//
//	FLZfPhoto+More.m
//	MyZen
//
//	Created by Mike Fullerton on 2/26/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLZfPhoto+More.h"

@implementation FLZfPhoto (More)

- (NSString*) displayName {
	return FLStringIsNotEmpty(self.Title) ? self.Title : self.FileName;
}

- (BOOL) isFullVersion {
	return FLStringIsNotEmpty(self.FileName);
}

- (BOOL) isFullyDownloaded {
    return  self.isFullVersion &&
                // this is hinky. what if the caption is legit empty?? this is some historical thing. 
                (   ([self.Flags rangeOfString:@"HasCaption"].length > 0) && 
                    FLStringIsNotEmpty(self.Caption));  
}

- (BOOL) isStaleComparedTo:(int) anotherTextCn 
                  sequence:(NSString*) sequence {
    return  (self.TextCnValue < anotherTextCn) ||  // we have old version, download new one
            (sequence && FLStringsAreNotEqual(sequence, self.Sequence)) ||
            ![self isFullyDownloaded];

}

- (BOOL) isStaleComparedToPhoto:(FLZfPhoto*) photo {
    FLAssert_v(photo.IdValue == self.IdValue, @"photos have different ids");
    
    return [self isStaleComparedTo:photo.TextCnValue sequence:photo.Sequence];
}

@end
