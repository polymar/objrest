//
//  Multipart.m
//  objectiverest
//
//  Created by Roberto Gamboni on 5/5/09.
//  Copyright 2009 AT&T Interactive. All rights reserved.
//

#import "Multipart.h"


@implementation Multipart

@synthesize boundary = __boundary;
static NSString* default_boundary = @"00p11o22l33y44m55a66r77";

- (id) init {
	self = [super init];
	if (self) {
		__formFields = [[NSMutableDictionary alloc] init];
		__fileFields = [[NSMutableDictionary alloc] init];
		self.boundary = default_boundary;
	}
	return self;
}

- (void)addString:(NSString *)stringData withFieldName:(NSString *)fieldName {
	NSDictionary *newFieldDictionary = [NSDictionary dictionaryWithObject:stringData  forKey:fieldName];
	[__formFields addEntriesFromDictionary:newFieldDictionary];
}

- (void)addFile:(NSString *)fileName withFieldName:(NSString *)fieldName {
	if([__fileFields objectForKey:fieldName] != nil){
		NSLog(@"Error: cannot insert the same fieldName twice.");
		return;
	}
	[__fileFields setObject:fileName forKey:fieldName];
}

- (NSString*) buildRequestBodyString {
	NSData* body = [self buildRequestBody];
	return [[[NSString alloc] initWithBytes:body.bytes length:body.length encoding:NSUTF8StringEncoding] autorelease];
}

- (NSData*)	  buildRequestBody {
	NSMutableData* body = [NSData data];
	
	[body appendData:[[NSString stringWithFormat:@"--%@\r\n", self.boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	// Add Form Fields
	NSArray* fieldKeys = [NSArray arrayWithArray:[__formFields allKeys]];
	
	NSEnumerator *formEnumerator = [fieldKeys objectEnumerator];
	id formObject;
	
	while (formObject = [formEnumerator nextObject]) {
		NSString *fieldKey = [NSString stringWithString:formObject];
		NSString *fieldData = [NSString stringWithString:[__formFields objectForKey:formObject]];
		
		[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", fieldKey] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[[NSString stringWithString:fieldData] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", self.boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	}
	
	NSArray* fileKeys = [NSArray arrayWithArray:[__fileFields allKeys]];
	
	NSEnumerator *fileEnumerator = [fileKeys objectEnumerator];
	id fileObject;
	while (fileObject = [fileEnumerator nextObject]) {
		NSString *fieldName = [NSString stringWithString:formObject];
		NSString *fileName = [NSString stringWithString:[__fileFields objectForKey:formObject]];
		
		// Add the File
		[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", fieldName, [fileName lastPathComponent]] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[NSData dataWithContentsOfFile:fileName]];
		[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", self.boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	}
	
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", self.boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	return body;
}

- (void) dealloc {
	[__fileFields release];
	[__formFields release];
	[__boundary release];
	[super dealloc];
}

@end
