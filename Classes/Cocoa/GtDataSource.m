//
//	GtDataSouce.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/26/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtDataSource.h"
#import "NSObject+Comparison.h"

GtSplitKeyPath GtSplitKeyPathFromString(NSString* keyPathString)
{
	GtSplitKeyPath keyPath;
	NSRange range = [keyPathString rangeOfString:@"."];
   
	if(range.length == 0)
	{
		keyPath.dataSourceKey = nil;
		keyPath.dataKey = GtRetain(GtAutorelease(keyPathString));
	}
	else 
	{
		keyPath.dataSourceKey = [keyPathString substringToIndex:range.location];
		keyPath.dataKey = [keyPathString substringFromIndex:range.location+1];
	}
   
	return keyPath;
}

@implementation GtDataSourceManager

@synthesize delegate = m_delegate;

- (NSDictionary*) dataSources
{
	return m_dataSources;
}

- (id) init
{
	if((self = [super init]))
	{
		m_dataSources = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_dataSources);
	GtSuperDealloc();
}

- (void) setDataSource:(id) dataSource forKey:(NSString*) key
{   
    GtAssertIsValidString(key);

    if(dataSource)
    {
        [m_dataSources setObject:dataSource forKey:key];
    }
    else
    {
        [m_dataSources removeObjectForKey:key];
    }
}

- (id) defaultDataSource
{	
	return [m_dataSources objectForKey:@""];
}

- (void) setDefaultDataSource:(id) dataSource
{
	[m_dataSources setObject:dataSource forKey:@""];
}

- (id) dataSourceForDataSourceKey:(NSString*) key
{
	return GtStringIsEmpty(key) ? self.defaultDataSource : [m_dataSources objectForKey:key];
}

- (id) dataSourceForKeyPath:(NSString*) keyPath
{
	GtSplitKeyPath path = GtSplitKeyPathFromString(keyPath);
	return [self dataSourceForDataSourceKey:path.dataSourceKey];
}

- (id) objectForKeyPath:(NSString*) keyPathString
{
	GtSplitKeyPath path = GtSplitKeyPathFromString(keyPathString);
	id dataSource = [self dataSourceForDataSourceKey:path.dataSourceKey];

	return dataSource ? [dataSource dataSourceManager:self objectForKey:path.dataKey] : nil;
}

- (void) setObject:(id) object forKeyPath:(NSString*) keyPathString fireDataChangedEvent:(BOOL) fire
{
	GtSplitKeyPath path = GtSplitKeyPathFromString(keyPathString);
	id dataSource = [self dataSourceForDataSourceKey:path.dataSourceKey];

	if(dataSource)
	{
		id previousValue = [dataSource dataSourceManager:self objectForKey:path.dataKey];
		GtRetain(previousValue);
		
		if(![[object class] objectIsEqual:object toObject:previousValue])
		{
			[dataSource dataSourceManager:self setObject:object forKey:path.dataKey];
				
			if(fire)
			{
				[m_delegate dataSourceManager:self dataChangedForKeyPath:keyPathString newValue:object previousValue:previousValue];
			}
		}
		
		GtRelease(previousValue);
	}
}

- (void) removeObjectForKeyPath:(NSString*) keyPath fireDataChangedEvent:(BOOL) fire
{
	GtSplitKeyPath path = GtSplitKeyPathFromString(keyPath);
	id dataSource = [self dataSourceForDataSourceKey:path.dataSourceKey];
	if(dataSource)
	{
		id previousValue = [dataSource dataSourceManager:self objectForKey:path.dataKey];
		GtRetain(previousValue);
			
		[dataSource dataSourceManager:self removeObjectForKey:path.dataKey];
		if(fire)
		{
			[m_delegate dataSourceManager:self dataRemovedForKeyPath:path.dataKey previousValue:previousValue];
		}
		
		GtRelease(previousValue);
	}
}

- (BOOL) objectExistsForKeyPath:(NSString*) keyPath
{
	GtSplitKeyPath path = GtSplitKeyPathFromString(keyPath);
	id dataSource = [self dataSourceForDataSourceKey:path.dataSourceKey];
	return dataSource ? [dataSource dataSourceManager:self objectExistsForKey:path.dataKey] : NO;
}

@end

@implementation NSMutableDictionary (GtAbstactedDataSourceAdaptor)

- (BOOL) dataSourceManager:(GtDataSourceManager*) dataSourceManager ownsObjectForKey:(id) key
{
	return [self objectForKey:key] != nil;
}

