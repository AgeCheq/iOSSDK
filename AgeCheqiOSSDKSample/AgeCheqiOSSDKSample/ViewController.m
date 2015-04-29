//
//  ViewController.m
//  AgeCheqiOSSDKSample
//
//  Created by Andrew Smith on 4/29/15.
//  Copyright (c) 2015 ___AGECHEQ___. All rights reserved.
//

#import "ViewController.h"
#import "AgeCheqLib.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtAgeCheqID;
@property (weak, nonatomic) IBOutlet UITextField *txtAssociatedData;

@end

@implementation ViewController

@synthesize txtAgeCheqID, txtAssociatedData;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _aclib = [[AgeCheqLib alloc]init];
    _aclib.delegate = self;
    
    
    txtAgeCheqID.placeholder = @"Enter your AgeCheq PIN";
    txtAssociatedData.placeholder = @"Data to Associate";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)doCheck:(id)sender {

    //exercise the check method
    
    [_aclib check:@"06c3a8ba-8d2e-429c-9ce6-4f86a70815d6" appid:@"fc1b3f6b-567d-4a3a-8320-91614996c95e" acpin:txtAgeCheqID.text];
    
}


- (IBAction)doAssociate:(id)sender {

    //exercise the associate method

    [_aclib associateData:@"06c3a8ba-8d2e-429c-9ce6-4f86a70815d6" appid:@"fc1b3f6b-567d-4a3a-8320-91614996c95e" acpin:txtAgeCheqID.text data:txtAssociatedData.text];
    
}


//--------------------------------
// AgeCheq Delegate Responses
//--------------------------------


-(void)checkResponse:(NSString*)rtn msg:(NSString*)rtnmsg apiversion:(NSInteger)apiversion
checktype:(NSInteger)checktype
appauthorized:(BOOL) appauthorized
appblocked:(BOOL) appblocked
parentverified: (NSInteger) parentverified
under13:(BOOL) under13
under18:(BOOL) under18
underdevage:(BOOL) underdevage
trials:(NSInteger) trials;
{
    
    NSLog(@"in Check Response");
    
    if (checktype == 0)
    {
        NSLog(@"Normal check call");
    }
    
    if (checktype == 1)
    {
        NSLog(@"Normal check as a result of a throttled call");
    }
    
    if (checktype == 2)
    {
        NSLog(@"All data forced to \"allow\" as a result of a throttled call");
    }

    if (parentverified == 0)
    {
        NSLog(@"Parent Not Verified as an Adult");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Parent Not Verified" message:@"Please ask your parent to verify that they are an adult using the AgeCheq Parent Dashboard at http://parent.agecheq.com." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert setTag:11];
        [alert show];
        
    }
    else
    {
        if (parentverified == 1)
        {
            NSLog(@"Parent fully verified via payment or form");
        }
        if (parentverified == 2)
        {
            NSLog(@"Partially verified via EmailPlus, SMS, or VOIP");
        }
        if (parentverified == 3)
        {
            NSLog(@"All data forced to \"allow\" as the result of a trial call and the trials value will be incremented");
        }
        
        if (appauthorized==NO)
        {
            //[self showUserView:@"UNAUTHORIZED"];
            NSLog(@"This app has not been authorized by a parent yet");
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"App Not Authorized" message:@"This app has not yet been authorized by a parent.  Log into your Parent Dashboard account to view this app's Privacy Disclosure and give it your approval." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert setTag:11];
            [alert show];
            
        }
        else
        {
            if (appblocked==YES)
            {
                //[self showUserView:@"APPBLOCKED"];
                NSLog(@"This application has been blocked");
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"App Blocked" message:@"This app has been approved but it is temporarily blocked." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert setTag:11];
                [alert show];
            }
            else
            {
                NSLog(@"This app has been authorized");
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"App Authorized" message:@"This app has been authorized." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert setTag:11];
                [alert show];
            }
        }
        
        if (under13 == YES)
        {
            NSLog(@"This child is currently under the age of thirteen");
        }
        
        if (under18 == YES)
        {
            NSLog(@"This child is currently under the age of eighteen");
        }
        
        if (checktype == 2)
        {
            NSLog(@"This user has made %ld trials", (long)trials );
            
        }


    }
     
}


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


@end
