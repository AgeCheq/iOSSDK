//
//  AgeCheqLib.h
//  AgeCheqLib
//
//  Copyright (c) 2015 AgeCheq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AgeCheqLib;

// Return Protocol
@protocol AgeCheqDelegate <NSObject>

@required

@optional

-(void)checkResponse:(NSString*) rtn
                msg:(NSString*) rtnmsg
                apiversion:(NSInteger) apiversion
                checktype:(NSInteger) checktype
                appauthorized:(BOOL) appauthorized
                appblocked:(BOOL) appblocked
                parentverified:(NSInteger) parentverified
                under13:(BOOL) under13
                under18:(BOOL) under18
                underdevage:(BOOL) underdevage
                trials:(NSInteger) trials;

-(void)associateDataResponse:(NSString*)rtn msg:(NSString*)rtnmsg;

@end

// Interface Methods
@interface AgeCheqLib : NSObject

@property (nonatomic, weak) id <AgeCheqDelegate> delegate;

-(void) check:(NSString*)DeveloperKey appid:(NSString*)AppID acpin:(NSString*)ACPin;
-(void) associateData:(NSString *)DeveloperKey appid:(NSString *)AppID acpin:(NSString*)ACPin data:(NSString *)Data;

@end
