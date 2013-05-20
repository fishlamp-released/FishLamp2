//
//	GtDataTypeManager.h
//	PackMule
//
//	Created by Mike Fullerton on 11/19/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>


@interface GtDataTypeManager : NSObject {
@private
	NSMutableDictionary* m_dataTypes;
}

GtSingletonProperty(GtDataTypeManager);

- (void) setDataTypes:(NSMutableDictionary*) dataTypes forClass:(Class) aClass;
- (NSMutableDictionary*) dataTypesForClass:(Class) aClass;

@end
