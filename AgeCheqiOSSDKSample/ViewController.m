//
//  ViewController.m
//  AgeCheqiOSSDKSample
//
//  Created by Andrew Smith on 6/12/14.
//  Copyright (c) 2014 ___AGECHEQ___. All rights reserved.
//

#import "ViewController.h"
#import "AgeCheqLib.h"

#define developer_key @"ENTER_DEVELOPER_KEY_HERE"
#define application_key @"ENTER_APPLICATION_ID_HERE"

NSString *DeviceID = @"";
NSString *ParentDashboardID = @"";

@interface ViewController()

//set up the edit fields
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *txtDOBYear;
@property (weak, nonatomic) IBOutlet UITextField *txtDOBMonth;
@property (weak, nonatomic) IBOutlet UITextField *txtDOBDate;

@property (weak, nonatomic) IBOutlet UITextField *txtKey;
@property (weak, nonatomic) IBOutlet UITextField *txtValue;


@end


@implementation ViewController

@synthesize username, txtDOBYear,txtDOBMonth, txtDOBDate, txtKey, txtValue;




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    // Get Instance of AgeCheq Lib
    _acb = [[AgeCheqLib alloc]init];
    _acb.delegate = self;
    
    
    username.placeholder = @"Enter your AgeCheq Parent Dashboard Username";
    txtDOBYear.placeholder = @"Year of Birth";
    txtDOBMonth.placeholder = @"Month of Birth";
    txtDOBDate.placeholder = @"Date of Birth";
    txtKey.placeholder = @"Enter the key";
    txtValue.placeholder = @"Enter the value";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)doIsRegistered:(id)sender {
    
    //get the vendor id for the particular device
    DeviceID = [[[UIDevice currentDevice]identifierForVendor]UUIDString];
    
    [_acb isRegistered:developer_key deviceid:DeviceID];
    
}

- (IBAction)doRegister:(id)sender {
    
    //get the vendor id for the particular device to use as a device id
    DeviceID = [[[UIDevice currentDevice]identifierForVendor]UUIDString];
    
    NSString *device_name = @"Brand New iOS Device";
    
    NSString *user_name = self.username.text;
    
    [_acb register:developer_key deviceid:DeviceID devicename:device_name username:user_name];
}

- (IBAction)doCheck:(id)sender {
    
    //get the vendor id for the particular device to use as a device id
    DeviceID = [[[UIDevice currentDevice]identifierForVendor]UUIDString];
    
    [_acb check:developer_key deviceid:DeviceID appid:application_key];
    
    
}

- (IBAction)doAgegate:(id)sender {
    
    //get the vendor id for the particular device to use as a device id
    DeviceID = [[[UIDevice currentDevice]identifierForVendor]UUIDString];
    
    [_acb agegate:developer_key deviceid:DeviceID dobyear:self.txtDOBYear.text dobmonth:self.txtDOBMonth.text doyday:self.txtDOBDate.text];
    
    
}

- (IBAction)doAssociateData:(id)sender {
    
    //get the vendor id for the particular device to use as a device id
    DeviceID = [[[UIDevice currentDevice]identifierForVendor]UUIDString];
    

    [_acb associateData:developer_key deviceid:DeviceID appid:application_key key:self.txtKey.text value:self.txtValue.text];
    
    
}


//--------------------------------
// AgeCheq Delegate Responses
//--------------------------------


-(void)associateDataResponse:(NSString *)rtn msg:(NSString *)rtnmsg {
    
    NSLog(@"associateDataResponse");
    
    if ([rtn isEqual:@"fail"])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Data Association Failed" message:rtnmsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert setTag:11];
        [alert show];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Data Successfully Associated" message:@"This data was associated wtih this device" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert setTag:11];
        [alert show];
    }
    
}

