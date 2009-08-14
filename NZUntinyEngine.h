//
//  NZUntinyEngine.h
//  Secure URL
//  this helper class was created to take advantage of untiny.com serivce 
//
//  Created by Nasser Al-Zahrani on 7/13/09.
//  Released under a BSD-style license. See License.txt
//

#import <Foundation/Foundation.h>
#import "SBJSON.h"

@interface NZUntinyEngine : NSObject {
	
}

+ (NSArray  *)fetchSupportedServices;
+ (NSString *)untinyURL:(NSString *)longURL; 
@end
