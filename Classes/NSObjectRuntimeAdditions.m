//
//  NSObjectAdditions.m
//  objectiverest
//
//  Created by Roberto Gamboni on 5/5/09.
//  Copyright 2009 AT&T Interactive. All rights reserved.
//

#import "NSObjectRuntimeAdditions.h"
#import "objc/runtime.h"

@interface NSObject()

+ (NSString *) getPropertyType:(NSString *)attributeString;

@end

@implementation NSObject (Openovo_Runtime)

/**
 * Get the names of all properties declared on this class.
 */
+ (NSArray *)propertyNames {
	return [[self propertyNamesAndTypes] allKeys];
}

/**
 * Get the names of all properties and their types declared on this class.
 *
 */
+ (NSDictionary *)propertyNamesAndTypes {
	NSMutableDictionary *propertyNames = [NSMutableDictionary dictionary];
	
	//include superclass properties
	Class currentClass = [self class];
	while (currentClass != nil) {
		// Get the raw list of properties
		unsigned int outCount;
		objc_property_t *propList = class_copyPropertyList(currentClass, &outCount);
		
		// Collect the property names
		int i;
		NSString *propName;
		for (i = 0; i < outCount; i++)
		{
			objc_property_t * prop = propList + i;
			NSString *type = [NSString stringWithCString:property_getAttributes(*prop) encoding:NSUTF8StringEncoding];
			propName = [NSString stringWithCString:property_getName(*prop) encoding:NSUTF8StringEncoding];
			[propertyNames setObject:[self getPropertyType:type] forKey:propName];
		}
		
		free(propList);
		currentClass = [currentClass superclass];
	}
	return propertyNames;
}

/**
 * Get all the properties and their values of this instance.
 **/
- (NSDictionary *)properties {
	return [self dictionaryWithValuesForKeys:[[self class] propertyNames]];
}

/**
 * Set this object's property values, overriding any existing
 * values.
 */
- (void)setProperties:(NSDictionary *)overrideProperties {
	for (NSString *property in [overrideProperties allKeys]) {
		[self setValue:[overrideProperties objectForKey:property] forKey:property];
	}
}

+ (NSString *) getPropertyType:(NSString *)attributeString {
	NSString *type = [NSString string];
	NSScanner *typeScanner = [NSScanner scannerWithString:attributeString];
	[typeScanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"@"] intoString:NULL];
	
	// we are not dealing with an object
	if([typeScanner isAtEnd]) {
		return @"NULL";
	}
	[typeScanner scanCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\"@"] intoString:NULL];
	// this gets the actual object type
	[typeScanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\""] intoString:&type];
	return type;
}

/**
 * Get the name of the class
 **/
- (NSString *)className {
	return NSStringFromClass([self class]);
}

@end
