//
//  Yelp.h
//  eat-here-or-there
//
//  Created by Dhananjay Suresh on 6/17/16.
//  Copyright © 2016 Dhananjay Suresh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSURLRequest+OAuth.h"
@import Firebase;
@interface Yelp : NSObject

/**
 Query the Yelp API with a given term and location and displays the progress in the log
 
 @param term: The term of the search, e.g: dinner
 @param location: The location in which the term should be searched for, e.g: San Francisco, CA
 */
- (void)queryBuisnesses:(NSDictionary *)params completionHandler:(void (^)(NSArray *jsonResponse, NSError *error))completionHandler;

/**
 Query the Yelp API with a given term and location and displays the progress in the log
 
 @param term: The term of the search, e.g: dinner
 @param location: The location in which the term should be searched for, e.g: San Francisco, CA
 */
- (void)queryTopBusinessInfo:(NSDictionary *)params completionHandler:(void (^)(NSDictionary *jsonResponse, NSError *error))completionHandler;

@end
