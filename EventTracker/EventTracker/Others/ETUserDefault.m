//
//  ETUserDefault.m
//  EventTracker
//
//  Created by Arshad T P on 3/25/15.
//  Copyright (c) 2015 Ab'initio. All rights reserved.
//

#import "ETUserDefault.h"
#define ET_DAFAULT_PREFIX @"EY_KEY"
@implementation ETUserDefault

+ (NSString *) getCurrentUserName {
	
	return [self getValueFromUserDefaultForKey:CURRENT_USER_KEY];
}
+ (void) setCurrentUser:(NSString *) userName {
	[self setValue:userName inUserDefaultForKey:CURRENT_USER_KEY];
}

// append HPL_Default_Prefix to all HPL custom defaults so that it can be cleared at once
+(NSString *) getETFormatedKeyForKey:(NSString *) key {
	return [NSString stringWithFormat:@"%@%@",ET_DAFAULT_PREFIX,key];
}

+(void) setValue:(id) value inUserDefaultForKey:(NSString *) key {
	
	[[NSUserDefaults standardUserDefaults] setValue:value forKey:[self getETFormatedKeyForKey:key]];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id) getValueFromUserDefaultForKey:(NSString *) key {
	
	return [[NSUserDefaults standardUserDefaults] valueForKey:[self getETFormatedKeyForKey:key]];
}


@end
