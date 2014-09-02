//
//  ViewController.h
//  AgeCheqiOSSDKSample
//
//  Created by Andrew Smith on 6/12/14.
//  Copyright (c) 2014 ___AGECHEQ___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AgeCheqLib.h"



@interface ViewController : UIViewController <AgeCheqDelegate>
{
    AgeCheqLib *_acb;
    NSString *DeviceID;
}

@end

