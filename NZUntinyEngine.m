//
//  NZUntinyEngine.m
//  this objective-c class is deveoped to takde advantage of untiny.me web services
//  note that in order to use this class you have to get JSON classes of www.    .com configured 
//  Created by Nasser Al-Zahrani on 7/13/09.
//  Released under a BSD-style license. See License.txt



#import "NZUntinyEngine.h"

#define kServicesURL	@"http://untiny.me/api/1.0/services?format=json"

@implementation NZUntinyEngine


+ (NSString *)untinyURL:(NSString *)longURL
{
	NSString *urlString = [NSString stringWithFormat:@"http://untiny.me/api/1.0/extract?url=%@&format=json",longURL];
	NSURL *url = [NSURL URLWithString:urlString];
	NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url
															  cachePolicy:NSURLRequestReturnCacheDataElseLoad
														  timeoutInterval:30];
	[urlRequest setHTTPMethod:@"GET"];
	
	NSURLResponse *response;
	NSError *error;
	NSData *urlData = [NSURLConnection sendSynchronousRequest:urlRequest
											returningResponse:&response
														error:&error];
	
	NSString *resultString = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
	SBJSON *jsonParser = [SBJSON new];
	id result = [jsonParser objectWithString:resultString error:NULL];
	
	NSDictionary *dict = (NSDictionary *)result;
	if([resultString hasPrefix:@"{\"org_url"])
	{
		NSString *originalURL = [dict objectForKey:@"org_url"];
		return originalURL;
	}
	
    else if([resultString hasPrefix:@"{\"error"])
	{
		NSArray *array = (NSArray *)[dict objectForKey:@"error"];
		NSString *errorString = [array objectAtIndex:1];
		return errorString;
	}
	else {
		NSString *denied = @"Access Denied";
	    return denied;
	}
}

+ (NSArray *)fetchSupportedServices
{
	NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kServicesURL]
															  cachePolicy:NSURLRequestReturnCacheDataElseLoad
														  timeoutInterval:30];
	[urlRequest setHTTPMethod:@"GET"];
	
	NSURLResponse *response;
	NSError *error;
	NSData *urlData = [NSURLConnection sendSynchronousRequest:urlRequest
											returningResponse:&response
														error:&error];
	
	NSString *resultString = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
	SBJSON *jsonParser = [SBJSON new];
	id result = [jsonParser objectWithString:resultString error:NULL];
	NSDictionary *dict = (NSDictionary *)result;
	NSMutableArray *array = [NSMutableArray array];

	for (NSString *string in dict) {
		[array addObject:string];
	}

	return array;
}


-(void)dealloc
{
	[super dealloc];
}

@end
