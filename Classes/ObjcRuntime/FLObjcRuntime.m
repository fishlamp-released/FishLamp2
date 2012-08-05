/*
 *  FLObjcRuntime.c
 *  PackMule
 *
 *  Created by Mike Fullerton on 6/29/11.
 *  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
 *
 */

#import "FLObjcRuntime.h"
#import <stdlib.h>
#import <string.h>
#import <stdio.h>

char* copyTypeNameFromProperty(objc_property_t property)
{
	const char* attr = property_getAttributes(property);
	
//	printf("%s", attr);
	
	for(int i = 0; attr[i] != 0; i++)
	{
		if(attr[i] == '@')
		{
			if(attr[i + 1] == '\"')
			{
				i += 2;
				
				for(int j = i; attr[j] != 0; j++)
				{
					if(attr[j] == '\"')
					{
						
						char* str = malloc(j - i + 1);
						strncpy(str, attr + i, j - i);
						str[j - i] = 0;
						
						return str;
					}
				}
			}
		}
	
	}

	return nil;
	
/*
objc_property_attribute_t* attrList = property_copyAttributeList(properties[i], &attrCount);
		for(unsigned int j = 0; j < attrCount; j++)
		{
			const char* value = attrList[j].value;
			const char* name = attrList[j].name;

			if(name[0] == 'T' && value[0] == '@')
			{
				int len = strlen(value);
				char* className = malloc(len);
				strncpy(className, value + 2, len - 3);
				className[len-3] = 0;
				
				Class c = objc_getClass(className);
					free(attrList);
	
*/
}

const char *getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T') {
            return (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
        }
    }
    return "@";
}