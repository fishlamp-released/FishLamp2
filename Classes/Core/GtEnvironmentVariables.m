//
//	GtEnvironmentVariables.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/15/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtEnvironmentVariables.h"
#import "GtProperties.h"

@interface GtSharedEnvironmentVariableDictionary : NSObject {
	 NSMutableDictionary* m_dictionary;
	 BOOL m_enabled;
}
@property (readonly, retain, nonatomic) NSMutableDictionary* vars;
@property (readonly, assign, nonatomic) BOOL debugModeEnabled;

GtSingletonProperty(GtSharedEnvironmentVariableDictionary);

- (BOOL) isEnabled:(NSString*) name;

@end

@implementation GtSharedEnvironmentVariableDictionary

@synthesize vars = m_dictionary;
@synthesize debugModeEnabled = m_enabled;

- (id) init
{
	if((self = [super init]))
	{
		m_dictionary = [[NSMutableDictionary alloc] init];
		m_enabled = YES;
//		m_enabled = [self isEnabled:GtFishLampDebug] || (getenv([GtFishLampDebug cStringUsingEncoding:NSASCIIStringEncoding]) == nil);
	}
	
	return self;
}

-(void) dealloc
{
	GtReleaseWithNil(m_dictionary);
	GtSuperDealloc();
}

GtSynthesizeSingleton(GtSharedEnvironmentVariableDictionary);

- (BOOL) isEnabled:(NSString*) name
{
	@try
	{
		NSNumber* value = [m_dictionary objectForKey:name];
		if(!value)
		{
			const char* cvalue = getenv([name cStringUsingEncoding:NSASCIIStringEncoding]);
			if(cvalue && strlen(cvalue))
			{
				NSString* string = [NSString stringWithCString:cvalue encoding:NSASCIIStringEncoding];
				
				value = [NSNumber numberWithBool:[string boolValue]];
			}
			else
			{
				value = [NSNumber numberWithBool:NO];
			}	 
				
				
			[m_dictionary setObject:value forKey:name];
		}
		
		return [value boolValue];
	}
	@catch(NSException* ex)
	{
		NSLog(@"%@", [ex description]);
	}
		
	
	return NO;
}

@end
void GtSetBoolEnvironmentVariable(NSString* name, BOOL value)
{
	GtSharedEnvironmentVariableDictionary* sharedVars = [GtSharedEnvironmentVariableDictionary instance];
	
	@synchronized(sharedVars)
	{
		[sharedVars.vars setObject:[NSNumber numberWithBool:value] forKey:name];
	}
}

void GtSetEnvironmentVariable(NSString* name, NSString* value)
{
	GtSharedEnvironmentVariableDictionary* sharedVars = [GtSharedEnvironmentVariableDictionary instance];
	
	@synchronized(sharedVars)
	{
		[sharedVars.vars setObject:name forKey:name];
	}
}

int GtGetEnvironmentVariableInteger(NSString* name)
{
	GtSharedEnvironmentVariableDictionary* sharedVars = [GtSharedEnvironmentVariableDictionary instance];
	if(sharedVars.debugModeEnabled)
	{
		@synchronized(sharedVars)
		{
			NSNumber* value = [sharedVars.vars objectForKey:name];
			if(!value)
			{
				const char* cvalue = getenv([name cStringUsingEncoding:NSASCIIStringEncoding]);
				if(cvalue)
				{
					value = [NSNumber numberWithInt:atoi(cvalue)];
					
					[sharedVars.vars setObject:value forKey:name];
				}
				
			}
			
			return [value intValue];
		}
	}
	return 0;
}

BOOL GtTestBoolEnvironmentVariable(NSString* name)
{
	GtSharedEnvironmentVariableDictionary* sharedVars = [GtSharedEnvironmentVariableDictionary instance];
	if(sharedVars.debugModeEnabled)
	{ 
		@synchronized(sharedVars)
		{
		   return [sharedVars isEnabled:name];
		}
	}
	return NO;
	
}