-(void)agegateResponse:(NSString *)rtn msg:(NSString *)rtnmsg {
    
    NSLog(@"agegateResponse");
    
    if ([rtn isEqual:@"fail"])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Age Gate Information Not Saved" message:rtnmsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert setTag:11];
        [alert show];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Information Saved" message:@"The age gate information was successfully stored for this device" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert setTag:11];
        [alert show];
    }
}


-(void)isRegisteredResponse:(NSString *)rtn msg:(NSString *)rtnmsg agecheq_deviceregistered:(BOOL)agecheq_deviceregistered agegate_deviceregistered:(BOOL)agegate_deviceregistered

{
    NSLog(@"IsRegisteredResponse");
    
    if (agecheq_deviceregistered==YES)
    {
        NSLog(@"This device is registered");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Device Registered" message:@"This device is registered to a Parent Dashboard account" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert setTag:11];
        [alert show];
    }
    else
    {
        NSLog(@"This device is NOT registered");
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Device NOT Registered" message:@"This device is not registered" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert setTag:11];
        [alert show];
        
    }
    
}


-(void)registerResponse:(NSString *)rtn msg:(NSString *)rtnmsg
{
    if ([rtn isEqual:@"fail"])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Device Registration Failed" message:rtnmsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert setTag:11];
        [alert show];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Device Successfully Registered" message:@"This device was successfully registered" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert setTag:11];
        [alert show];
    }
}


-(void)checkResponse:(NSString *)rtn msg:(NSString *)rtnmsg checktype:(NSInteger)checktype agecheq_deviceregistered:(BOOL)agecheq_deviceregistered agecheq_appauthorized:(BOOL)agecheq_appauthorized agecheq_appblocked:(BOOL)agecheq_appblocked agecheq_parentverified:(NSInteger)agecheq_parentverified agecheq_under13:(BOOL)agecheq_under13 agecheq_under18:(BOOL)agecheq_under18 agecheq_underdevage:(BOOL)agecheq_underdevage agecheq_trials:(int)agecheq_trials agegate_deviceregistered:(BOOL)agegate_deviceregistered agegate_under13:(BOOL)agegate_under13 agegate_under18:(BOOL)agegate_under18 agegate_underdevage:(BOOL)agegate_underdevage associateddata:(NSString *)associateddata
{
    
    if (agecheq_deviceregistered==NO)
    {
        NSLog(@"Device is not registered");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Device Not Registered" message:@"This device has not yet been registered" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert setTag:11];
        [alert show];
        
    }
    else
    {
        
        //return any associate data information
        NSLog(@"associateddata: %@",associateddata);
        
        //display any agegate information if there is some
        if (agegate_deviceregistered==YES) {
            
            NSLog(@"There is age information collected from an agegate for this device: %hhd@",agegate_deviceregistered);
            NSLog(@"Does the age information indicate that the user is under 13?: %hhd",agegate_under13);
            NSLog(@"Does the age information indicate that the user is under 18?: %hhd@",agegate_under18);
            NSLog(@"Does the age information indicate that the user is under the developer-set value?: %hhd@",agegate_underdevage);
            
            
        }
    
        
        if (agecheq_appauthorized==NO)
        {
            //[self showUserView:@"UNAUTHORIZED"];
            NSLog(@"This app has not been authorized by a parent yet");
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"App Not Authorized" message:@"This app has not yet been authorized by a parent.  Log into your Parent Dashboard account to view this app's Privacy Disclosure and give it your approval." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert setTag:11];
            [alert show];
            
        }
        else
        {
            if (agecheq_appblocked==YES)
            {
                //[self showUserView:@"APPBLOCKED"];
                NSLog(@"This application has been blocked");
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"App Blocked" message:@"This app has been approved but it is temporarily blocked." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert setTag:11];
                [alert show];
            }
            else
            {
                NSLog(@"This application has been authorized");
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"App Authorized" message:@"This app has been authorized." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert setTag:11];
                [alert show];
            }
        }
    }
}


@end