- (id) dataSourceManager:(GtDataSourceManager*) dataSourceManager objectForKey:(id) key
{	
	return [self objectForKey:key];
}
- (void) dataSourceManager:(GtDataSourceManager*) dataSourceManager setObject:(id) object forKey:(id) key
{
	[self setObject:object forKey:key];
}
- (void) dataSourceManager:(GtDataSourceManager*) dataSourceManager removeObjectForKey:(id) key
{
	[self removeObjectForKey:key];
}
- (BOOL) dataSourceManager:(GtDataSourceManager*) dataSourceManager objectExistsForKey:(id) key
{
	return [self objectForKey:key] != nil;
}
@end

@implementation NSObject (GtAbstactedDataSourceAdaptor)

- (BOOL) dataSourceManager:(GtDataSourceManager*) dataSourceManager ownsObjectForKey:(id) key
{
	return [self valueForKey:key] != nil; // TODO: not sure this is correct?
}

- (id) dataSourceManager:(GtDataSourceManager*) dataSourceManager objectForKey:(id) key
{	
	id outValue = nil;
//	// this works around a problem where keyValue encoding was boxing a long value incorrectly into a 32bit number.
//	
//	GtDataTypeStruct* dataInfo = [[self class] propertyDataTypeStructByName:key];
//	if(dataInfo)
//	{
//		outValue = GtPerformDataTypeStructGetter(self, dataInfo);
//	}
//	else
	{
		outValue = [self valueForKey:key];
	}
	
	return outValue;
}
- (void) dataSourceManager:(GtDataSourceManager*) dataSourceManager setObject:(id) object forKey:(id) key
{
	[self setValue:object forKey:key];
}
- (void) dataSourceManager:(GtDataSourceManager*) dataSourceManager removeObjectForKey:(id) key
{
	[self setValue:nil forKey:key];
}
- (BOOL) dataSourceManager:(GtDataSourceManager*) dataSourceManager objectExistsForKey:(id) key
{
	return [self valueForKey:key] != nil;
}
@end

//@implementation GtObject (GtDataSourceAdaptor)
//
//- (BOOL) dataSourceManager:(GtDataSourceManager*) dataSourceManager ownsObjectForKey:(id) key
//{
//	  return [[self dataDescriptors] objectForKey:key] != nil;
//}
//
//- (id) dataSourceManager:(GtDataSourceManager*) dataSourceManager objectForKey:(id) key
//{
//	  return [self objectForKey:key]; // this will create a default value if nil!
//}
//
//- (void) dataSourceManager:(GtDataSourceManager*) dataSourceManager setObject:(id) object forKey:(id) key
//{
//	  [self.objectData setObject:object forKey:key];
//}
//
//- (void) dataSourceManager:(GtDataSourceManager*) dataSourceManager removeObjectForKey:(id) key
//{
//	  [self.objectData removeObjectForKey:key];
//}
//
//- (BOOL) dataSourceManager:(GtDataSourceManager*) dataSourceManager objectExistsForKey:(id) key
//{
//	  return [self.objectData objectForKey:key] != nil;
//}
//
//@end

@implementation GtOrderedCollection (GtDataSourceAdaptor)

- (BOOL) dataSourceManager:(GtDataSourceManager*) dataSourceManager ownsObjectForKey:(id) key
{
	return [self objectForKey:key] != nil;
}

- (id) dataSourceManager:(GtDataSourceManager*) dataSourceManager objectForKey:(id) key
{
	return [self objectForKey:key]; // this will create a default value if nil!
}

- (void) dataSourceManager:(GtDataSourceManager*) dataSourceManager setObject:(id) object forKey:(id) key
{
	[self addOrReplaceObject:object forKey:key];
}

- (void) dataSourceManager:(GtDataSourceManager*) dataSourceManager removeObjectForKey:(id) key
{
	[self removeObjectForKey:key];
}

- (BOOL) dataSourceManager:(GtDataSourceManager*) dataSourceManager objectExistsForKey:(id) key
{
	return [self objectForKey:key] != nil;
}

@end


@implementation NSObject (GtKeyPath)
+ (NSString*) keyPathWithDataKey:(NSString*) dataKey
{
	return GtKeyPathStringMake(NSStringFromClass([self class]), dataKey);
}
+ (NSString*) dataSourceKey
{	
	return NSStringFromClass([self class]);
}

@end


