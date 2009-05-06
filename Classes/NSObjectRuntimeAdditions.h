//
//  NSObjectAdditions.h
//  objectiverest
//
//  Created by Roberto Gamboni on 5/5/09.
//  Copyright 2009 AT&T Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Openovo_Runtime) 

/**
 * Get the names of all properties and their types declared on this class.
 *
 */
+ (NSDictionary *)propertyNamesAndTypes;

/**
 * Get the names of all properties declared on this class.
 */
+ (NSArray *)propertyNames;

/**
 * Get all the properties and their values of this instance.
 **/
- (NSDictionary *)properties;

/**
 * Set this object's property values, overriding any existing
 * values.
 */
- (void)setProperties:(NSDictionary *)overrideProperties;

/**
 * Get the name of the class
 **/
- (NSString *)className;

@end
