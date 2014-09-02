//
//  AgeCheqLib.h
//  AgeCheqLib
//
//  Created by Marc Smith on 2/17/14.
//  Copyright (c) 2014 AgeCheq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AgeCheqLib;

// Return Protocol
@protocol AgeCheqDelegate <NSObject>

@required

@optional

-(void)isRegisteredResponse:(NSString*)rtn
                msg:(NSString*)rtnmsg
                agecheq_deviceregistered:(BOOL)agecheq_deviceregistered
                agegate_deviceregistered:(BOOL)agegate_deviceregistered;

-(void)registerResponse:(NSString*)rtn msg:(NSString*)rtnmsg;

-(void)checkResponse:(NSString*)rtn
                msg:(NSString*)rtnmsg
                checktype:(NSInteger)checktype
                agecheq_deviceregistered:(BOOL)agecheq_deviceregistered
                agecheq_appauthorized:(BOOL)agecheq_appauthorized
                agecheq_appblocked:(BOOL)agecheq_appblocked
                agecheq_parentverified:(NSInteger)agecheq_parentverified
                agecheq_under13:(BOOL)agecheq_under13
                agecheq_under18:(BOOL)agecheq_under18
                agecheq_underdevage:(BOOL)agecheq_underdevage
                agecheq_trials:(int) agecheq_trials
                agegate_deviceregistered:(BOOL)agegate_deviceregistered
                agegate_under13:(BOOL)agegate_under13
                agegate_under18:(BOOL)agegate_under18
                agegate_underdevage:(BOOL)agegate_underdevage
                associateddata:(NSString*)associateddata;

-(void)associateDataResponse:(NSString*)rtn msg:(NSString*)rtnmsg;

-(void)agegateResponse:(NSString*)rtn msg:(NSString*)rtnmsg;

@end

// Interface Methods
@interface AgeCheqLib : NSObject

@property (nonatomic, weak) id <AgeCheqDelegate> delegate;

-(void) isRegistered:(NSString*)DeveloperKey deviceid:(NSString*)DeviceID;
-(void) register:(NSString*)DeveloperKey deviceid:(NSString*)DeviceID devicename:(NSString*)DeviceName username:(NSString*)UserName;
-(void) check:(NSString*)DeveloperKey deviceid:(NSString*)DeviceID appid:(NSString*)AppID;
-(void) associateData:(NSString *)DeveloperKey deviceid:(NSString *)DeviceID appid:(NSString*)AppID key:(NSString *)Key value:(NSString*)Value;
-(void) agegate:(NSString*)DeveloperKey deviceid:(NSString*)DeviceID dobyear:(NSString*)DOBYear dobmonth:(NSString*)DOBMonth doyday:(NSString*)DOBDay;

@end
