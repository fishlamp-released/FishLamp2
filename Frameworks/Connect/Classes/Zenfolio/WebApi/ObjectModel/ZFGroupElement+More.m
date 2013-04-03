//
//  ZFGroupElement+More.m
//  FishLamp
//
//  Created by Mike Fullerton on 12/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFGroupElement+More.h"
#import "NSString+MiscUtils.h"


@implementation ZFGroupElement (More)

- (NSNumber*) parentGroupId {
	return [self.ParentGroups lastObject];
}

- (NSString*) Caption
{
	return @"";
}

- (BOOL) isGalleryElement {
	return NO;
}

- (BOOL) isCollectionElement {
	return NO;
}

- (BOOL) isGroupElement {
	return NO;
}

- (NSString*) PageUrl {
	return nil;
}

- (NSDate*) ModifiedOn {
	return nil;
}

- (NSDate*) CreatedOn {
    return nil;
}

- (void) setModifiedOn:(NSDate*) date {
}

- (NSNumber*) VideoCount {
    return nil;
}

- (void) setPageUrl:(NSString*) url {
}

- (NSMutableArray*) ParentGroups {
	return nil;
}

- (NSArray*) Elements { 
    return nil;
}

- (NSNumber*) PhotoCount {
    return nil;
}

- (NSNumber*) GalleryCount {
    return nil;
}

- (NSNumber*) PhotoBytes {
    return nil;
}

- (NSNumber*) calculateGalleryCount {
    NSNumber* number = [self GalleryCount];
    return number ? number : [NSNumber numberWithInt:0];
}

- (NSNumber*) calculatePhotoCount {
    NSNumber* number = [self PhotoCount];
    return number ? number : [NSNumber numberWithInt:0];
}

- (NSNumber*) calculateVideoCount {
    NSNumber* number = [self VideoCount];
    return number ? number : [NSNumber numberWithInt:0];
}

- (NSNumber*) calculatePhotoBytes {
    NSNumber* number = [self PhotoBytes];
    return number ? number : [NSNumber numberWithInt:0];
}

- (void) setParentGroups:(NSMutableArray*) array {
}

- (ZFPhoto*) TitlePhoto {
	return nil;
}

- (ZFGroupElementType) groupElementType {
    return 0;
}

- (unsigned long long) PhotoBytesValue {
    return 0;
}   

- (NSString *)sizeText {
	return [NSString localizedStringForByteSize:self.PhotoBytesValue];
}

- (id) objectStorageKey_fl {
    return [NSString stringWithFormat:@"%d:%@", [self groupElementType], [self Id]];
}


//- (BOOL) visitAllElements:(FLGroupElementVisitor) visitor elementIndex:(NSUInteger*) elementIndex {
//
//    BOOL stop = NO;
//    visitor(self, (*elementIndex)++, &stop);
//    if(stop) {
//        return YES;
//    }
//    
//    for(id element in self.Elements) {
//        
//        if([element isGroupElement]) {
//            if([element visitAllElements:visitor elementIndex:elementIndex] ) {
//                return YES;
//            }
//        }
//        else {
//            visitor(element, (*elementIndex)++, &stop);
//            if(stop) {
//                return YES;
//            }
//        }
//    }
//    
//    return NO;
//}

//- (int) VideoCountValue {
//    return 0;
//}

- (NSString*) description {
    return [NSString stringWithFormat:@"%@: %@: %@", [super description], [self Title], [self Id]];
}


#if OSX
- (void) sort:(NSSortDescriptor*) descriptor {
}
#endif

@end


