//
//  GtDictionaryData.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/19/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtDataContainer.h"

@interface GtDictionaryDataContainer : NSObject<GtDataContainerProtocol> {
@private
	id m_dictionary;
	id m_key;
}

@property (readwrite, assign, nonatomic) id dictionary;
@property (readwrite, retain, nonatomic) id key;

- (id) initWithKey:(id) key;
- (id) initWithDictionaryAndKey:(id) dictionary key:(id) key;

- (void) updateDataSource:(id) source;


+ (GtDictionaryDataContainer*) dictionaryDataContainerWithKey:(id) key;
+ (GtDictionaryDataContainer*) dictionaryDataContainer:(id) dictionary key:(id) key;

@end
