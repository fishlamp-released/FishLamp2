//
//  FLZfGroupElement+More.m
//  FishLamp
//
//  Created by Mike Fullerton on 12/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZfGroupElement+More.h"

@implementation FLZfGroupElement (More)


- (NSNumber*) parentGroupId
{
	return [self.ParentGroups lastObject];
}

- (NSString*) Caption
{
	return @"";
}

- (NSArray*) elements {
    return nil;
}

- (BOOL) isGalleryElement
{
	if([self isKindOfClass:[FLZfPhotoSet class]])
	{
		FLZfPhotoSet* set = (FLZfPhotoSet*) self;
		
		FLAssertStringIsNotEmpty_(set.Type);

		return set.TypeValue == FLZfPhotoSetTypeGallery;
	}

	return NO;
}

- (BOOL) isCollectionElement
{
	if([self isKindOfClass:[FLZfPhotoSet class]])
	{
		FLZfPhotoSet* set = (FLZfPhotoSet*) self;
		
		FLAssertStringIsNotEmpty_(set.Type);
		
		return set.TypeValue == FLZfPhotoSetTypeCollection;
	}

	return NO;
}

- (BOOL) isGroupElement
{
	return [self isKindOfClass:[FLZfGroup class]];
}

// here for polymorphic use, overriden in FLZfPhotoSet and FLZfGroup
- (NSString*) PageUrl
{
	return nil;
}

// here for polymorphic use, overriden in FLZfPhotoSet and FLZfGroup
- (NSDate*) ModifiedOn
{
	return nil;
}

- (void) setModifiedOn:(NSDate*) date
{
}

// here for polymorphic use, overriden in FLZfPhotoSet and FLZfGroup
- (void) setPageUrl:(NSString*) url
{
}

- (NSMutableArray*) ParentGroups
{
	return nil;
}

- (void) setParentGroups:(NSMutableArray*) array
{
}

- (FLZfPhoto*) TitlePhoto
{
	return nil;
}

- (FLZfGroupElementType) groupElementType {
    
    return [self isGroupElement] ? FLZfGroupElementTypeGroup :
                [self isGalleryElement] ? FLZfGroupElementTypeGallery : FLZfGroupElementTypeCollection;
}

- (NSString*) title {
    return self.Title;
}

- (NSString *)sizeText {
	return FLZfSizeString([self photoBytes]);
}
//const NSString *dateFormat = @"%Y-%m-%dT%H:%M:%S.0000000%z";
//		NSString *createdStr = [entryDict valueForKey:@"CreatedOn"];
//		[self setCreatedOn:[NSCalendarDate dateWithString:createdStr calendarFormat:dateFormat]];
//		NSString *modifiedStr = [entryDict valueForKey:@"ModifiedOn"];
//		[self setModifiedOn:[NSCalendarDate dateWithString:modifiedStr calendarFormat:dateFormat]];
//		

- (NSDate*) CreatedOn {
    return nil;
}

-(NSDate*) createdOn {
    return self.CreatedOn;
}

-(NSDate*) modifiedOn {
    return self.ModifiedOn;
}

- (int) groupElementID {
    return self.IdValue;
}

- (NSNumber*) PhotoCount {
    return nil;
}

- (int) photoCount {
	return [[self PhotoCount] intValue];
}

- (int) galleryCount {
    __block int count = 0;
    [self visitAllElements:^(FLZfGroupElement* element, BOOL* stop) {
        if(!element.isGroupElement) {
            ++count;
        }
    }];
    
    return count;
}

- (BOOL) visitAllElements:(void (^)(FLZfGroupElement* element, BOOL* stop)) visitor {

    for(id element in self.elements) {
    
        if([element isGroupElement]) {
            if([element visitAllElements:visitor]) {
                return YES;
            }
        }
    
        BOOL stop = NO;
        visitor(element, &stop);
        
        if(stop) {
            return YES;
        }
        
    }
    
    return NO;
}

- (int) VideoCountValue {
    return 0;
}

- (unsigned long long) photoBytes {
	return 0;
}

- (int) videoCount {
    return 0;
}


@end